# Physics Informed Neural Networks

In the previous chapters we showed the difficulties in fitting a model in the form of a partial differential equation to spatio-temporal data. The method we developed was a classical numerical approach, separating the problem into several substeps such as denoising, smoothing and numerical differentiating. In the last few years machine learning has been slowly making its way into physics. Very recently, a technique generally referred to as Physics Informed Neural Networks (PINNs) have shown great promise as both tools for simulation and model fitting (@karpatne_physics-guided_2017, @sharma_weakly-supervised_2018, @pun_physically-informed_2018, @raissi_physics_2017, @raissi_physics_2017-1 ).

the difficulty in finding a general fit for a model to spatiotemporal data. Very recently, a set of papers introduced a new technique called Physics Informed neural networks. The set of papers show very powerful and promising results. I've evaluated this technique for use in fitting our model to the RUSH data. Since for many Neural networks are a new technique, this chapter is also a gentle introduction into Neural networks themself. We have three parts:

* Neural Networks
* Physics Informed Neural networks
* Conclusion

In neural networks we introduce the ideas and some mathematics behind neural networks in Physics informed neural networks we showcase the concept using a simple toy model and in conclusion we present the evaluation of the technique. Since Neural networks are completely new concept to most, we use a light tone.

## Neural Networks
Neural networks. Inspired by biological neural networks, but not the same!!! Started with the perceptron in the early 60's, but only one layer so nothing cool. Back propagarion rediscovered in the 80's, now recognized how to efficiently train a network, but we needed the advancements in the late 00's in GPU's for large scale NN. Ever since great advancements in engineering and slowly starting to seep into science now as well. Two main flavours: supervised and non-supervised. In non-supervised we dont tell the goal to the network, in supervised we do. We'll only focus on the last one. We start with some simple introduction to architecture and how to train them [@raissi_physics_2017].

### Architecture

The basic building block of each type of neural network is the same: the neuron. Inspired, but not the same as a biological neural network, the neuron basically has several inputs and transforms them into a single output. This roughly a two step process. Immediatly going to matrix notation, given an input vector $\mathbf{x}$, the neuron multiplies the input vector by a weight matrix and adding a bias. This gives us the *weighted input* z:

$$
z = W\mathbf{x}+b
$${#eq:weighted_input}

The weighted input [@eq:weighted_input] is then transformed by the neuron *activation function $\sigma$* to give the output of the neuron $a$, also known as the activation:

$$
a = \sigma(z) = \sigma(W\mathbf{x}+b)
$$

The role of the activation function is to introduce non-linearity into the system. Many research is ongoing into different activation, but one of the most used is the $tanh(x)$ function, due to its bounded output between -1 and 1 and easy derivative. Several other functions with more favourable properties such as lower computational cost are available as well. 

Multiple neurons working in parallle constitute a layer, while multiple layers in series forms a neural network. We always have an input and input layer, and the layers inbetween are known as hidden layers. Networks with more than 1 hidden layer are known as deep neural networks. In the simplest neural network, all neurons in a layer are connected to all the neurons in the next layer. Such a network is shown in figure... We can then rewrite function ... in a matrix form. We state $a^l$ is the activation of layer $l$:

$$
a^l = \sigma(z^l) = \sigma(W^la^{l-1}+b^l)
$$

The weights $W^l$ are now the 'strength' of each neurons layer to the next. It turns out that such a network is what is known as a *universal function approximator*, meaning that with enough layers and neurons, a NN is able to approximate **any continous function**. Now that we've set up the network, we turn to training it. 

### Training 
As the name machine learning implies, we teach a machine to perform a certain task, i.e. contrary to normal algorithms, we do not tell the machine how to do something. In the case of supervised learning, we have a set of labeled data. This means that we have some inputs which we know should lead to a desired output. The task of training then falls to adjusting the weights and biases untill we get the desired output. A measure to relate how far the given output is from the desired output is given by the *cost function*. Many different cost functions are available, each one useful for a specific task, but one of the most basic and simple ones is the mean squared error (MSE):

$$
cost_{MSE} = \frac{1}{2n}\sum_n|y-y_{pred}|^2
$$
where $n$ represents the sum over each training sample. Training the network thus becomes minimizing the cost function with respect to weight and bias. In general this a problem with local minima, but a solution may be found using gradient descent techniques.

#### Gradient descent {-}
 Consider a function $f(\mathbf{x})$, we which we wish to minimize with respect to $\mathbf{x}$. One starts with an estimate of $\mathbf{x}_0$, which we iteratively refine

$$
\mathbf{x}_{n+1} = \mathbf{x}_{n}-\gamma\nabla f(\mathbf{x}_n)
$$

untill the gradient vanishes. This position is where f is minimized w.r.t $\mathbf{x}$.$\gamma$ is known as the learning rate and sets the step rate. More advanced techniques can set a variable learning rate etc, but the basis remains similar.

#### Back propagation and automatic differentiation{-}
In the case of neural networks we wish to minimize the cost w.r.t. to each weight $w^l_{jk}$ and bias $b^l_j$. To do this computationally is not trivial, and most of the NN field uses one algorithm: back propagation. We give a short introduction below. We want to know basically two different things:

$$
\frac{\partial C}{\partial w^l_{jk}}, 
\frac{\partial C}{\partial b^l_{j}}
$$
the change of the cost w.r.t to each weight and bias. Let's define the error neuron $j$ in layer $l$ as $\delta^l_j=\partial C/\partial z^l_j$. We can rewrite this using the chain rule as:

$$
\delta^l_j = \sum_k \frac{\partial C}{\partial a^l_{jk}}\frac{\partial a^l_{jk}}{\partial z^l_{j}} 
$$

However, the second term is always zero except when $j=k$, so we drop the sum. We also see that the second term is equal to $\sigma'(z^l_j)$. For the last layer $L$, the first term turns unto the derivative of the cost function, finally giving us:

$$
\delta^L_j =  |a^L_j-y_j|\sigma'(z^L_j)
$$

This expression gives us the error in the output layer in terms of its weighted input. This in turn is a function of previous inputs and errors and we thus need to find an expression relating the error in layer $l$ with the error in an layer $l+1$. Since we have an expression for the error in the last layer, we calculate the errors going down the layers (from $L$ to $0$), hence the name backpropagation. Again using the chain rule gives:
$$
\delta^l_j = \sum_k \frac{\partial C}{\partial z^{l+1}_{jk}}\frac{\partial z^{l+1}_{jk}}{\partial z^l_{j}} = \sum_k \delta^{l+1}_k\frac{\partial z^{l+1}_{jk}}{\partial z^l_{j}}
$$
Using the definitions of $z^l_{jk}$, we finally after substitution obtain:

$$
\delta^l_j = \sum_k\delta^{l+1}_kw^{l+1}_{kj}\sigma'(z^l_j)
$$
Using these two equations, we can calculate the error in C due to each neuron. Finally, to calculate the $\partial C/\partial w^l_{jk}$ and  
$\partial C/\partial b^l_{j}$, we relate these to the error, again via the chain rule:

$$
\frac{\partial C}{\partial b^l_{j}}\frac{\partial b^l_{j}}{\partial z^l_{j}}=\frac{\partial C}{\partial b^l_{j}}=\delta^l_j
$$
$$
\sum_k\frac{\partial C}{\partial w^l_{jk}}\frac{\partial w^l_{jk}}{\partial z^l_{j}}=\delta^l_j\to \frac{\partial C}{\partial w^l_{jk}}=a^{l-1}_{j}\delta^l_j
$$
These four equations together make up the the backpropagation algorithm. The complete optimization of the network goes as follows:
1. Complete a forward pass, i.e., calculate the expected outcomes with the current weights and biases.
2. Calculate the error and back propagate it to obtain the gradients in the weights and biases.
3. Adjust the weights using optimizer (e.g. gradient descent)
4. Return to step 1 and redo the cycle untill convergence.

Officialy, back propagation is a special case of a technique known as automatic differentiation, which is third type of differentiation, next to numeric and symbolic. It also for machine precision calculation of derivatives by writing it as a chain of simple operations combined with the chain rule, similar to backpropagation. Note that:

$$
\delta^0_j = \frac{\partial C}{\partial x_j}\frac{\partial x_j}{\partial z^0_j}
$$
so that:
$$
\frac{\partial C}{\partial x_j} = a^0_j \delta^0_j 
$$
Thus when learning, we also have access to high precision derivatives with regard to each coordinate!

## Physics Informed Neural Networks

On the face of things, physics and neural networks seem to satisfy two completely different goals. Whereas physics tries to build (simplified) models, neural networks try to learn a general modelless mapping from the inputs to the outputs. However, recently some approaches have emerged which fuse these seemingly opposite goals in order to do two different things:

1. Use a neural network to simulate/numerically solve equations.
2. Use a neural network to 'fit' a model to spatiotemporal data and even infer a coefficient field.

Initial results have shown very promising: using neural networks to numerically solve models doesn't require any advanced meshing and carefull handling of shocks, whereas the ability to infer coefficient fields from spatiotemporal data hasn't been shown at all to my knowledge. 

### The concept
Consider a set of 1+1D spatiotemporal data, consisting of some property $u_i$ at coordinates $(x_i,t_i)$. As stated before, a neural network learns the mapping $x,t\to u$ because it is a universal function approximator through minimizing the mean squared error:

$$
MSE = \sum_i(u_i^{in}-u^{pred}_i)^2
$$

Now assume that we know that $u(x,t)$ is governed by some process which can be modeled as a partial differential equation. We can write (almost) every PDE as:

$$
\partial_t u = f(1, u, u_x, u_xx, u^2, ...)
$$

where $f$ is some sort of function of $u$ or its spatial derivatives. Now we rewrite is as:

$$
g = -\partial_t u + f(1, u, u_x, u_xx, u^2, ...)
$$

To satisfy the model, the function $g$ always has to go to zero. The idea behind Physics Informed Neural Networks (PINNs) is that we can include this function as an extra cost to be minimized:

$$
cost = \sum_i(u_i^{in}-u^{pred}_i)^2 + \sum_ig_i^2 = MSE + PI
$$

Since to satisfy the model we need $g\to0$, by adding our second 'Physic-informed' term, we effectively penalize solutions not satisfying the physics we put in: our new term acts as a regularizer. More concretely, this term has two effects:

1. **It prevents overfitting:** Neural Networks can be prone to overfitting. This term prevents that by penalizing variations not described by the physics.
2. **It makes the NN more data-efficient:** we can get good results with not much data.
3. **It allows fitting and prediction:** we can fit and predict based to the terms in $f$.

The first point is rather technical and interesting for more in-depth, so we'll leave it for now. The second point is very interesting from an experimental point of view. By presupposing some structure in the data in the form of a model, we need significantly less data to get the same result. It's also here that we see the no free lunch theorem: a price has to be paid. By encoding a model into the neural network, we lose the freedom of the neural network to map $x,t$ $u$ using any function. For us physicists however, this is actually a blessing but for applications where equationless modeling is usefull this is terrible. Note that we also circumvent the issue of numerical derivatives, since we can use the network provided automatic derivatives at machine precision. This combination provides the power of PINNs - a one-two punch consisting of physics regularization and automatic derivatives.

### Fitting and prediction {-}
Point three is however where PINNs really shine. How can the extra term we've included have these effects? To see this, consider the classics physics exercise of calculating the trajectory of a launched object. In this case we know the function $g$, i.e. $\ddot{y}=-g$.
A classical numerical solver would take small steps in time, updating the position and speed of the object each step according to $g$. A PINN however uses a completely different approach. Given the initial state of the neural network, it calculates a first trajectory but then keeps adjusting the weights of the network until the cost is minimized, i.e. $g$ goes to zero everywhere. In other words: the Neural network keeps launching the object and adjusting its internal weights until the physics are satisified at every step of the trajectory. The classical numerical approach goes for one correct try; the neural network just keeps trying until it converges on the correct solution. This approach allows us at the same time to circumvent complex discretization schemes and issues such as solutions blowing up. Such an approach is possible because of the backpropagation algorithm, which allows us to calculate the part of each neuron in the total cost and in which direction to change the weights and biases to minimize the cost.

Interestingly, we can also use this framework to fit models to spatiotemporal data by letting the coefficent of each term be a variable  w.r.t to which we minimize too. More concretely, where before the cost was a function of the weights and biases, $cost=f(w^l_{jk}, b^l_k)$, we now let it be a function of the coefficients $\lambda$ of the PDE as well: $cost=f(w^l_{jk}, b^l_k, \lambda)$. This is shown for all kinds of systems in the papers of **[ref]**. In theory however, it should also be possible to infer coefficient *fields*, both spatially and temporally varying. We can achieve this by a multi-output Neural network. Instead of outputting just $c$, we also output the coefficient at that spatiotemporal point, as shown in figure **[ref]**. We investigate this claim in the next section.

### PINNs in practice
In this section we wish to evaluate the use of PINN's for our RUSH data. We start with a toy problem: a simple diffusive process. This has already been shown in the papers by Raissi, but it's just to show the reader. We then show the similar problem but with two different diffusion constants. This has not been shown by Raissi and we show here thats is possible to infer a coefficient field from the data using PINNS.

We use the following toy problem: a 1D box, started with initial condition:

$$
c(x, 0) = e^{-\frac{(x-0.5)^2}{0.02}}
$$

and a diffusive process:

$$
\frac{\partial c}{\partial t} = \nabla \cdot[D(x)\nabla c]
$$

on the spatial domain (0,1) with boundary conditions in equation [@eq:boundvalue]

$$
c(0,t) = c(1,t) = 0
$${#eq:boundvalue}

i.e. perectly absorbing boundary conditions. We used mathematica to solve these equations. The code is the appendix. 

#### Constant D

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



