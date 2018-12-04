# Model fitting

In this chapter we introduce the method we have developed for fitting a model in the form of a PDE to spatiotemporal data. We start with a section describing the general idea and subsequent sections elaborate on each step. The method  principaly works for any type of data and model, but was developed originally to analyze data from the RUSH experiments. We have chosen to illustrate the effects of each step with RUSH experimental data instead of synthetic data. 

## The concept

Assume we have acces to experimental data of some process $f(x,t)$. Parallely, we have also developed a model describing this process, but it is the form of a PDE:
$$
\partial_t f(x,t) = \lambda_1 \nabla^2f(x,t)+\lambda_2\nabla f(x,t) +\lambda_3 f(x,t) +\lambda_4
$$ {#eq:PDE}
We now wish to investigate if this model fits the data $f(x,t)$ and find the optimal value of coefficients $\lambda_i$. To do so, we consider each spatial term in $f(x,t)$ in [@eq:PDE] as some variable $x_i$ but $\partial_t f$ as $y$, so that we can rewrite it as:
$$
y = \lambda_1 x_1+\lambda_2x_2 +\lambda_3 x_3 +\lambda_4
$$

If we thus can find the variables $x_i$ and $y$, we can perform some fitting procedure such as least squares to obtain the coefficients $\lambda_i$. In other words, if we can calculate the spatial and temporal derivatives of our data, we can fit the model. Although the concept seems trivial, its implementation is all but. Data is rarely noiseless and obtaining accurate derivatives from noisy data is notoriously hard, but forms the heart of our method. It's also possible to have distinct models in different areas of the data, so that we need to segment the data. Furthermore, the coefficients $\lambda_i$ might not be constant but could be space- and time- dependent. The process of fitting the data thus has several steps:

1. Denoising and smoothing
2. Calculating derivatives
3. Segmenting
4. Fitting

In the next sections, we describe each step separately. Note that the method we present here has been developed empirically: there's no theoretical background as to why this particular combination should work optimally. Instead, it's been developed while analyzing the data, adapting each step on the go. However, we have found several parallel to another method from machine vision known as optical flow [@barron_performance_1994, @dong_motion_2006, @vig_quantification_2016].

## Step 1 - Smoothing and denoising

The first step in our pipeline is to denoise and smooth the data. The smoothing is necessary for accurately calculating the derivatives. Denoising still is a very active area of research (especially in life sciences) and dozens of different methods exist [@garcia_robust_2010, @de_vos_seeing_2016]. For example, one could Fourier transform the signal and use a high pass filter, but this would also get rid of small and sharp features. After evaluating several methods, we have settled on the so-called 'WavInPOD' method, introduced by @zimon_novel_2016 in 2016. In @zimon_evaluation_2016 they show that this methods outperforms several other advanced methods. WavInPOD combines Proper Orthogonal Decomposition (POD) with Wavelet filtering (Wav). Both subjects are vast (especially Wavelet transform) and we're only interested in the result of the technique, so we only present a short introduction here, adapted from @zimon_novel_2016. 

POD is a so-called dimensionality reduction technique and is very closely related to the more well-known Principal Component Analysis (PCA) in statistics. In physics it's ofen used to analyze turbulent flows[@grinberg_analyzing_2009, @grinberg_proper_2012]. In POD we wish to describe a function as a sum over its variables: 

$$
f(x,t)=\sum_n^r \alpha_n(x)\phi_n(t)
$$

where $\alpha_n$ and $\phi_n$ are called respectively the spatial and temporal modes. Associated with each mode $n$ is an energy-like quantity $E_n$. Modes with a higher 'energy' $E_n$ contribute more to the signal $f$ than modes with a lower energy and we can thus approximate the signal by selecting the $k$ modes with the highest energy. A typical log10 energy spectrum has a 'knee' in the values, as shown in figure @fig:eigen . Modes with an energy below the knee are noise, and modes above signal. 

![Caption.](source/figures/pdf/eigenspectrum.pdf){#fig:eigen}

The wavelet transform is very similar to the Fourier transform, but uses wavelets as its basis. A fourier transform gives the frequency domain with infinite precision, but tells nothing about the locality of the frequencies (.i.e when each frequency is present in a signal).
By using a wavelet (a wave whose amplitude is only non-zero for a finite time), we sacrifice precision in the frequency domain but gain information on the locality instead. Performing a wavelet transform transforms the signal into the sum of an approximation and its details and we can filter this analogous to a fourier filter. Due to its locality however, noise is filtered out, by sharpness is retained. 

WavinPOD combines these two techniques by applying wavelet filtering to the POD modes. In detail, one first decomposes the problem with a POD transformation. The energy spectrum of this transformation is shown in figure  @fig:eigen and we select a cutoff of 27. All retained modes are wavelet filtered and are then retransformed to give the denoised and smoothed signal. In figure @fig:filtered we show the results of the smoothing in the time and spatial domain. In the left panel we show the signal of a single pixel in time, while we plot a line of pixels in a single frame in the right panel. The red lines denote the original (unfiltered) signal, the blue line the effect of just applying a POD and the black one the result of the WavInPOD technique. Note that the effect of the wavelet filtering is to smooth the signal significantly and in comparing the original data to the filtered data that we've retained the sharpness of the features whilst obtaining a smooth signal.

![Effect of POD with a cutoff of 27 and wavelet filtering with a  level 3 db4 wavelet. Left panel shows the result in the time domain, right panel in the spatial domain. Lines have been offset for clarity.](source/figures/pdf/filtered.pdf){#fig:filtered}

## Step 2 - Derivatives
After having denoised the images, we calculate the spatial and temporal derivatives. Obtaining correct numerical derivatives is hard and becomes much more so in the presence of noise [@bruno_numerical_2012]. Next to a finite-difference scheme, one can for example (locally) fit a polynomial and take its derivative or use a so-called tikhonov-regularizer [@knowles_methods_nodate]. The computational cost of these methods is high however and they don't scale well to dimensions higher than one. For our spatial derivatives these methods are thus not available. In fact, obtaining the gradient of a 2D discrete grid has another subtlety which we need to adress.

Naively, one could obtain the gradient of a 2D grid by taking the derivative using a finite difference scheme with respect to the first and second axis. If there are features on the scale of the discretization ($\sim$ few pixels), such an operation will lead to artifacts and underestimate the gradient. These issues have long been known and several techniques have been developed to accurately calculate the gradient of an 'image'. The most-used image-gradient technique is the so-called Sobel operator. It belongs to a set of operations known as *kernel operators*. Kernel operators are expressed as a matrix and by convolving this matrix with the matrix on which the operation is to be performed, we obtain the result of the operator. We show this for the Sobel operator.

Consider a basic central finite difference scheme:

$$
\frac{df}{dx}\approx\frac{f(x_{i+1})-f(x_{i-1})}{2h}
$$

where $h$ is defined as $x_{i+1}-x_{i}$. In terms of a kernel operator, we rewrite this as 
$$
\frac{1}{2}\cdot
\begin{bmatrix}
1 & 0 & -1
\end{bmatrix}
$$
 By convolving this matrix with the matrix $A$ we obtain the derivative of $A$:
$$
\partial_xA\approx A*\frac{1}{2}\begin{bmatrix}
1 & 0 & -1
\end{bmatrix}
$$
![**Left panel:** One dimensional finite difference kernel. **Right panel:** Three by three Sobel filter](source/figures/pdf/derivative.pdf){#fig:Sobel}

As stated, this operation is inaccurate and introduces artifacts. To improve this, we wish to include the pixels on the diagonal of the pixel we're performing the operation on as well (see figure @fig:Sobel ). The distance between the diagonal pixels and the center pixel is not 1 but $\sqrt{2}$ and the diagonal gradient also needs to be decomposed into $\hat{x}$ and $\hat{y}$, introducing another factor $\sqrt{2}$. The kernel thus obtained is the classic $3\times3$ Sobel filter:where we have set $h=1​$, as the distance between pixels is one by definition.
$$
\mathbf G_x=\frac{1}{8}\cdot
\begin{bmatrix}
1 & 0 & -1\\
2 & 0 & -2\\
1 & 0 & -1
\end{bmatrix}
$$


Increasing the size of the Sobel filter increases its accuracy and we've implemented a 5x5 operator. Implementing the derivative operation as a kernel method is also beneficial from a computational standpoint, as convolutional operations are very efficient. The Sobel filter is usually applied to an image and hence is often said to calculate the image-gradient, but due to its separability is possibe to scale this method to an arbitrary number of dimensions.  

## Step 3 - Segmentation

In the case of the RUSH data, obtained images and movies often contain multiple cells. Each of these cells can be further segmented into two more areas of interest: the cytoplasm, which is were we want to fit our model and the Golgi apparatus. We wish to make a mask which allows us to separate the cells from the backgroud and themselves and divide each cell into cytoplasm or Golgi. Figure @fig:manII shows four typical frames in the MANII transport cycle. Note that no sharp edges can be observed, especially once the MANII localizes in the Golgi. No bright field images were available as well, together making use of techniques such as described in @rizk_segmentation_2014 unavailable. We have thus developed two methods which allow us to segment the image and the cells, based on Voronoi diagrams and the intensity. 

### Voronoi diagram

Consider again the frame on the left of figure @fig:manII Note that in early frames such as this one, the cargo (i.e. fluorescence) is spread circumnuclear. Applying a simple intensity based segmentation gives us a number of separate areas, which *very* roughly correspond to a cell. We can then pinpoint each cells' respective center. Given $n$ points, Voronoi tesselation divides the frame into $n$ areas, where point $i$ is the closest point for each position in area $A_i$. The hidden assumption here is thus that each pixel belongs to the cell center it's closest too. Although this is a very big assumption, in practice we've found this to be reasonable. Furthermore, one can add 'empty' points to make the diagram match observations. Assuming small movements of the cell, this isn't an issue either for this technique, as we are assigning an area to each cell instead of very precisely bounding it. This also allows us to calculate the Voronoi diagram in the early frames and apply the segmentation to the entire movie. The result of this segmentation for MANII is shown in figure @fig:voronoi. Each cell centre is denoted by a dot, while the lines denote the border between each voronoi cell. 

![The obtained mask. Red dots are cell centers, dashed lines infinite edges and solid lines finite edges.](source/figures/pdf/Voronoi.pdf){#fig:voronoi}

### Intensity

The Voronoi technique works very well for an area-based approach, but for analyzing our fitting data we would like a more precise mask - although we still don't require pixel-level accuracy. From the movies, the Golgi is clearly visible and we can separate the cytoplasm from the background, with a big 'gray' area inbetween. We thus turn to an intensity based approach. We have developed the following approach for localizing the Golgi:

1. Normalize the intensity $I$ between 0 and 1.
2. Sum all the frames in time: $\sum_n I(x, y, t_n)$. A typical result is shown in figure @fig:mask . 
3. Threshold the image to obtain the mask. This is either done automatically through an Otsu threshold or by manually adjusting the threshold until desired result.
4. The mask is postprocessed by filling any potential holes inside the mask. 

This procedure was unable to reliably separate the background from the cytoplasm. Noting that while the cytoplasm might not have the intensity as the golgi, its time derivative should be higher than the rest of the areas. We replace step two by $\log_{10}\left(\sum_nI(x,y,t_n)\cdot\partial_tI(x,y,t_n)\right)$, where the time derivative has been normalized between 0 and 1. Figure @fig:mask shows our final results. The upper two panels show the images obtained after performing the summing operation for the Golgi and cytoplasm respectively, while the lower left panel shows the final mask obtained after thresholding these two images. For comparison, we plot frame to compare the mask to.

![Four panels showing the different stages of making the mask. From segmenting the upper two panels we determine the golgi and active area, leading to the mask in the lower left. Compare the to the lower right.](source/figures/pdf/segmenting.pdf){#fig:mask}

## Step 4 - Fitting

The final step in our method is to fit the our model to the data. By calculating the derivatives, we have reduced our PDE-model to a generic model, which allows us to use virtually any fitting method. For simplicity, we use least-squares, but one could use a Bayesian method to obtain not only the fit, but also the uncertainty. 

 Equation @eq:PDE assumes a model with constant coefficients. In reality, coefficients will be spatially and even temporally varying. To circumvent this issue, we assume the coefficients can be assumed to be locally constant. We thus assume that for a small area we can fit the model using constant coefficients. We perform this operation for every datapoint in a sliding-window manner, as shown in figure @fig:slidingwindow, thus ending up with a coefficient field.

![Schematic overview of the sliding window technique. The solid black line encompasses an area around its blue coloured central pixel and the fit output is assigned to that pixel. We then move the window (dashed black line) and perform the fit for the orange coloured pixel.](source/figures/pdf/slidingwindow.pdf){#fig:slidingwindow}

In the next chapter we apply this method to the RUSH experimental data.

