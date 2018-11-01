# Introduction to Golgi as a phase separated droplet

In this second part of the thesis we develop a model linkingthe Golgi function and size to protein transport. Special attention will be devoted to adding spatial dependence, as this is what current models are lacking. IN the first section we justify our choice of a phase-separated droplet from a biological perspective. In the second section we present a short primer on phase-separation theory before presenting an approximation which makes the theory analytically tractable. We end with a section which sets up our model, which we solve and analyze in the next chapter.


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

## Effective droplet 

Consider phase separation in a one-dimensional box. The system will separate into a dilute and a dense phase, separated by an interface of width $w$:

$$
c^*(x) = \frac{c_0^-+c_0^+}{2}+\frac{c_0^+-c_0^-}{2}\tanh\left(\frac{x}{w}\right)
$$

The idea of the effective droplet model is that if the width of the interface $w$ is very small, we neglect the interfacial contribution and describe the system as two separate bulk phases. In each bulk phase we then solve a linearized version of the Cahn-Hilliard equation and match the solutions at the interface of the phases. Growth of the droplet can then be described in terms of fluxes across the interface. We show this in figure @fig:eff_droplet. 

We first linearize the Cahn-Hilliard equation in the bulk phases. Consider again the Cahn-Hilliard equation, where we've changed the order parameter $\phi$ to a concentration $c$:

$$
\frac{\partial c }{\partial t} = -m\nabla\mathbf{J}
$$
$$
\mathbf{J} = -\nabla \mu
$$
$$
\mu = f'(c) - k\nabla^2c
$${#eq:CH_bray}

where $f'(c)=\partial f/\partial c$. We're assuming an infinitely thin interface, so the interfacial term is neglegible. Linearizing the chemical potential in $c$ around the dense phase yields $\mu = f''(c_0^+)c$, so that @eq:CH_bray becomes:

$$
\frac{\partial c }{\partial t} = D\nabla^2c
$${#eq:diffusion}

where we've replaced all the constant in front of the right term by $D$. We thus see that linearizing the Cahn-Hilliard equation in the bulk leads to a diffusion equation. The effective droplet theory is most accurate in predicting steady states and thus the time-dependence of @eq:diffusion is ignored. As we've replaced a single equation by two, we need an extra set of boundary conditions at the interface.

### Boundary conditions

To determine the droplet boundary conditions, consider a system which is phase separated and has an infinitely thin interface. The total free energy of the system is then:

$$
F = V_1 f(\phi_1) + V_2 f(\phi_2)
$$

where $V_i$ and $\phi_i$ are respectively the volume and density of phase $i$ and $f(\phi_i)$ is the free energy density. In equilibrium, this free energy is minimized. Assuming incompressibility ($V_1+V_2=V$) and conservation of particles ($V_1\phi_1+V_2\phi_2=V\phi$), we further constrain the system to two independent variables. 
Choosing to minimize the free energy with respect to $\phi_1$ and $V_1$ gives us two conditions:

$$
f'(\phi_1) = f'(\phi_2) = 0
$$

$$
0 = f(\phi_1) + f(\phi_2) + (\phi_2-\phi_1)f'(\phi_2)
$$

Since $f'(\phi) = \mu(\phi)$, the first condition states that both phases must have the same chemical potential, while the second one refers to the matching of osmotic pressure. One obvious solution to these equations is a completely mixed state with $\phi_1=\phi_2$. A non-trivial (phase-separated) solution exists as well, where $\phi_1$ and $\phi_2$ are the two minima of the free energy density function $f(\phi)$. In our system, this corresponds to $c_0^+$ and $c_0^-$. Assuming that our droplet is locally in thermodynamic equilibrium, we can apply this solution as boundary conditions. Concretely,

$$
c(R) = 
\begin{cases}
    c_0^-,& \text{Outside droplet}\\
    c_0^+,& \text{Inside droplet}
\end{cases}
$$

Now that we have defined boundary conditions, equations such as [@eq:diffusion] can be solved. The solution will give us the concentration profile in each phase, but the droplet behaviour is determined by the fluxes across the interface. We show this in the next section. 

### Fluxes and movement of interfaces

Given a concentration profile $c(x)$, the (diffusive) flux can be calculated by applying Ficks' law:

$$
J(x) = -D\frac{\partial c}{\partial x}
$$

Using this expression, we can calculate a flux on the inside of the interface $J_{in}$ and on the outside of the interface $J_{out}$. Note that in and out respectively refer to inside and outside the droplet and not to the direction of the flux. Figure @fig: eff_droplet shows a typical concentration profile of an active droplet. Observe that due to the activity of the droplet, the concentration profile inside the droplet is not flat but convex. Due to this convexity, the flux $J_{in}$ will be pointed inwards, while the flux $J_{out}$ will also be pointed inwards typically due to transport or production. Intuitively, $J_{in}$ is the flux lost due to the decay or activity in the droplet, while $J_{out}$ replaces the converted material inside with material from outside. A steady-state can be achieved once these two fluxes are equal. Note that while the system is at steady state, it is not in equilibrium, as the fluxes across the interface are not zero; the fluxes are balanced, rather than equilibrated. This is a typical characteristic of an active system.

![Figure illuminating the relation between a moving interface and the fluxes across it.](source/figures/pdf/interface.pdf){#fig:interfacespeed}

If the fluxes $J_{in}$ and $J_{out}$ are not balanced, a net flux exists, leading to either growth or decay of the droplet. We wish to derive an expression for interface speed $v_n$ in terms of the fluxes across it. Consider figure @fig:interfacespeed. If we wish to move the interface a distance $\Delta x$, we need a net material gain of $\Delta x \Delta c$. This net gain is supplied by a net flux in a time $\Delta t$, so that:

$$
\Delta x \Delta c = (J_{in}-J_{out})\Delta t
$$

which can be rewritten as:

$$
\frac{\Delta x}{\Delta t} = v_n = \frac{J_{in}-J_{out}}{\Delta c}
$${#eq:interfacespeed}

Thus if $|J_{in}|<|J_{out}|, v_n>0$ and the interface will move to the right. If we consider a 'free' droplet (with two interfaces in 1D), the radius of the droplet is determined by both interfaces. Since the fluxes need not be similar on both sides of the droplet, not only the radius but also the position of interfaces plays a role. We thus characterize the droplet in terms of its radius $R$ and its geometric center $x_0$. Consider a droplet of radius $R$ at position $x_0$. The left and right interfaces move respectively with velocities $v_l$ and $v_r$. In a time $dt$, the droplet than moves to a new postion $x_0+dx$ and will have a new radius $R+dR$:

$$
x_0-R+v_ldt=x_0+dx-(R+dR)
$$
$$
x_0+R+v_rdt=x_0+dx+(R+dR)
$$

Solving this set of equations for $dx$ and $dR$ gives:

$$
\frac{dR}{dt}=\frac{1}{2}(v_r-v_l)
$${#eq:radius}

$$
\frac{dx_0}{dt}=\frac{1}{2}(v_l+v_r)
$${#eq:position}

Equations @eq:radius and @eq:position give the change in radius and position of the droplet. Note that these results are quasi-steady state: we've calculated the fluxes from stationary concentration profiles. Thus equations @eq:radius and @eq:position are best used to calculate (quasi-) steady states and not dynamics. Nevertheless, equation @eq:position shows an interesting feature: active droplets can move on their own. This movement is the result of an imbalance in fluxes between the left and right interface: the droplet center is displaced because one side of the droplet grows faster than the other.  This imbalance is caused by a concentration gradient and droplets will move up the gradient, as the flux on the high concentration side will be higher than on the low side. Finally combining eq. @eq:interfacespeed with eqs. @eq:radius and @eq:position yields the position and radius of the droplet in terms of the fluxes across its interface:

$$
\frac{dR}{dt}=\frac{1}{2\Delta c}\left[(J_{in}^{x=R}-J_{in}^{x=-R})+(J_{out}^{x=-R}-J_{out}^{x=R})\right] 
$$

$$
\frac{dx_0}{dt}=\frac{1}{2\Delta c}\left[(J_{in}^{x=-R}+J_{in}^{x=R})-(J_{out}^{x=-R}+J_{out}^{x=R})\right]
$$

This completes the effective droplet model. It allows us to rewrite the non-linear Cahn-Hilliard equation into two or mroe separate linear problems with proper boundary conditions. Furthermore, these linear problems can be easily extended, such as by adding decay, sources or advection and we will do so in the next section. To solve a typical problem with the effective droplet theory, we thus perform the following steps:

* Identify the domains and correct equations.
* Solve equations inside each domain to obtain concentration profile.
* Calculate the fluxes across the interfaces.
* Obtain steady states at the balance of fluxes.

In the next section we present our model for the Golgi in the effective droplet model.

## Golgi as an active droplet

* The Golgi is able to form de novo (Bevis)
* Microtubules position the golgi near the mtoc (Sengupta)
* Nocadazola depolymerizes microtubules -> golgi stacks move towards ERES (sengupta)
* Golgi size is dependent on amount of trafficking (Sengupta)
* Separate ministacks seems to be fully functional (Wei)
* Golgi disassembly is due to imbalanced trafficking: exit from ER is blocked, while outflow still continues (Ronchi)
* When golgi is completely cut out, stack like struct


In this section we introduce our model for Golgi biogenesis and maintenance. Biologically, our problem encompasses four different populations: the immature cargo, the mature cargo, the Golgi, with all dissolved in the cytoplasm. The immature cargo transforms into the Golgi material, which matures into mature cargo. Similar to **ref**, we model this however in a simple manner with just the immature cargo phase separating in a dilute and dense phase and the mature cargo implicitly.

As stated in the previous chapter, once the microtubules are depolymerized, the Golgi ribbon breaks into separate stacks which colocate with the ERES. If we model not the complete Golgi but a single stack, we can reduce our problem to 1D, where a droplet can move from one side of the system, representing the Golgi ribbon, to the other side, representing the ERES. This simplification permits analytical tractability. We thus end up with a 1D box where the dilute phase represents the cytoplasm, while the dense phase represents a single Golgi stack. 

Proteins exiting the ERES are transported towards the ER over the microtubules. This is a stochastic process with the proteins detaching from and re-attaching to the microtubules randomly. **ref** shows that such a stochastic process can reduce to a Fokker-Planck equation if the attaching and detaching is much faster than the transport itself. As the Fokker-Planck equation is functionally equivalent to an advection-diffusion equation, we hypothesize that we can model protein transport using an advection-diffusion equation. Furthermore, **ref** reports that cargo can disappear without reaching the Golgi and we thus add a decay term to the advection-diffusion equation, resulting in the final equation for the evolution of dilute phase:

$$
D\partial_x^2 c(x) - v\partial_xc(x)-ac(x)=0
$${#eq:cinside}

We will neglect the term on the left as we're working in a quasi-static limit. The first term on the right is a diffusive, the second term advective with advection velocity $v$, while the last term represents the decay. 

**ref** states that after stack-like structures are formed close to the ERES, they are transported to the ribbon by microtubules. Hence we use an advective term next to a diffusive term in the dense phase. As the dense phase represents the Golgi, we need a term to account for maturation of the proteins. Much discussion on this subject exists (see maternal vs. cisternal maturation), but we choose a simple decay-like term. This gives an expression very similar to the dilute phase ([@eq:cinside]), save for a different decay rate:

$$
D\partial_x^2 c(x) - v\partial_xc(x)-kc(x)=0
$${#eq:coutside}

Note that we assume a similar diffusion coefficient in the dense and dilute phase. Choosing different diffusion coefficients would result in slighly different length scales (see next section), but would not affect the main results. As stated, we also model the mature population implicitly, in this case having the effect that the cargo lost due to the decay term exits the system. 

We now turn to the boundary values. As demanded by the effective droplet model, we set at the interface between the droplet and the dilute phase:

$$
c(x_0\pm R)=
\begin{cases}
    c_0^-,& \text{inside of interface}\\
    c_0^+,& \text{outside of interface}
\end{cases}
$$

Our system is a 1D box of length $L$, with the left boundary representing the ERES, modeled as a source, and the right boundary a zero-flux boundary, so that all cargo exits the system either through decay in the dilute phase or maturation in the dense phase:

$$
(-D\partial_xc+vc)|_{x=0} = J_{in}
$$

$$
(-D\partial_xc+vc)|_{x=L} = 0
$$



We solve this set of equations in the next section.

