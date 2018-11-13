# Golgi as a phase separated droplet

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

It is this equation which governs the behaviour observed in figure @fig:maze. Due to its non-linearity and fourth order derivatives simply solving the Cahn-Hilliard is usually forsaken in favour of deriving a scaling relation, which relates the domain growth speed $dR/dt$ to the domain size $R$ or some other system parameters. Another option is to study the system in the so-called effective droplet approximation, as we do in the next section.

## Effective droplet 

Consider again equation @eq:domainwall. If $w\ll1$, we can approximate the system by describing it as two bulk phases, separated by an interface. If we apply correct boundary conditions at the interface, we can essentially split the system into two separate problems for the dense and dilute phase and match them at the interface. We thus model the phase separated system as a droplet which exchanges material with its environment through its interface, as shown in figure @fig:effectivedroplet

![Model of an effective droplet. Blue line is full Cahn-Hilliard, black dashed line effective droplet.](source/figures/pdf/effectivedroplet.pdf){#fig:effectivedroplet}

 By assuming the interface to be at thermodynamic equilibrium, the growth of the droplet is described in terms of the fluxes across the interface. Consider again equation @eq:euler. As we can neglect the interfacial term, we have $\mu = f'(c)$. In each bulk phase, we linearize the chemical potential around it's equilibrium density ($c_0^-$ or $c_0^+$) to yield:
$$
\frac{\partial c }{\partial t} = D\nabla^2c
$$ {#eq:diffusion}

where we've absorbed all the coefficients into a single coefficient $D$. Observe that we have obtained a diffusion equation. Since we now have a linear equation in $c$, we can analytically solve this. Moreover, it is possible to add additional effects such as decay, production or advection and still keep an analytically solvable model, as we show in the next section and chapter. 

By introducing the interface and breaking the problem into two separate parts, we need two new boundary conditions to solve equations such as @eq:diffusion. By assuming the interface to be at thermodynamic equilibrium, we will derive a set of boundary conditions independent of the position, size or kinetic parameters of the droplet. Consider such a phase-separated system with an infinitely thin interface. The total free energy of the system can then be written as:
$$
F = V_1 f(\phi_1) + V_2 f(\phi_2)
$$

where $V_i$ and $\phi_i$ are respectively the volume and concentration of phase $i$ and $f(\phi_i)$ is the free energy density.  Assuming incompressibility ($V_1+V_2=V$) and conservation of particles ($V_1\phi_1+V_2\phi_2=V\phi$) constrains the system to two free variables, so that minimizing the free energy with respect to $\phi_1$ and $V_1$ gives us two conditions:

$$
f'(\phi_1) = f'(\phi_2)
$$

$$
0 = f(\phi_1) + f(\phi_2) + (\phi_2-\phi_1)f'(\phi_2)
$$

Since $f'(\phi) = \mu(\phi)$, the first condition states that both phases must have the same chemical potential, while the second one states that both phases must have equal pressure. The obvious solution to these equations is a completely mixed state with $\phi_1=\phi_2$. A non-trivial phase-separated solution exists as well, where $\phi_1$ and $\phi_2$ are the two minima of the free energy density function $f(\phi)$. Note that this valid for droplets in 1D. In higher dimensions, the curvature of the droplet will affect the boundary conditions due to the Laplace pressure, but one can show that this leads to an extra term which scales with $1/R$[@weber_physics_2018].

Having defined boundary conditions, equations such as [@eq:diffusion] can be solved. Although one could solve these equations fully time-dependent using Green's functions, we assume a quasi-steady state so that $dc/dt=0$.This will give us the concentration profiles in and outside the droplet, droplet growth however is determined by the fluxes across the interface. We show this in the next section. 

### Fluxes, activity and interfaces

Given a concentration profile $c(x)$, a diffusive flux can be calculated by applying Ficks' second law:

$$
J(x) = -D\frac{\partial c}{\partial x}
$$

Using this expression, the flux at the interface on the inside and outside of the droplet, $J_{in}$ and $J_{out}$, can be calculated. Note that in and out respectively refer to inside and outside of the droplet rather than the direction of the flux; our boundary conditions fix the concentration at the interface but not the (direction of the) fluxes. If these fluxes are not balanced, there exists a net flux across the interface which leads to either growth or decay of the droplet. As the droplet changes size, the interface moves with a speed $v_n$. We derive an expression for  $v_n$ in terms of the fluxes across it. To move the interface a distance $\Delta x$, a net material gain of $\Delta x \Delta c$ is needed. This net gain is given by the net flux in a time $\Delta t$, so that:
$$
\Delta x \Delta c = (J_{in}-J_{out})\Delta t
$$
which can be rewritten as:
$$
\frac{\Delta x}{\Delta t} = v_n = \frac{J_{in}-J_{out}}{\Delta c}
$$ {#eq:interfacespeed}
In the passive case (and assuming quasi-steady state), the concentration both inside and outside the droplet would be described by a solution to laplace's equation (i.e. $\nabla^2c=0$), leading to a flat concentration profile $c_{out}(x)=c_0^-$, $c_{in}(x)=c_0^+$ and hence $J=0$ everywhere; the system is at thermodynamical equilibrium with $\mu=0$ and the droplet doesn't change size as $v_n=0$. Placing such a droplet in a supersaturated environment where $c_{out}(x)>c_0^-$ would lead to a lead to a non-zero $J_{out}$, resulting in the droplet growing to infinity by a process known as Ostwald ripening. As we show in the next section, active droplet supress the Ostwald ripening [@zwicker_suppression_2015], leading to a droplet with a finite radius.

We now make the droplet *active* by adding a chemical reaction in the droplet which decays the droplet material A into some other other material B. Assuming material B diffuses very fast and is thus always in equilibrium, we ignore material B and describe solely $A$. Adding a decay term to equation @eq:diffusion gives:
$$
D\nabla^2c-kc=0
$$ {#eq:activity}
where $k$ is a decay constant. Solving equation @eq:activity will always give a convex solution and hence a finite $J_{in}$. A typical concentration profile for an active droplet is shown in figure @fig:activedroplet. 

![Typical concentration profile of active droplet. Taken from @zwicker_growth_2017](source/figures/png/activedroplet.png){#fig:activedroplet}

The 'decay flux' $J_{in}$ will need to balanced by a flux into the droplet $J_{out}$ for a stable droplet to exist. This is a key property of active systems: while the system is at steady state (i.e. $v_n=0$), it is not at thermodynamical equilibrium, as $\mu \neq 0$ and $J\neq0$. Another fascinating property of active droplets is that they can propel themselves. To see this, consider a droplet of radius $R$ at position $x_0$ with two interfaces moving respectively at $v_l$ and $v_r$. In a time $dt$, the droplet moves to a new postion $x_0+dx$ and will have a new radius $R+dR$:
$$
x_0-R+v_ldt=x_0+dx-(R+dR)
$$
$$
x_0+R+v_rdt=x_0+dx+(R+dR)
$$

Solving this set of equations for $dx$ and $dR$ gives:

$$
\frac{dR}{dt}=\frac{1}{2\Delta c}(v_r-v_l)
$$ {#eq:radius}

$$
\frac{dx_0}{dt}=\frac{1}{2\Delta c}(v_l+v_r)
$$ {#eq:position}

Combining these equations with equation @eq:interfacespeed finally relates the growth and movement of the droplet to the fluxes across the interface:
$$
\frac{dR}{dt}=\frac{1}{2\Delta c}\left[(J_{in}^{x=R}-J_{in}^{x=-R})+(J_{out}^{x=-R}-J_{out}^{x=R})\right]
$$

$$
\frac{dx_0}{dt}=\frac{1}{2\Delta c}\left[(J_{in}^{x=-R}+J_{in}^{x=R})-(J_{out}^{x=-R}+J_{out}^{x=R})\right]
$$

Studying equations @eq:radius and @eq:position shows that movement only happens if the fluxes are asymmetrical; the droplet center is displaced because one side of the droplet grows faster than the other.  This imbalance is caused by a concentration gradient and thus *droplets will move up the gradient*, as the flux on the high concentration side will be higher than on the low side. 

These equations allow us to find steady states both with respect to the size and the position of the droplet. In the next section we adapt the equations to model the Golgi and couple it to the intracellular transport through the calculations of the fluxes $J_{out}$. We do so in the next section.

## Golgi as an active droplet

 In the introduction we justified using a phase-separation approach to describe the Golgi. In this section we develop our model for the Golgi from biological considerations, but having established the mathematical background of phase separation, we parallely present the mathematical description. 

We can recognize four different populations in our system: immature cargo -heading to the Golgi-,  mature cargo, -originating from the Golgi and which is produced from immature cargo in the golgi-, the Golgi itself and the cytoplasm, which acts as the solute. We start by reducing this set of populations to a system described by a single concentration $c$. Assuming maturation from the Golgi as a oneway process, i.e. immature cargo turns into mature cargo but not otherwise, and no interaction between the mature and immature cargo during intracellular transport, we can ignore the mature cargo. Modeling the solvent implicitly, the immature cargo in the cytoplasm is then represented by a dilute phase in some concentration $c$, while the Golgi is described by a dense phase in the same concentration.

Upon adding the drug nocadazole to mammalian cells, the microtubules are depolymerized and the Golgi ribbon breaks up into separate stacks[@sengupta_control_2011] . These stacks are fully functional [@wei_unraveling_2010] and move away from their perinuclear location to colocate with an ERES. If we model not the complete Golgi but a single stack, we can reduce our problem to 1D, where a droplet can move from one side of the system, representing the Golgi ribbon, to the other side, representing the ERES. As each stack is fully functional, we make no simplifications with respect to the function of the Golgi. Although many complex models of the maturation exist, we model it as a simple decay-like term:

$$
\frac{\partial c}{\partial t} = -\nabla J -kc
$$
$$
J = - D \nabla c
$$
where $k$ is a maturation constant. We now turn our attention to the intracellular transport. In our model fitting chapter we presented an argument that we could model the intracellular transport as an advection-diffusion equation. Evidence exists of vesicles refusing with the ER[@ronchi_positive_2014], so we add an additional decay term, so that the concentration outside the droplet is described is described by:

$$
D\partial_x^2 c(x) - v\partial_xc(x)-ac(x)=0
$$ {#eq:cinside}

with $v$ an advection velocity and $a$ some decay constant. Solving this equation will lead to a concentrion profile with a gradient and we thus model our golgi as an active droplet growing in a concentration gradient, inspired by @weber_droplet_2017. A study of the biogenesis of the golgi [@ronchi_positive_2014] shows that stacks are transported to the ribbon over the microtubules, so we thus add the advection also to the dense phase:
$$
D\partial_x^2 c(x) - v\partial_xc(x)-kc(x)=0
$$ {#eq:coutside}

Note that the dense and dilute phase description are thus almost similar, save for a different decay (maturation) constant. One could pick different diffusion constants and advection speeds, but for simplicity and without loss of generality we pick the same. As our free energy function has minima at $c_0^+$ and $c_0^{-}$, our boundary conditions at the interface are:
$$
c(x_0\pm R)=
\begin{cases}
    c_0^+,& \text{inside}\\
    c_0^-,& \text{outside}
\end{cases}
$$

As stated, we model our system in 1D, with one boundary representing the ERES and the other boundary as the location of Golgi Ribbon. We place the ERES on the left side of the system and thus model this boundary as source:
$$
(-D\partial_xc+vc)|_{x=0} = J_{in}
$$

whereas the right boundary is merely the edge of the system and we thus model it as a zero-flux boundary:
$$
(-D\partial_xc+vc)|_{x=L} = 0
$$

We solve this set of equations in the next chapter. 



