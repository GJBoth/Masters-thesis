# Introduction to Golgi as a phase separated droplet

In this part of the thesis we develop a model relating the Golgi function and size to its transport properties. This chapter serves as a background to the next, both on biological and physical perspective. In the first section we state the general idea of the model and some observations from the biological observations. The second section obtains a short introduction to phase separation and introduces the Cahn-Hilliard equation.

## Considerations of Golgi for general model

In no particular order, there's a few notable things about golgi which  warrant a phase separation description:

* The Golgi is able to form de novo (Bevis)
* Microtubules position the golgi near the mtoc (Sengupta)
* Nocadazola depolymerizes microtubules -> golgi stacks move towards ERES (sengupta)
* Golgi size is dependent on amount of trafficking (Sengupta)
* Separate ministacks seems to be fully functional (Wei)
* Golgi disassembly is due to imbalanced trafficking: exit from ER is blocked, while outflow still continues (Ronchi)
* When golgi is completely cut out, stack like structures form around ERES (Ronchi) and then later move towards mtoc. 

We think we can describe this using an active droplet. Our model basically consists of two parts: We hypothesize that we can describe the transport between the ER and the golgi as a advection-diffusion equation and use a Cahn-Hilliard equation (see next section) to describe the phase separation. We thus need a a way to couple the transport model to the phase separation model. 

## Phase separation

Consider a mixture of two molecules, type A and B. One is the solvent and one the solute. One can then try and use statistical mechanics to derive a mean-field model and get all sorts of cool results. This is quite complex and not particulally enlightening for us. Instead, we follow a method devised by Landau. We know that phase separation occurs when the free energy has two convex region, so we can construct a free energy density function $f$ with two minima in a minimalist way as:

$$
f(c) = \frac{b}{2(\Delta c)^2}(c-c_0^-)^2(c-c_0^+)^2
$$

where $b$ characterizes interactions, $\Delta c = |c_0^--c_0^+|$, and $c_0^\pm$ is where the two minima of the function are located. Figure shows this free enery function. A free energy like this leads to phase separation into a dense and dilute phase. The interface has surface tension, so when we calculate the full free energy of the system we add a term for the interface:

$$
F(c) = \int dV (f(c)+\frac{1}{2}\kappa \nabla^2c)
$$

We thus have constructed a Landau free energy with order parameter c. The first term accounts for the bulk energy, while the second term penalizes interfaces. Suittable choices of parameter lead either to a mixed state, where $\bar{c}=constant$ in the whole system, or to a phase separated state such as shown in figure. When we quench a system from a mixed state into a phase-separated state, this happens through a process called *coarsening dynamics*. Basically small domains form and these keep growing, showing a maze-like structure as in figure .... In liquid-liquid phase separation, the order parameter is conserved, as the molecules cant just change. The phases then exchange diffusion-like and can only exchange locally, so we state that:

$$
\partial_t c = -\nabla \cdot \mathbf{j}
$$

where $\mathbf{j}$ is a flux. We know that $\mathbf{j}$ is related to the to the chemical potential through:

$$
j = -\Lambda \nabla \mu
$$

where $\Lambda$ is an Onsager coefficient. We also know that $\mu = \delta F/ \delta \phi$ so that we end up with

$$
\frac{\partial \phi}{\partial t} = m \nabla^2 \frac{\delta F}{\delta \phi}
$$

where $\delta/\delta \phi$ is a functional derivative. Given the landau free energy in eq , we obtain:

$$
\frac{\partial \phi}{\partial t}=m\nabla^2[f'(\phi)-k\nabla^2\phi]
$$

which is known as the Cahn-Hilliard equation. The Cahn-hilliard equation is what governs the maze domain evolution shown in figure and is the basis for studies of phase separation. Due to its non-linearity its very hard to use, and many times a scaling relation is derived. However, since we want to include spatial inhomogenity, this probably will not work. We present a different approach using effective droplets in the next section.

