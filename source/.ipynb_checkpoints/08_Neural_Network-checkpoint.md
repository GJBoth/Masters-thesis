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

If $D(x) = D$, this problem has an analytical solution through a Greens function. If the diffusion coefficient is spatially dependent though, the problem needs to be solved numerically. The code used to generate our data can be found in the appendix. 

#### Constant diffusion coefficient

#### Noiseless{-}
Now consider the problem with a constant diffusion of $D_0 = 0.01$. We simulate the data on a domain $x:[0,1]$ and $t:[0,0.5]$ we use a spatial resolution of 0.01, giving the number of points 101 by 51, giving a total number of data points of 5151. Since the fitting is the training, we do not need to separate the data in a training and validation set. Figure ref shows the input data and the what the network predicts. After training, the network predicts (almost exactly) what we want it to and the average error is less than 1. Ofcourse, more interesting is the inferred diffusion parameter. With a value of 0.10034, the error is roughly 0.3. This is very good, but ofcourse our data is without noise. Note however that even still is extremely good and that in their papers Raissi shows far more complex equations such as the complex Schrodinger one. Also note that the error is mostly located at areas with low signal. This is a consistent problem and must be taken into account. Powerful as they are, neural networks seem to struggle with this [@fig:Dfield] .

![Left panel: something. Right panel: something else](source/figures/pdf/error_constantD.pdf){#fig:error_constantD}

Looks really nice.

#### Noisy {-}
 [@fig:Dfield] 
It becomes more interesting once we add noise. We take exactly the same problem, but now add 5% gaussian distributed white noise (e.g. $0.05std(c)$) and let the neural network do it's thing again. The network is now doing two things at once: it's *denoising* the data by stating that the underlying data is of a certain model while finding the optimal model parameters. Again figure **ref** shows our original data and the fit. 

The data correctly infers the ground truth. The inferred diffusion coefficient is 0.10017, an error of $0.17$. I just want to state that this is almost ridiculous. We have roughly 5000 points with 5 error and the network is able to infer the coefficent within 1. We also havent optimized the network in any way: it's the most basic full connected layers with tanh activation function and we just used enough layers and neurons. It's also a very general technique: it works for whatever PDE and data multidimensional data. We also fit the model directly to the data; circumventing the need to know boundary conditions, initial conditions etc... We can now proceed to more advanced setup.


![Left panel: something. Right panel: something else](source/figures/pdf/error_constantD_noisy.pdf){#fig:error_constantD_noisy}

#### Varying D
As stated, it should be possible to infer varying coefficient fields. Instead of using a single output network, we implement of two output neural network; outputting both the coefficient and the concentration. Note that this is slightly different from what is done in this paper **ref**. They infer the pressure field, but this is a separate added term; its not multiplied by a spatially varying term. 

#### Non-varying {-}
We first demonstrate this using the same data as before: so although we allow a spatially varying field, the underlying data only has a single diffusion coefficient. The coefficient is then learned through training the network and 'corrected' by PI-loss function. Figure **ref** shows our results. 

test reference [@raissi_physics_2017]


and another one 

#### Varying {-}


#### Real cell

## Conclusion

### Weak points and how to improve



