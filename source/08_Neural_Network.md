# Physics Informed Neural Networks

In previous chapters we showed the difficulty in finding a general fit for a model to spatiotemporal data. Very recently, a set of papers introduced a new technique called Physics Informed neural networks. The set of papers show very powerful and promising results. I've evaluated this technique for use in fitting our model to the RUSH data. Since for many Neural networks are a new technique, this chapter is also a gentle introduction into Neural networks themself. We have three parts:

* Neural Networks
* Physics Informed Neural networks
* Conclusion

In neural networks we introduce the ideas and some mathematics behind neural networks in Physics informed neural networks we showcase the concept using a simple toy model and in conclusion we present the evaluation of the technique. Since Neural networks are completely new concept to most, we use a light tone.

## Neural Networks
Good source: http://neuralnetworksanddeeplearning.com/chap2.html


### Architecture

The basic of each type of neural network is the same: the neuron. Inspired, but not the same as a biological neural network, the neuron has an input $x$ and transforms it to an output $y$: $x\to y$. This is a three step process. The input $x$ is multiplied by a factor $a$ known as a weight and adds a constant known as the bias $b$. This serves as an input to the *activation function* $g$ of the neuron, so that 
$$
y = g(ax+b)
$$
the role of the activation function is to introduce non-linearity into the system. Many research is ongoing into different activation, but one of the most used is the $tanh(x)$ function, due to its biological relevance and bounded in and outputs. Several other functions with more fsvourable properties such as lower computtational cost are available as well. 

A neuron always has one output, but can have multiple inputs, for example in the case of multitple neurons feeding into another one. One can also have multiple neurons in a single layer. A natural generalization is that $a$ and $b$ become matrices and $x$ and $y$ vectors:
$$
\vec{y} = g(A\vec{x}+B)
$$
where $g$ is applied element wise. The goal of training a neural network is to find the matrices $A$ and $B$ which make sure that $y$ is closest to the desired outcome. 

### Training 

#### Gradient descent {-}
As the name machine learning indicates, neural networks need to *learn*. When this nomenclature is used, it means that we need to adjust the weights and biases in the network until the output matches the wished-for output. In general this a problem with local minima, but a solution may be found using gradient descent techniques. Consider a function $f(\mathbf{x})$, we which we wish to minimize with respect to $\mathbf{x}$. One starts with an estimate of $\mathbf{x}_0$, which we iteratively refine

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


#### Constant D

#### Varying D

#### Real cell?

## Conclusion

### Weak points and how to improve



