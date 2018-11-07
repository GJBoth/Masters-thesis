# Introduction to Golgi as a phase separated droplet

In this second part of the thesis we develop a model linking the Golgi function and size to the properties of the intracellular transport. We start with a general section on phase separation, followed by a section where we introduce an approximation. This approximation, known as the effective-droplet approximation, makes phase separation analytically tractable. We then introduce our model and its biological justification. The results of our model will be presented in the next section. 


## Phase separation

Consider a mixture of two molecules, type A and B, with underling interaction strengths $\chi_{ij}$. Depending on the strength and sign of these interactions, the system is either in a mixed state with a constant concentration of A and B, or in a phase-separated state. Landau showed that instead of a complete statistical description, phase separation could be modeled by a system with a double well free energy function [@bray_theory_2002]. We can define an *order parameter* $c=N_A/N_B$ which describes the state of the system and define a free energy density function $f(c)$ with minima at $c_0^-$ and $c_0^+$:
$$
f(c) = \frac{b}{2(\Delta c)^2}(c-c_0^-)^2(c-c_0^+)^2
$$

where $b$ characterizes the strength of molecular interactions and $\Delta c = |c_0^--c_0^+|$. Once the system phase separates, the system will have two areas of concentration $c_0^+$ and $c_0^-$ with a boundary inbetween. Associated with this boundary is a surface tension, so that the full free energy of the system becomes

$$
F(c) = \int dV (f(c)+\frac{1}{2}\kappa (\nabla c)^2
$$

To find the equilibrium concentration profile, we minimize this free energy:

$$
\frac{\delta F}{\delta c} = f'(c)-k\nabla^2c=\mu(x) =0
$$ {#eq:euler}

where $\delta F/\delta c$ is a functional derivative, as we minimize with respect to the concentration *profile*. Solving such an equation is generally not possible due to the third order terms of the free energy density function, but in 1D equation @eq:euler has been solved to yield:
$$
c(x) = \frac{c_0^-+c_0^+}{2}+\frac{c_0^+-c_0^-}{2}\tanh\left(\frac{x}{w}\right)
$$ {#eq:domainwall}
where $w=\sqrt{\kappa/b}$ is the width of the boundary. When we quench a system from a mixed stated into a phase separated state (a process known as spinodal decomposition), the actual concentration profile is a far cry from equation @eq:domainwall. Inside the system, maze-like domains form and keep growing untill a single dense and dilute phase are left. This is shown in figure @fig:maze.

![Cahn hilliard domains](source/figures/png/CahnHilliard.png){#fig:maze}

In this process, the dynamics need to be taken explicitly into account. In the case of liquid-liquid phase separation, the order parameter $c$ is conserved, as a molecule of type A cannot change into type B. This means that the order parameter can only exchange locally, so that:
$$
\partial_t c = -\nabla \cdot \mathbf{j}
$$

where $\mathbf{j}$ is a flux. We can relate the flux to the chemical potential:

$$
j = -m \nabla \mu
$$

where $m$ is a coefficient characterizing the mobility. Equation @eq:euler also gives us an expression for the chemical potential, so that we finally obtain the *Cahn-Hilliard equation*:

$$
\frac{\partial c}{\partial t}=m\nabla^2[f'(c)-k\nabla^2c]
$$

It is this equation which governs the behaviour observed in figure @fig:maze. Due to its non-linearity and fourth order derivatives simply solving the Cahn-Hilliard is usually forsaken in favour of deriving a scaling relation, which relates the domain growth speed $dR/dt$ to the domain size $R$ or some other system parameters. 

## Golgi as an active droplet

 In the introduction we justified using a phase-separation approach. In this section we develop our model for the Golgi from biological considerations, but having established the mathematical background of phase separation, we parallely present the mathematical description. 

We can recognize four different populations in our system: immature cargo -heading to the Golgi-,  mature cargo, -originating from the Golgi and which is produced from immature cargo in the golgi-, the Golgi itself and the cytoplasm, which acts as the solute. We start by reducing this set of populations to a system described by a single concentration $c$. Assuming maturation from the Golgi as a oneway process, i.e. immature cargo turns into mature cargo but not otherwise, and no interaction between the mature and immature cargo during intracellular transport, we can ignore the mature cargo. Modeling the solvent implicitly, the immature cargo in the cytoplasm is then represented by a dilute phase in some concentration $c$, while the Golgi is described by a dense phase in the same concentration.**FIGURE?**

Upon adding the drug nocadazole to mammalian cells, the microtubules are depolymerized and the Golgi ribbon breaks up into separate stacks. These stacks are fully functional [@wei_unraveling_2010] and move away from their perinuclear location to colocate with an ERES. If we model not the complete Golgi but a single stack, we can reduce our problem to 1D, where a stack can move from one side of the system, representing the Golgi ribbon, to the other side, representing the ERES. As each stack is fully functional, we make no simplifications with respect to the function of the Golgi. For now, we model the maturation as a decay-like term inside the dense phase, so that the equations for phase separation become:
$$
\frac{\partial c}{\partial t} = -\nabla J -kc\\
J = - m \nabla \mu\\
\mu = f'(c) - \kappa\nabla^2 c
$$
where $k$ is a decay constant which is non-zero in the dense phase. 

* The Golgi is able to form de novo (Bevis)
* Microtubules position the golgi near the mtoc (Sengupta)
* Nocadazola depolymerizes microtubules -> golgi stacks move towards ERES (sengupta)
* Golgi size is dependent on amount of trafficking (Sengupta)
* Separate ministacks seems to be fully functional (Wei)
* Golgi disassembly is due to imbalanced trafficking: exit from ER is blocked, while outflow still continues (Ronchi)
* When golgi is completely cut out, stack like struct






Proteins exiting the ERES are transported towards the ER over the microtubules. This is a stochastic process with the proteins detaching from and re-attaching to the microtubules randomly. **ref** shows that such a stochastic process can reduce to a Fokker-Planck equation if the attaching and detaching is much faster than the transport itself. As the Fokker-Planck equation is functionally equivalent to an advection-diffusion equation, we hypothesize that we can model protein transport using an advection-diffusion equation. Furthermore, **ref** reports that cargo can disappear without reaching the Golgi and we thus add a decay term to the advection-diffusion equation, resulting in the final equation for the evolution of dilute phase:

$$
D\partial_x^2 c(x) - v\partial_xc(x)-ac(x)=0
$$ {#eq:cinside}

We will neglect the term on the left as we're working in a quasi-static limit. The first term on the right is a diffusive, the second term advective with advection velocity $v$, while the last term represents the decay. 

**ref** states that after stack-like structures are formed close to the ERES, they are transported to the ribbon by microtubules. Hence we use an advective term next to a diffusive term in the dense phase. As the dense phase represents the Golgi, we need a term to account for maturation of the proteins. Much discussion on this subject exists (see maternal vs. cisternal maturation), but we choose a simple decay-like term. This gives an expression very similar to the dilute phase ([@eq:cinside]), save for a different decay rate:

$$
D\partial_x^2 c(x) - v\partial_xc(x)-kc(x)=0
$$ {#eq:coutside}

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



## Effective droplet 

Consider again equation @eq:domainwall. If $w\ll1$, we can approximate the system by describing it as two bulk phases, separated by an interface. In each bulk phase we solve a linearized version of the chemical potential and match these two solutions at the interface. The droplet growth can then be written in terms of the fluxes across the interface. Linearizing the chemical potential yields a diffusion equation:
$$
\frac{\partial c }{\partial t} = D\nabla^2c
$$ {#eq:diffusion}

where we've absorbed all the coefficients into a single coefficient $D​$. To determine the droplet boundary conditions, we assume the system is in thermodynamic equilibrium consider a system which is phase separated and has an infinitely thin interface. The total free energy of the system is then:

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
$$ {#eq:interfacespeed}

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
$$ {#eq:radius}

$$
\frac{dx_0}{dt}=\frac{1}{2}(v_l+v_r)
$$ {#eq:position}

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

