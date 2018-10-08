# Physics Informed Neural Networks

In previous chapters we showed the difficulty in finding a general fit for a model to spatiotemporal data. Very recently, a set of papers introduced a new technique called Physics Informed neural networks. The set of papers show very powerful and promising results. I've evaluated this technique for use in fitting our model to the RUSH data. Since for many Neural networks are a new technique, this chapter is also a gentle introduction into Neural networks themself. We have three parts:

* Neural Networks
* Physics Informed Neural networks
* Conclusion

In neural networks we introduce the ideas and some mathematics behind neural networks in Physics informed neural networks we showcase the concept using a simple toy model and in conclusion we present the evaluation of the technique. 

## Neural Networks



### The basis: the neuron
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

### Network



### Training 


## Physics Informed Neural Networks



### The concept
In my point of view, the power of physics informed neural networks comes from two core concepts: the physics regularization and automatic differentiation.

####*



### PINNs in practice

#### Constant D

#### Varying D

## Conclusion

### Weak points and how to improve



