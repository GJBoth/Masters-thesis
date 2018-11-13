# Physics Informed Neural Networks

In the previous chapters we showed the difficulties in fitting a model in the form of a partial differential equation to spatio-temporal data. The method we developed was a classical numerical approach, separating the problem into several substeps such as denoising, smoothing and numerical differentiation. In this chapter we present an alternative technique, generally referred to as Physics Informed Neural Networks (PINNs), which has already shown impressive performance in fitting models and numerically solving equations[@karpatne_physics-guided_2017], [@sharma_weakly-supervised_2018],[@pun_physically-informed_2018],[@raissi_physics_2017],[@raissi_physics_2017-1]. As neural networks are a new technique in phyics, this chapter also served as introduction to neural networks in general. The chapter thus has the following structure:

* **Neural Networks** - This part will cover the basics of neural networks: their inner workings, training and other general features. 
* **Physics Informed Neural networks** - In this second part we introduce the concept behind PINNs, use it to solve a toy problem and apply it to our RUSH data. 
* **Conclusion** - Finally we summarize the results and observations from the previous sections.

## Neural Networks
Normally when programming a computer to perform some task, we break the problem into smaller pieces and writing down precise instructions. Often, a model of the underlying process is also needed to transform some input into an output. The performance of the algorithm is then only as good as the underlying model and when dealing with complex processes, such models often become intractable or oversimplified. Artificial Neural Networks (ANNs) are a different approach to such a problem. Instead of being *programmed*, they are *trained* and hence 'learn' an underlying model. In a process known as *supervised learning*, the network is given inputs and the desired outputs for each input. Training the network then consists of adjusting its internal parameters until the predictions match the desired outputs. In the next sections we discuss how to adjust these parameters.

### Architecture
*An excellent introduction is given by Michael Nielsen in his freely available book "Neural networks and deep learning." The following section has been strongly inspired by his presentation.*

At the basis of each neural network lies the neuron. It transforms several inputs into an output in a two-step process. In the first step, the inputs $x$ are multiplied with a weight vector $w$ and a bias $b$ is added:
$$
z = w\mathbf{x}+b
$$
$z$ is called the weighted input and is transformed in the second step by the neuronal *activation function $\sigma$*. This gives the output of the neuron $a$, also known as the activation:
$$
a = \sigma(z) = \sigma(w\mathbf{x}+b)
$$ {#eq:activation}
The activation introduces non-linearity into the network and hence is crucial; without it a neural network would merely be several matrix multiplications. The classical activation is a tanh, i.e $\sigma(z)=\tanh(z)$, but many other forms exist, each having its benefits. Several neurons in parallel constitute a *layer* and several layers can be connected to create a network. The layers in the middle of the network are referred to as *hidden layers*. An example of such a network with two hidden layers is shown in figure @fig:neuralnetwork. 

![Schematic overview of a neural network. The left layer is known as the input layer, the right layer as the output layer and the layers inbetween are referred to as hidden layers.](source/figures/pdf/neuralnetwork.pdf){#fig:neuralnetwork}



### Training 

Consider again equation @eq:activation. In a network with multiple layers, it is useful to express the activation $a^l$ of layer $l$ in the activation of layer $l-1$, so that @eq:activation becomes :
$$
a^l = \sigma(z^l) = \sigma(w^la^{l-1}+b^l)
$$
where $w^l$ and $b^l$ are respectively the weight matrix and bias of layer $l$. As stated, training a neural network means adjusting the weights $w^l$ and biases of each layer  $b^{l}$ until the output of the neural network $a^L$ - the activation of the last layer $L$ - matches the desired output $y_i$. We thus require a metric to define the difference between the prediction and the desired output. This metric is known as the *cost function* $\mathcal{L}$ and one of the most commonly used cost functions is the mean squared error:
$$
\mathcal{L} = \frac{1}{2n}\sum_i|y_i-a^L_i|^2
$$ {#eq:MSE}

where $n$ is the number of samples, $y_i$ the desired output of sample $i$ and the prediction of the network given the inputs of sample $i$. As the cost function is a measure of the difference between the prediction and desired outputs, training a neural network comes down to minimizing the cost function. Such minimization problems are solved by gradient descent techniques.

Gradient descent techniques are based on the fact that given some position, the fastest way to reach the minimum from that position is by following the steepest descent. Thus, given a function $f(\mathbf{x})$ to minimize w.r.t to $\mathbf{x}$, we guess an initial position $x_n$ and iteratively update it until it converges:

$$
\mathbf{x}_{n+1} = \mathbf{x}_{n}-\gamma\nabla f(\mathbf{x}_n)
$$ {#eq:gradientdescent}

 $\gamma$ is known as the learning rate and sets the 'stepsize'. Although this is an iterative technique, if the minimization problem is convex (i.e. no local minima), gradient descent is guaranteed to converge to it. Note that gradient descent requires calculation of the derivative w.r.t to the variables of the function to be minimized. In other words, one needs to know the derivative of the cost function w.r.t each of the weights and biases in the network. A naive finite difference scheme would quickly grow computationally untractable, even for networks with just two hidden layers. Alternatives to gradient descent exist, but all require calculation of the derivatives. In the next section we present an algorithm which is able to efficiently calculate these derivatives. 

#### Back propagation and automatic differentiation {-}

In this section we introduce the so-called *backpropagation* algorithm. The backpropagation algorithm allows for the efficient calculation of the cost function derivatives in a neural network. For simplicity, we move away from a vector notation and introduce $w^l_{jk}$, the weight of the $k$-th neuron in layer $l-1$ to neuron $j$ in layer $l$ and $b^l_j$, the bias of the neuron $j$ in the $l$-th layer. We introduce the error of neuron $j$ in layer $l$ as:
$$
\delta^l_j=\frac{\partial C}{\partial z^l_j}
$$

We can rewrite this using the chain rule as:

$$
\delta^l_j = \sum_k \frac{\partial C}{\partial a^l_{k}}\frac{\partial a^l_{k}}{\partial z^l_{j}}
$$

The second term on the right is always zero except when $j=k$, so the summation can be dropped.  Given equation [@eq:activation], we note that $\partial a^l_{j}/\partial z^l_{j} = \sigma'(z^l_j)$. For the last layer $l = L$, we can directly calculate the derivative, resulting in:

$$
\delta^L_j =  |a^L_j-y_j|\sigma'(z^L_j)
$$ {#eq:backprop1}

Equation @eq:backprop1 relates the error in the output layer to its activation and weighted input. Again using the chain rule, we can express the error in a layer $l$, $\delta^{l}_j$ ,in terms of the error in the next layer, $\delta^{l+1}_j$:
$$
\delta^l_j = \sum_k \frac{\partial C}{\partial z^{l+1}_{k}}\frac{\partial z^{l+1}_{k}}{\partial z^l_{j}} = \sum_k \delta^{l+1}_k\frac{\partial z^{l+1}_{k}}{\partial z^l_{j}}
$$

Using equation @eq:weighted_input, we obtain after substitution:

$$
\delta^l_j = \sum_k\delta^{l+1}_kw^{l+1}_{kj}\sigma'(z^l_j)
$$ {#eq:backprop2}

Equation @eq:backprop1 gives us the error in the final layer, while equation @eq:backprop2 allows us to propagate the error back through the network - hence the algorithm is named backpropagation. Two more expressions are needed to relate the error in each neuron $\delta^l_j$ to the derivatives w.r.t. the weights and biases. Making use yet again of the chain rule gives the last two backpropagation relations:
$$
\frac{\partial C}{\partial b^l_{j}}\frac{\partial b^l_{j}}{\partial z^l_{j}}=\frac{\partial C}{\partial b^l_{j}}=\delta^l_j
$$ {#eq:backprop3}

$$
\delta^l_j=\sum_k\frac{\partial C}{\partial w^l_{jk}}\frac{\partial w^l_{jk}}{\partial z^l_{j}}\to \frac{\partial C}{\partial w^l_{jk}}=a^{l-1}_{k}\delta^l_j
$$ {#eq:backprop4}

Given the four fundamental backpropagation relations, we state the algorithm. It consists of four steps:

1. Complete a forward pass, i.e., calculate $a^L_j$.
2. Calculate the error in the final layer using [@eq:backprop1]  and propagate it backwards using [@eq:backprop2] to obtain the error in each neuron. Using [@eq:backprop3] and [@eq:backprop4], calculate the derivatives required for the minimizer.
3. Perform a minimization step (e.g. equation @eq:gradientdescent) and update the weights and biases. 
4. Return to step one until the minimization algorithm in step three converges.

Mathematically, back propagation is a version of a more general technique known as automatic differentiation. Suppose we want to calculate the derivative of some data $f(x)$. Symbolic differentiation would give the most precise answer, but often the function $f$ is not known. Furthermore, even if $f$ would be known, it quickly becomes too hard to calculate a symbolic derivative of a complex function $f$. One could then turn to numerical differentiation using some finite difference scheme or locally fitting a polynomial whose derivative is then calculated. All these methods require relative closely spaced data and are very sensitive to noise. Automatic differentiation allows for the high precision calculation of numerical derivatives. At its fundamental level, any computational operation, no matter how complex, is a long string of elementary operations whose derivative is easily determined. Using the chain rule, we can then calculate the derivative of any computation in terms of these smaller elementary operations. To see this, consider a function $f(x) = a + bx$. Writing this in terms of elementary operations gives:
$$
f(x) = a+bx = w_1+ w_2w_3=w_1+w_4=w_5
$$
The derivative of each subexpression $w_i$ is easily calculated: 
$$
w_1' = 0, w_2'= 0, w_3'=1,w_4'=w_2'w_3+w_2w_3', w_5'=w_4'+w_1'
$$
The derivative of $f$ is then:
$$
f' = w_5' = w_4'+w_1' = (w_2'w_3+w_2w_3')+w_1'
$$ {#eq:autodiff}
We have thus expressed the derivative of $f$ in quantities we know and indeed, after filling in the remaining derivatives we obtain $f' = w_2 =b$. Note the similarity to backpropagation; in automatic differentiation we are only interested in the final expression on the right of equation @eq:autodiff, whereas in backpropagation we wish to know the intermediate derivatives (i.e. $w_5', w_4'$) too. Back propagation is thus a version of automatic differentiation in which the intermediate values are calculated too. In the next section we show that automatic differentiation enables easy encoding of physics into a neural network, leading to a so-called Physics Informed Neural Network (PINN).

## Physics Informed Neural Networks

In this section we introduce Physics Informed Neural Networks (PINNs), a recently developed technique[@raissi_physics_2017-1], [@raissi_physics_2017] which merges physical models and neural networks. We first introduce how PINNs encode physical laws and models in neural networks and discuss why this yields such a powerful technique. This is illustrated by applying it to a simple diffusive process and show that even in the presence of noise, PINNs can accurately infer a (spatially-varying) diffusion constant. We then apply a PINN to the RUSH data and end the chapter with our conclusions.

### The concept
Consider a set of spatiotemporal experimental data, $u(x,t)$ and a model which describes the temporal evolution of this dataset:
$$
\partial_t u = \lambda_1 + \lambda_2 u + \lambda_3\nabla u + \lambda_4 \nabla^2 u = f(1, u, u_x, ...)
$$ {#eq:PDE}
We now wish to know which value for the parameters $\lambda_i$ best describes the dataset $u(x,t)$. Naively, one could train a neural network on a training set created by numerically solving @eq:PDE for different values $\lambda_{i}$ and then feed this network the experimental data $u(x,t)$. Although theoretically this yields the correct result, for complex processes such as a Navier-Stokes flow or the Schrodinger equation this quickly grows intractable due to the massive amount of training data required for an accurate prediction. 

PINNs circumvent this issue by directly encoding physical laws and models such as @eq:PDE into the neural network. We can write any PDE as:
$$
g = -\partial_t u + f(1, u, u_x, u_xx, u^2, ...)
$$ {#eq:PIcost}

This function $g$ can be added to the costfunction, because to satisfy the PDE, $g \to 0$:
$$
\mathcal{L} = \frac{1}{2n}\sum_i|u_i-a^L_i|^2 + \frac{l}{n}\sum_i|g_i|^2
$$

where $l$ sets the effective strength of the two terms. By adding  $g$ to the cost function, it acts as 'physics-regularizer' and unphysical solutions are penalized; we have thus encoded the physics directly into the neural network. Note that while we know the form of $g$, its coefficients $\lambda_i$ are unknown. However, we can treat the coefficients as variables of the cost function, i.e. $\mathcal{L}(w^l,b^l, \lambda)$ and thus by training the network on the dataset $u(x,t)$, we automatically infer the coefficients. Consequently, we don't need a vast set of training data, as we solve the problem *by* training the network. 

Theoretically, PINNs should not only be able to infer constant coefficients, but also coefficient *fields*. Instead of treating the coefficients as a variable to be optimized, we add another output to the network. Such a network is known as a multi-output PINN and the difference between a single and multi output network is shown in figure @fig:PINN. PINNs can also be used to numerically solve PDEs. By removing the mean squared error term from the cost function but adding initial values and boundary conditions, training the network will now result in the network learning the solution to the PDE $g$, whilst respecting the given boundary and initial conditions. This alternative means of numerically solving a model doesn't need advanced meshing of the problem domain required in computational fluid dynamics or carefully constructed (yet often unstable) discretization schemes, as it requires the physics to be fullfilled at every point in the spatiotemporal domain. 

![**Left panel:** a single output PINN. **Right panel:** A multi-output PINN. The network now also predicts the coefficients values at each data point.](source/figures/pdf/PINN.pdf){#fig:PINN}

### PINNs in practice

Before applying a PINN to the RUSH data, we study a toy problem to gain more insight into its behaviour. We also prove that a PINN is able to correctly infer a coefficient field from noisy data. Our toy problem of an initial gaussian 1D concentration profile:
$$
c(x, 0) = e^{-\frac{(x-x_0)^2}{2\sigma}}
$$

with $x_ = 0.5$ and $\sigma =0.01$ diffusing in a box of length $L$ according to:

$$
\frac{\partial c(x,t)}{\partial t} = \nabla \cdot[D(x)\nabla c(x,t)]
$$ {#eq:toyproblem}

on the spatial domain $[0,1]$ with perfectly absorbing boundaries at the edges of the domain:

$$
c(0,t) = c(1,t) = 0
$$

If $D(x) = D$, this problem can be solved using a Greens function. Although being a simple problem, it contains all the essential features of a PINN. For the application of a PINN to more complex systems such as the Burgers, Schrodinger or Navier-Stokes equations, we refer the reader to the papers of M. Raissi et al (@raissi_physics_2017-1, @raissi_physics_2017). 

#### Constant diffusion coefficient

We first numerically solve equation @eq:toyproblem with a diffusion coefficient of $D(x) = D_0 = 0.1$ between $t=0$ and $t=0.5$. Using a spatial and temporal resolution of 0.01, our total dataset consists of 5151 samples, while we have configured the neural network with 6 hidden layers of 20 neurons each and have set $\lambda=1$. The left panel of figure @fig:constantD shows the ground truth (i.e. the numerical solution of equation @eq:toyproblem) and the absolute error w.r.t to the groundtruth of the neural network output. 

![**Left panel**: Simulated ground truth of the problem. **Right panel**: The absolute error of neural network. Note that most of the error is located at areas with low concentration, i.e. signal.](source/figures/pdf/error_constantD.pdf){#fig:constantD}

The inferred diffusion coefficient is $D_{pred} = 0.100026$: an error of $0.026\%$. From the absolute error we observe that the error seems to localize in areas with low concentration. This is a feature we've consistently observed: in areas with low 'signal', the neural network struggles. Considering that in these areas there is simply not much data to learn from, this is not unexpected. 

The input data of the previous problem is noiseless and thus of limited practical interest. We add $5\%$ white noise to the data of the previous problem and train the network on this noisy dataset. Note that the network is now doing two tasks in parallel: it's both denoising the data and performing a fit. In the left panel of figure @fig:error_constantD_noisy we show the concentration profile at times $t = 0, 0.1$ and $0.5$, with the prediction of the PINN superimposed in black dashed lines at each time. On the right panel we show the absolute error with respect to the ground truth. Observe that   the error again localizes in areas with low concentration. The inferred diffusion constant is $D_0 = 0.10052$: an error of $0.52\%$. Although the error is an order of magnitude higher compared to the noiseless data, an error of less than $1\%$ is extremely impressive.

![**Left panel**: The original noisy concentration profile at several times with the neural network inferred denoised version superimposed. **Right panel**: The absolute error of neural network with respect to the ground truth. Note that most of the error is located at areas with low concentration.](source/figures/pdf/error_constantD_noisy.pdf){#fig:error_constantD_noisy}

#### Varying coefficients

As stated, it should be possible to infer coefficient fields by using a two output neural network. We first test this on the noisy constant diffusion ($D_0=0.1$) dataset of the previous problem. In this case, while the neural network is allowed to assign a different diffusion constant to each point in the spatiotemporal domain, it should return $D=0.1$ for each. Figure  @fig:summary_constantD shows a summary of the results in four panels. In the upper left we show the data on which the network is trained, while the upper right panel shows the predicted concentration profile. Note the excellent match between the two. In the lower right panel we show the inferred diffusion field. We observe a good match in the middle of the plot, but the neural network again struggles in areas with low concentration, such as close to the edges of the system. A more quantitative analysis of the predicted diffusion and concentration is presented in the lower left corner. Here we plot the Cumulative Distribution Function (CDF) of the absolute relative error of both the concentration and the diffusion constant. Note that the PINN predicts the concentration very well, with roughly $80\%$ of the points having less than $5\%$ error, but struggles more with the diffusion coefficient. Given that the diffusion coefficient is inferred self-consistently thorugh its role in the physics-informed part of the cost function, this is not unexpected. 

![We show the training data and predicted concentration profile in the upper left and right panels. The lower right panel shows the inferred diffusion field while the lower left panel shows the CDF of the relative error of the diffusion and concentration.](source/figures/pdf/summary_constantD_varyingPINN.pdf){#fig:summary_constantD}

In figure @fig:summary_varyingD we show a similar analysis for data with a non-constant diffusion field. Equation @eq:toymodel has been numerically solved on a grid consisting of 50000 points and diffusion constant profile $D(x) = 0.2 + 0.1\tanh(x)$. Remarkably, the neural network is able to accurately infer the network with $85\%$ of the diffusion field having an error of less than $10\%$. In figure @fig:projectionD we show the inferred diffusion profiles in more detail by projecting them along the time axis. Observe that, yet again, the error is largest where the signal is lowest. Nonetheless, we've proven that a neural network is able to accurately infer a coefficient field from noisy data. 


![We show the training data and predicted concentration profile in the upper left and right panels. The lower right panel shows the inferred diffusion field while the lower left panel shows the CDF of the relative error of the diffusion and concentration.](source/figures/pdf/summary_varyingD_varyingPINN.pdf){#fig:summary_varyingD}


![Projection of the inferred diffusion profile along the time axis.](source/figures/pdf/projection.pdf){#fig:projectionD}

#### Real cell

## Conclusion

### Weak points and how to improve



