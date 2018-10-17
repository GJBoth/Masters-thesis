# Data processing pipeline

In this chapter we present the workflow we have developed to fit a model to spatiotemporal data, specifically data from the RUSH experiments. The pipeline can be divided into four steps, including preprocessing:

* **Step 1 - Segmentation:** segmenting the movies into several areas of interest.
* **Step 2 - Denoising and smoothing:** Denoising and smoothing the segmented data to prepare for the calculation of derivatives.
* **Step 3 - Spatial and temporal derivatives:** Calculating the spatial and temporal derivatives which will be used for fitting.
* **Step 4 - Fitting:** Actually fitting the model.

In the next sections, we describe each step separately. Note that the method we present here has been developed empirically: there's no theoretical background as to why this particular setup should work optimally. Instead, it's been developed while analyzing the data, adapting each step on the go. 

## Step 1 - Segmentation

Obtained images and movies often contain multiple cells. Each of these cells can be further segmented into two more areas of interest: the cytoplasm, which is were we want to fit our model and the Golgi apparatus. We wish to make a mask which allows us to separate the cells from the backgroud and themselves and divide each cell into cytoplasm or Golgi.

Figure @fig:threeframes shows the three frames of the MANII transport. Note that no sharp edges can be observed, especially once the MANII localizes in the Golgi. No bright field images were available as well, together making use of techniques such as described in @rizk_segmentation_2014 unavailable. We have thus developed two methods which allow us to segment the image and the cells, based on Voronoi diagrams and the intensity. 

![Three frames (t = , , ) showing a typical MANII cycle of the RUSH experiment.](source/figures/pdf/){#fig:threeframes}

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

![](){#fig:mask}

## Step 2 - Denoising

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

### WavinPOD {-}
WavinPOD combines these two techniques in the following way. First, we decompose our problem with a POD transformation. This yields a set of temporal and spatial modes. We select the most energetic modes and wavelet filter these, before transforming them back to the real domain. As shown in **ref**, combining these techniques has an advantage over others. 

In our case, we select the number of modes to be used by hand (30 in the case of MANII) and apply a 3-level db4 wavelet. We use a slightly higher than necessary level to increase smoothness. In the figure below we show the result for both a pixel in time and one time snapshot. Note that the result is significantly smoother, but that smaller details have been preserved.


## Step 3 - Derivatives
Taking spatial and temporal derivatives of these images is not an entirely trivial operation due to the discreteness of the system. More specifically, taking numerical derivatives of data is extremely hard to do properly and becomes even harder in the presence of noise. Next to basic finite difference methods, one can for example use a linear-least-squares fitted polynomial, smoothing spline or a so-called tikhonov-regularizer **ref needed**. Each method comes with its strengths and weaknesses, but one particularly nasty thing for our context is that they don't scale well to higher dimensions and quickly become computationally expensive.

Another issue related to discretization is the size of the grid w.r.t. the size of the features. To see this, we plot a 2D-gaussian with $\sigma=1$ in figure **ref**.

As expected, the derivative is normal to the isolines of the object. Now consider the discretized version of the object. Taking the naive spatial derivate w.r.t. to each direction means only considering a single row or column of and taking the derivative in that direction. Figure **ref** shows the result of this operation. An artifact is clearly visible: instead of a nice uniform derivative, we see a 'cross'. This effect is a cause of the discretization grid being too large for some smaller, often bright, objects. 

To remedy this, one can for example artificially upscale the grid, interpolate the values inbetween, and take the derivates from this grid. This is not ideal however, since the upscaling requires a large amount of memory and is computationally expensive. Another solution which is common in image processing is applying a *kernel operator*. The advantage of a kernel operator is that it is extremely computationally cheap, as it involves convolving the original picture with a differentiation kernel. The differentiation kernel is an approximate version of a finite difference scheme. We use and show here the Sobel filter, which is the most commonly used one. 

In a simple finite central difference scheme, we set

$$
\frac{dx}{dt}\approx\frac{x_{i+1}-x_{i-1}}{2h}
$$

where $h$ is the distance between two points. In terms of a kernel operator, this would look like (the $h$ drops out as the distance in terms of pixels is 1):

$$\frac{1}{2}\cdot
\begin{bmatrix}
1 & 0 & -1
\end{bmatrix}
$$

And applying it by convoluting it to a matrix gives the x-derivative:

$$
\partial_xA\approx A*\begin{bmatrix}
1 & 0 & -1
\end{bmatrix}
$$

and analogous for the y-direction. However, as we've seen, looking at just a single row introduces cross-like artifacts. To remedy this, we wish to include diagonal pixels as well. However, the distance between the diagonal pixels and the center pixel is not 1 but $\sqrt{2}$ and furthermore we need to decompose is it into $\hat{x}$ and $\hat{y}$, introducing another factor $\sqrt{2}$. Thus, one obtains the classis $3\times3$ Sobel filter **ref**:

$$
\mathbf G_x=\frac{1}{8}\cdot
\begin{bmatrix}
1 & 0 & -1\\
2 & 0 & -2\\
1 & 0 & -1
\end{bmatrix}
\mathbf G_y=\frac{1}{8}\cdot
\begin{bmatrix}
1 & 2 & 1 \\
0 & 0 & 0 \\
-1 & -2 & -1
\end{bmatrix}
$$

Although not extremely accurate, the Sobel filter seems to do the tricks for us. Several other versions such as Scharr or Prewitt exist, offering several benefits such as rotational symmetry, but we have not pursued these. They just change the coefficients. Although we have shown a $3\times3$ filter here, the filter can take into account higher order schemes such as a $5\times5$ or $7\times7$. The major benefit of the spatial derivatives as a convolution operator is its computational efficiency: convolutional operations are performed parallel and are extremely fast. 

For the time derivative, we apply a second order accurate central derivative scheme, while for the spatial derivatives (both first and second order) we apply the $5\times5$ Sobel filter. We analyze these in the next chapter .

## Step 4 - Fitting
Now that we have gathered all our data we can use it to fit. We construct a model (advection-diffusion) and then use a 'simple' least-squares fit to obtain an estimate of the diffusion and advection coefficients. We note two extra issues. First, a diffusion coefficient defined positive, i.e. a negative diffusion coefficient is unphysical. We thus make two different fits in the next chapter as a check: one with unconstrained variables, and one where we force $D>0$. 

Secondly, it's highly plausible that the diffusion coefficient and advection are position and time dependent. One could construct the full model for this and obtain both the coefficients and their derivatives, but its highly unlikely that this will lead to consistent results and it would still need to happen locally. We thus perform a 'moving-window-fit', where we set the width of the time and position window around a central pixel and assume that the diffusion and velocity are smooth and constant enough in that window to ensure a decent fit. In this, it's quite similar to a technique known in computer vision as optical flow.


## (Verification?)

