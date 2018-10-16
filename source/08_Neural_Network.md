# Physics Informed Neural Networks

In the previous chapters we showed the difficulties in fitting a model in the form of a partial differential equation to spatio-temporal data. The method we developed was a classical numerical approach, separating the problem into several substeps such as denoising, smoothing and numerical differentiating. In the last few years machine learning has been slowly making its way into physics. Very recently, a technique generally referred to as Physics Informed Neural Networks (PINNs) have shown great promise as both tools for simulation and model fitting (@karpatne_physics-guided_2017, @sharma_weakly-supervised_2018, @pun_physically-informed_2018, @raissi_physics_2017, @raissi_physics_2017-1). In this chapter, I will evaluate the use of this technique to fit the model to the RUSH data. I've divided the chapter into three parts:

* **Neural Networks** - This part will cover the basics of neural networks: their inner workings, how to train them and other general features. 
* **Physics Informed Neural networks** - In this second part we introduce the concept behind PINNs, use it to solve a toy problem and apply it to our RUSH data. 
* **Conclusion** - Finally we summarize the results and observations from the previous sections.

## Neural Networks
Artificial Neural Networks (ANNs) are networks inspired by biological neural networks. Contrary to other ways of computing, ANNs are not specifically programmed for a task - instead, ANNs are *trained* using a set of data. Research on artificial neural networks started in the '40s but never gained any critical mass, as no efficient training algorithm was known.  Once an efficient training algorithm was found in 1975 by Werbos, interest resurged but it wasn't until the late '00s  that deep learning started gaining widespread traction. The use of GPU's allowed ANNs to be efficiently trained and widely deployed at reasonable cost.

The advancements in machine learning in general and especially neural networks in the last ten years have yielded a wealth of techniques and approaches. In supervised learning, the network is given pre-labeled data so that it is trained by learning the mapping from the given inputs to the given outputs. Other types such as supervised learning, where the network needs to learns to discriminate between unlabeled data, and reinforcement learning don't have any obvious use for PINNs yet and I've thus chosen to omit them. In the next sections, I'll present the mathematics of an ANN and show how they are trained using the so-called *backpropagation* algorithm.

### Architecture
*An excellent introduction is given by Michael Nielsen in his freely available book "Neural networks and deep learning." The following section has been strongly inspired by his presentation.*

At the basis of each neural network lies the neuron. It transforms several inputs non-linearly into an output and we can use several neurons in parallel to create a *layer*. In turn, we several layers in series make up a network. The layers in the middle of the network are known as *hidden layers*, as shown in figure @fig:neuralnetwork

![Schematic view of a neural network.](source/figures/pdf/neuralnetwork.pdf){#fig:neuralnetwork}

In the schematic shown in @fig:neuralnetwork, each neuron is connected to every neuron of the previous and next layer. This is known as a *fully connected* layer. Using only this type of layers, we've created a feed-forward network and it has been proven that a single hidden layer with enough neurons is a *universal function approximator*, i.e. a neural network can represent any continuous function using enough neurons.  

As stated, a neuron takes several inputs and transforms them into an output. This is a two step process, where in the first step the neuron multiplies the input vector $\mathbf{x}$ with a weight vector $w$ and adds a bias $b$:

$$
z = w\mathbf{x}+b
$${#eq:weighted_input}

$z$ is called the weighted input and is transformed in the second step by the neuron *activation function $\sigma$*. This in turn gives the output of the neuron $a$, also known as the activation:

$$
a = \sigma(z) = \sigma(w\mathbf{x}+b)
$${#eq:activation}

The role of the activation function is to introduce non-linearity into the system. The classical and often used activation function is the $tanh$, as it is bounded between +1 and -1. Since we're working with multiple layers, it is useful to rewrite function @eq:activation in terms of the activation $a^l$ of layer $l$:

$$
a^l = \sigma(z^l) = \sigma(w^la^{l-1}+b^l)
$$

where $w^l$ and $b^l$ are respectively the weight matrix and bias of layer $l$. 

### Training 
In supervised learning the task of training a machine means adjusting the weights and biases until the neural network predictions match the desired outputs. We thus need some sort of metric to define this 'distance' between prediction and desired output. Training the network than means minimizing the metric with respect to the weights and biases of the network. This metric is known as the cost function $\mathcal{L}$ and the most used form is a mean squared error:

$$
\mathcal{L} = \frac{1}{2n}\sum_i|y_i-a^L_i|^2
$${#eq:MSE}

where $n$ is the number of samples, $y_i$ the desired output of sample $i$ and $a^L_i$ the activation of the last function - the prediction of the network. Minimizing this is not trivial, as the problem can have many local minima. A solution can be found however using gradient  descent techniques.

Gradient descent techniques are based on the fact that given an initial position, the fastest way to reach the minimum from that position is by following the steepest gradient. Thus, given a function $f(\mathbf{x})$ to minimize w.r.t to $\mathbf{x}$, we guess an initial position $x_n$ and iteratively change until it convergences:

$$
\mathbf{x}_{n+1} = \mathbf{x}_{n}-\gamma\nabla f(\mathbf{x}_n)
$$

where $\gamma$ is known as the learning rate. If a global minimum exists, this technique will converge on it. More advanced versions of this technique exist which are able to deal with local minima as well, since convexity of the cost function is not at all guaranteed.

Making use of gradient descent requires knowledge of the derivatives of the cost function w.r.t to the variables to be optimized. In the case of neural networks, we thus need to know the derivative w.r.t to each weight and bias. A naive finite difference scheme would quickly grow computationally untractable for even shallow networks. A solution to this problem was found by Werbos in the form of the backpropagation algorithm. Despite many years of ongoing research, it is still the go-to algorithm for each neural network implementation.

#### Back propagation and automatic differentiation {-}
As we wish to minimize the cost function w.r.t. to each weight $w$ and bias $b$ using gradient descent, we need to find the derivative of the cost function w.r.t to each. Our argument simplifies if we move away from vector notation and introduce $w^l_{jk}$, the weight of the $j$-th neuron in layer $l-1$ to neuron $k$ in layer $l$ and $b^l_j$, the bias of the neuron $j$ in the $l$-th layer. We introduce the error of neuron $j$ in layer $l$ as:

$$
\delta^l_j=\frac{\partial C}{\partial z^l_j}
$$

We can rewrite this using the chain rule as:

$$
\delta^l_j = \sum_k \frac{\partial C}{\partial a^l_{jk}}\frac{\partial a^l_{jk}}{\partial z^l_{j}} 
$$

However, the second term is always zero except when $j=k$, so the summation can be dropped. Remembering [@eq:activation], we note that $\partial a^l_{jk}/\partial z^l_{j} = \sigma'(z^l_j)$. For the last layer $l = L$, the first term turns into the derivative of the cost function, finally giving us:

$$
\delta^L_j =  |a^L_j-y_j|\sigma'(z^L_j)
$${#eq:backprop1}

Equation @eq:backprop1 relates the error in the output layer to its inputs. This in turn is a function of all the previous inputs and errors and we thus need to find an expression relating the error in layer $l$ with the error in an layer $l+1$. Since we have an expression for the error in the last layer, we propagate the error going down the layers, hence the name *back*propagation. Again using the chain rule gives:

$$
\delta^l_j = \sum_k \frac{\partial C}{\partial z^{l+1}_{jk}}\frac{\partial z^{l+1}_{jk}}{\partial z^l_{j}} = \sum_k \delta^{l+1}_k\frac{\partial z^{l+1}_{jk}}{\partial z^l_{j}}
$$

Using equation @eq:weighted_input, we obtain after substitution:

$$
\delta^l_j = \sum_k\delta^{l+1}_kw^{l+1}_{kj}\sigma'(z^l_j)
$${#eq:backprop2}

Using equations @eq:backprop1 and @eq:backprop2 , we can calculate the error in C due to each neuron. Finally, we need to relate the error in each error to  $\partial C/\partial w^l_{jk}$ and $\partial C/\partial b^l_{j}$. Making use yet again gives us the last two backpropagation relations:

$$
\frac{\partial C}{\partial b^l_{j}}\frac{\partial b^l_{j}}{\partial z^l_{j}}=\frac{\partial C}{\partial b^l_{j}}=\delta^l_j
$${#eq:backprop3}

$$
\sum_k\frac{\partial C}{\partial w^l_{jk}}\frac{\partial w^l_{jk}}{\partial z^l_{j}}=\delta^l_j\to \frac{\partial C}{\partial w^l_{jk}}=a^{l-1}_{j}\delta^l_j
$${#eq:backprop4}

Now that we now that all back propagation equations, we state the algorithm. It consists of four steps:

1. Complete a forward pass, i.e., calculate the expected outcomes with the current weights and biases.
2. Calculate the error using [@eq:backprop1] and do a backward pass to obtain the error in each neuron using [@eq:backprop2]. This can be used to calculate the gradients using [@eq:backprop3] and [@eq:backprop4]
3. Adjust the weights and biases using the choosen optimizer (e.g. gradient descent)
4. Return to step 1 until the optimization problem converges.

Mathematically, back propagation is a special case of a technique known as automatic differentiation. Automatic differentiation is a third type of differentiation, next to numeric and symbolic. It allows for machine precision calculation of derivatives by writing it as a chain of simple operations combined with the chain rule, similar to backpropagation. Note that:

$$
\delta^0_j = \frac{\partial C}{\partial x_j}\frac{\partial x_j}{\partial z^0_j}
$$

so that:

$$
\frac{\partial C}{\partial x_j} = a^0_j \delta^0_j 
$$

Thus neural networks also give us access to high precision derivatives with regard to each coordinate. 

## Physics Informed Neural Networks

On the face of things, the goal of physics and neural networks are oppsite: whereas physics tries to build an understanding of things using models to make predictions, neural networks learn a *modelless* mapping to make predictions. Recent advancements however have merged the two approaches together in a concept known as Physics Informed Neural Networks (@raissi_physics_2017-1, @raissi_physics_2017). In this approach, we encode physical laws into the network, so that the network respects the physics. This can be used to both numerically solve equations or fit a model to spatiotemporal data. Even more so, it should allow us to infer coefficient fields. 

### The concept
Consider a set of 1D+1 spatiotemporal data, consisting of some property $u(x,t)$ at coordinates $(x,t)$. The neural network can be learned the underlying physics by minimizing the cost function:

$$
\mathcal{L} = \frac{1}{2n}\sum_i|u_i-a^L_i|^2
$$

The process of learning requires a lot of data and is prone to overfitting. 
Now assume that we know that $u(x,t)$ is governed by some process which is written as a partial differential equation:

$$
\partial_t u = f(1, u, u_x, u_xx, u^2, ...)
$$

where $f$ is a function of $u$ or its spatial derivatives. Rewriting it as:

$$
g = 0 = -\partial_t u + f(1, u, u_x, u_xx, u^2, ...)
$${#eq:PIcost}

we see that in order to satisfy the PDE, $g\to0$. The idea of PINNs is to add this function $g$ to the costfunction of the neural network:

$$
\mathcal{L} = \frac{1}{2n}\sum_i|u_i-a^L_i|^2 + \lambda\sum_i|g_i|^2 = MSE + \lambda PI
$$

where $\lambda$ sets the effective strength of the two terms. Observe that the cost function is higher if the PDE is not satisfied. Minimizing the costfunction will thus mean minimizing $g$ and hence satisfying the PDE. We effectively penalize solutions not satisfying the physics we put in equation @eq:PIcost; the added term acts a 'physics-regularizer'. Concretely, the adding of physics contrains the solution space, preventing overfitting and making the neural network much more data efficient. The most useful feature however is that we don't need a vast set of training data to train the network, as we solve the problem *by* training the network. 

We can also remove the mean squared error term from the cost function and add initial and boundary conditions, similar to the PI term. If we now train the network, it will learn the solution to the given PDE whilst respecting the given boundary and initial conditions. This alternative means of numerically solving a model doesn't need advanced meshing of the problem domain or carefully constructed (unstable) discretization schemes, as it requires the physics to be fullfilled at every point in the spatiotemporal domain. A useful analogy here is calculating the trajectory of a launched object. A classical numerical solver would take small steps in time, updating the position and speed of the object each step. A PINN however uses a completely different approach. Given the initial (random) state of the neural network, it calculates a first trajectory and keeps adjusting the weights of the network until the cost is minimized, i.e. until we obtain a solution satisfying the included physics and initial and boundary conditions. 
A classical numerical approach tries once using a correct and methodical approach, whereas a PINN tries many times until the result satisfies its constraints.

We can also use this framework to fit models to spatiotemporal data by letting the coefficient of each term be a variable to be minimized as well. More concretely, where before the cost was a function of the weights and biases, $\mathcal{L}=f(w^l, b^l)$, we now let it be a function of the coefficients $\lambda$ of the PDE as well: $\mathcal{L}=f(w^l, b^l, \lambda_1, \lambda_2,...)$. This is shown for several PDEs such as the Burgers, Schrodinger or Navier-Stokes equation in the papers of M. Raissi(@raissi_physics_2017-1, @raissi_physics_2017). In the case of the Navier-Stokes equation, it's shown that it's also possible to infer the pressure field, which appears as a separate term. This is achieved by adding another output neuron to the PINN (shown in figure @fig:PINN), so that it predicts both the pressure and the flow. In theory it should also be possible to infer spatially and temporally varying *coefficient* fields. We investigate this claim in the next section.

![Left panel: a normal single output PINN. Right panel: a multi-output PINN. The network now also predicts the coefficients values at each data point.](source/figures/pdf/PINN.pdf){#fig:PINN}

### PINNs in practice
We now wish to evaluate the use of PINNs to analyze the RUSH data. Using a diffusive process as a toy problem, we first show how PINNs are able to accurately determine the diffusion constant, even in the presence of noise. Next, we prove that PINNs are indeed capable of inferring coefficient fields and finish by analyzing some parts of the RUSH data.

In our toy problem we have an initial concentration profile:

$$
c(x, 0) = e^{-\frac{(x-0.5)^2}{0.02}}
$$

diffusing in a 1D box according to:

$$
\frac{\partial c(x,t)}{\partial t} = \nabla \cdot[D(x)\nabla c(x,t)]
$$

on the spatial domain $[0,1]$ with perfectly absorbing boundaries at the edges of the domain:

$$
c(0,t) = c(1,t) = 0
$$

If $D(x) = D$, this problem has an analytical solution through a Greens function. If the diffusion coefficient is spatially dependent though, the problem needs to be solved numerically. The code used to generate our data can be found in the appendix. Although this toy problem is simple and in 1D, our results easily generalize to higher dimenions and complexity at the cost of higher computational cost.

#### Constant diffusion coefficient

We now consider the mentioned problem with a diffusion coefficient of $D(x) = D_0 = 0.1$ and simulate it between $t=0$ and $t=0.5$. Using a spatial and temporal resolution of 0.01, we have a datagrid of 101 by 51, so that our total dataset consists of 5151 samples. The neural network consists of 6 hidden layers of 20 neurons each and $\lambda=1$. Figure @fig:constantD shows the ground truth for the problem and the absolute error of the neural network. 

![**Left panel**: Simulated ground truth of the problem. **Right panel**: The absolute error of neural network. Note that most of the error is located at areas with low concentration, i.e. signal.](source/figures/pdf/error_constantD.pdf){#fig:constantD}

The predicted diffusion coefficient is $D_{pred} = 0.100026$, giving an error of $0.026\%$. In @raissi_physics_2017-1, the authors obtain similar accuracies for significantly more complex problems such as the Schrodinger equation, which means that our accurate inference is not just due to the simplicity of the problem. Furthermore, Raissi et al. show that the result is robust w.r.t the architecture of the network.
From the absolute error we observe that the error seems to be higher in areas with low concentration. This is a feature we've consistently observed: in areas with low 'signal', the neural network seems to struggle. 

As good as these results are, the input data is noiseless and thus of limited practical interest. We now show that PINNs perform equally well with noisy data by adding $5\%$ white noise to the data and performing the same procedure. The network is now doing two tasks in parallel: it's both denoising the data and performing a model fit. In the left panel of figure @fig:error_constantD_noisy we show the concentration profile at times $t = 0, 0.1$ and $0.5$, with the prediction of the PINN superimposed in black dashed lines at each time. On the right panel we show again the absolute error from the ground truth. Observe the similarities with the noiseless case: most of the error localizes in areas wit low concentration.

![**Left panel**: The original noisy concentration profile with the neural network inferred denoised version super imposed. **Right panel**: The absolute error of neural network with respect to the ground truth. Note that most of the error is located at areas with low concentration.](source/figures/pdf/error_constantD_noisy.pdf){#fig:error_constantD_noisy}

The inferred diffusion constant is $D_0 = 0.10052$, giving an error of $0.52\%$. Although the error is slightly higher than in the noiseless version, it's extremely impressive that we obtain the diffusion constant to this precision.

#### Varying D
As stated, it should be possible to infer coefficient fields by using a two output neural network. One output predicts the concentration while the other predicts the diffusion coefficient. Such a network is indeed capable of generating the right coefficient field as shown in figure @fig:summary_constantD . Here the network has been trained on the constant diffusion coefficient data we used before including $5\%$ white noise, so that we should observe a diffusion field constant at $D(x,t) = D_0 = 0.1$. In the upper left we show the data on which the network is trained, with the upper right panel the predicted concentration profile, which shows a very good match. In the lower right panel we show the inferred diffusion field. We observe a good match in the middle of the plot, but the neural network again struggles in areas with low concentration, such as the lower left and right area. A more quantitative analysis of the predicted diffusion and concentration is presented in the lower left corner. Here we plot the Cumulative Distribution Function (CDF) of the absolute relative error. Note that the PINN predicts the concentration very well, but struggles more with the diffusion coefficient. This is expected, as the mean squared error of the cost function is quite explicit in its use of the concentration, whereas the diffusion coefficient is determined self-consistently in the PI part. We also observed similar but distinctive results in different runs, owing to the non-convexity of the problem. Overall the result is still remarkable, given that we've inferred a diffusion field from just concentration data with $5\%$ noise.

![We show the training data and predicted concentration profile in the upper left and right panels. The lower right panel shows the inferred diffusion field while the lower left panel shows the CDF of the relatice error of the diffusion and concentration.](source/figures/pdf/summary_constantD_varyingPINN.pdf){#fig:summary_constantD}

#### Real cell

## Conclusion

### Weak points and how to improve



