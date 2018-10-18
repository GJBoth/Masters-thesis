# Data processing pipeline

In this chapter we present the workflow we have developed to fit a model to spatiotemporal data, specifically data from the RUSH experiments. The pipeline can be divided into four steps, including preprocessing:

* **Step 1 - Denoising and smoothing:** Denoising and smoothing the data.
* **Step 2 - Spatial and temporal derivatives:** Calculating the spatial and temporal derivatives which will be used for fitting.
* **Step 3 - Segmentation:** segmenting the movies into several areas of interest.
* **Step 4 - Fitting:** Actually fitting the model.

In the next sections, we describe each step separately. Note that the method we present here has been developed empirically: there's no theoretical background as to why this particular setup should work optimally. Instead, it's been developed while analyzing the data, adapting each step on the go. 

![Four frames (t = , , ) showing a typical MANII cycle of the RUSH experiment.](source/figures/pdf/frames.pdf){#fig:threeframes}

## Step 1 - Denoising

In order to accurately calculate the derivatives and generally improve the quality of fitting, we wish to denoise and smooth the obtained movies. Denoising and smoothing is a subject about which many books have been written and there are hundreds of approaches. One oft-used technique is to Fourier transform the signal, cutoff all coefficients above a cutoff frequency and retransform back into the real domain. Next, a Savitzky-Golay filter can be used to finally smooth the result. However, a big issue with all these methods is their non locality. Since our movies have different scales, this is a big problem. Furthermore, they often smooth out sharp peaks. After evaluating several methods, I have settled on a relatively new method presented in **ref**.

The so-called WavinPOD method combines two well-known filtering techniques, known as wavelet filtering and Proper Orthogonal Decomposition. Below we explain each separately. Our explanation is adapted from **ref** and **ref**.


### Wavelet filter {-}
A wavelet filter is not really the appropriate name, as its more of a transform. 

**More about wavelet transform**

### Proper orthogonal decomposition {-}
Proper orthogonal decomposition is a technique similar to what is known as Principal component Analysis in statistics and falls into the general category of model reduction techniques. It's often used in flow problems to extract coherent structures from turbulent flows. Simply put, in POD we wish to express data as a sum of orthogonal functions, where the basis is determined from the data, i.e. we don't impose something as a fourier basis, etc..

$$
f(x,t)=\sum_k g(x)h(t)
$$

Basically we're trying to find the eigenfunctions of the data. Full explanation in paper **ref** Each eigenfunction comes with a eigenvalue, which can be interpreted as the energy of a mode. The higher the eigenvalue, the more important the mode is to the entire signal. To reduce the dimension of the data, we pick a cutoff $k_{max}$ and only use the modes $k<k_{max}$. Several methods are used to determine the cutoff, but often used is the knee-technique. When we plot the log10 spectrum in figure **ref**, one can often observe a 'knee'. Usually this point is taken as the cutoff.

![](source/figures/pdf/eigenspectrum.pdf){#fig:eigen}

### WavinPOD {-}
WavinPOD combines these two techniques in the following way. First, we decompose our problem with a POD transformation. This yields a set of temporal and spatial modes. We select the most energetic modes and wavelet filter these, before transforming them back to the real domain. As shown in **ref**, combining these techniques has an advantage over others. 

In our case, we select the number of modes to be used by hand (30 in the case of MANII) and apply a 3-level db4 wavelet. We use a slightly higher than necessary level to increase smoothness. In the figure below we show the result for both a pixel in time and one time snapshot. Note that the result is significantly smoother, but that smaller details have been preserved.

![](source/figures/pdf/filtered.pdf){#fig:filtered}

## Step 2 - Derivatives
After having denoised the images, we calculate the spatial and temporal derivatives. Obtaining correct numerical derivatives is hard and becomes much more so in the presence of noise [@bruno_numerical_2012]. Next to a finite-difference scheme, one can for example (locally) fit a polynomial and take its derivative or use a so-called tikhonov-regularizer [@knowles_methods_nodate]. The computational cost of these methods is high however and don't scale well to dimensions higher than one. For our spatial derivatives these methods are thus not available. In fact, obtaining the gradient of a 2D discrete grid has another subtlety which we need to adress.

Naively, one could obtain the gradient of a 2D grid by taking the derivative using a finite difference scheme with respect to the first and second axis. If there are features on the scale of the discretization ($\sim$ few pixels), such an operation will lead to artifacts and underestimate the gradient. These issues have long been known and several techniques have been developed to accurately calculate the gradient of an 'image'. The most-used one is the so-called Sobel operator. It belongs to a set of operations known as *kernel operators*. Kernel operators are expressed as a matrix and by convolving this matrix with the matrix on which the operation is to be performed, we obtain the result of the operator. We show this for the Sobel operator.

Consider a basic central finite difference scheme:

$$
\frac{df}{dx}\approx\frac{f(x_{i+1})-f(x_{i-1})}{2h}
$$

where $h$ is defined as $x_{i+1}-x_{i}$. In terms of a kernel operator, we rewrite this as:

$$\frac{1}{2}\cdot
\begin{bmatrix}
1 & 0 & -1
\end{bmatrix}
$$

where we have set $h=1$, as the distance between pixels is one by definition. By convolving this matrix with the matrix $A$ we obtain the derivative of $A$:

$$
\partial_xA\approx A*\frac{1}{2}\begin{bmatrix}
1 & 0 & -1
\end{bmatrix}
$$

![**Left panel:** One dimensional finite difference kernel. **Right panel:** Three by three Sobel filter](source/figures/pdf/derivative.pdf){#fig:sobel}

As stated, this operation is inaccurate and introduces artifacts. To improve this, we wish to include the pixels on the diagonal of the pixel we're performing the operation on as well (see figure @fig:sobel). The distance between the diagonal pixels and the center pixel is not 1 but $\sqrt{2}$ and the diagonal gradient also needs to be decomposed into $\hat{x}$ and $\hat{y}$, introducing another factor $\sqrt{2}$. The kernel thus obtained is the classic $3\times3$ Sobel filter:

$$
\mathbf G_x=\frac{1}{8}\cdot
\begin{bmatrix}
1 & 0 & -1\\
2 & 0 & -2\\
1 & 0 & -1
\end{bmatrix}
$$

Increasing the size of the Sobel filter increases its accuracy and we've implemented a 5x5 operator. Implementing the derivative operation as a kernel method is also beneficial from a computational standpoint, as convolutional operations are very efficient.

As the time derivative involves just one dimension, we make use of a second order accurate central difference scheme implemented in Numpy.

## Step 3 - Segmentation

Obtained images and movies often contain multiple cells. Each of these cells can be further segmented into two more areas of interest: the cytoplasm, which is were we want to fit our model and the Golgi apparatus. We wish to make a mask which allows us to separate the cells from the backgroud and themselves and divide each cell into cytoplasm or Golgi.

Figure @fig:threeframes shows four typical frames in the MANII transport cycle. Note that no sharp edges can be observed, especially once the MANII localizes in the Golgi. No bright field images were available as well, together making use of techniques such as described in @rizk_segmentation_2014 unavailable. We have thus developed two methods which allow us to segment the image and the cells, based on Voronoi diagrams and the intensity. 

### Voronoi diagram

Consider again the frame on the left of figure @fig:threeframes. Note that in early frames such as this one, the cargo (i.e. fluorescence) is spread circumnuclear. Applying a simple intensity based segmentation gives us a number of separate areas, which *very* roughly correspond to a cell. We can then pinpoint each cells' respective center. Given $n$ points, Voronoi tesselation divides the frame into $n$ areas, where point $i$ is the closest point for each position in area $A_i$. The hidden assumption here is thus that each pixel belongs to the cell center it's closest too. Although this is a very big assumption, in practice we've found this to be reasonable. Furthermore, one can add 'empty' points to make the diagram match observations. Assuming small movements of the cell, this isn't an issue either for this technique, as we are assigning an area to each cell instead of very precisely bounding it. This also allows us to calculate the Voronoi diagram in the early frames and apply the segmentation to the entire movie. The result of this segmentation for MANII is shown in figure @fig:voronoi. Each cell centre is denoted by a dot, while the lines denote the border between each voronoi cell. 

![](){#fig:voronoi}

### Intensity

The Voronoi technique works very well for an area-based approach, but for analyzing our fitting data we would like a more precise mask - although we still don't require pixel-level accuracy. From the movies, the Golgi is clearly visible and we can separate the cytoplasm from the background, with a big 'gray' area inbetween. We thus turn to an intensity based approach. We have developed the following approach for localizing the Golgi:

1. Normalize the intensity $I$ between 0 and 1.
2. Sum all the frames in time: $\sum_n I(x, y, t_n)$. A typical result is shown in figure @fig:mask. 
3. Threshold the image to obtain the mask. This is either done automatically through an Otsu threshold or by manually adjusting the threshold until desired result.
4. The mask is postprocessed by filling any potential holes inside the mask. 

This procedure was unable to reliably separate the background from the cytoplasm. Noting that while the cytoplasm might not have the intensity as the golgi, its time derivative should be higher than the rest of the areas. We replace step two by $\log_{10}\left(\sum_nI(x,y,t_n)\cdot\partial_tI(x,y,t_n)\right)$, where the time derivative has been normalized between 0 and 1. Figure @fig:mask shows our final results. The upper two panels show the images obtained after performing the summing operation for the Golgi and cytoplasm respectively, while the lower left panel shows the final mask obtained after thresholding these two images. For comparison, we plot frame to compare the mask to.

![](source/figures/pdf/segmenting.pdf){#fig:mask}

## Step 4 - Fitting
Now that we have gathered all our data we can use it to fit. We construct a model (advection-diffusion) and then use a 'simple' least-squares fit to obtain an estimate of the diffusion and advection coefficients. We note two extra issues. First, a diffusion coefficient defined positive, i.e. a negative diffusion coefficient is unphysical. We thus make two different fits in the next chapter as a check: one with unconstrained variables, and one where we force $D>0$. 

Secondly, it's highly plausible that the diffusion coefficient and advection are position and time dependent. One could construct the full model for this and obtain both the coefficients and their derivatives, but its highly unlikely that this will lead to consistent results and it would still need to happen locally. We thus perform a 'moving-window-fit', where we set the width of the time and position window around a central pixel and assume that the diffusion and velocity are smooth and constant enough in that window to ensure a decent fit. In this, it's quite similar to a technique known in computer vision as optical flow.


## (Verification?)

