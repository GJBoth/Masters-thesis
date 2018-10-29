# Effective droplet

In the previous chapter we introduced the Cahn-Hilliard equation. Its non-linearity makes it extremely hard to study and in this chapter we present an approximation known as effective droplet theory. In this chapter we introduce the effective droplet approximation, discuss our models for the Golgi apparatus and show the results for these models.
We've divided the chapter into three sections:

* **Effective droplet theory -** In this section we introduce effective droplet theory.
* **Golgi as an effective droplet-** Here we introduce our model and show 
* **Two-component model-** This third section contains a possible extension of the effective droplet model to two-components.

We end the chapter with a short summary of our conclusions.

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

In this section we introduce our model for Golgi biogenesis and maintenance. As stated in the previous chapter, once the microtubules are depolymerized, the Golgi ribbon breaks into separate stacks which colocate with the ERES. If we model not the complete Golgi but a single stack, we can reduce our problem to 1D, where a droplet can move from one side of the system, representing the Golgi ribbon, to the other side, representing the ERES. This simplification permits analytical tractability. We thus end up with a 1D box where the dilute phase represents the cytoplasm, while the dense phase represents a single Golgi stack. 

Proteins exiting the ERES are transported towards the ER over the microtubules. This is a stochastic process with the proteins detaching from and re-attaching to the microtubules randomly. **ref** shows that such a stochastic process can reduce to a Fokker-Planck equation if the attaching and detaching is much faster than the transport itself. As the Fokker-Planck equation is functionally equivalent to an advection-diffusion equation, we hypothesize that we can model protein transport using an advection-diffusion equation. Furthermore, **ref** reports that cargo can disappear without reaching the Golgi and we thus add a decay term to the advection-diffusion equation, resulting in the final equation for the evolution of dilute phase:

$$
\frac{\partial c}{\partial t} = D \frac{\partial^2 c}{\partial x^2} - v \frac{\partial c}{\partial x} - ac
$$

We will neglect the term on the left as we're working in a quasi-static limit. The first term on the right is a diffusive, the second term advective with advection velocity $v$, while the last term represents the decay. 

**ref** states that after stack-like structures are formed close to the ERES, they are transported to the ribbon by microtubules. Hence we use an advective term next to a diffusive term in the dense phase. As the dense phase represents the Golgi, we need a term to account for maturation of the proteins. Much discussion on this subject exists (see maternal vs. cisternal maturation), but we choose a simple decay-like term. This gives an expression very similar to the dilute phase ([@eq:cinside]), save for a different decay rate:

$$
D\partial_x^2 c(x) - v\partial_xc(x)-ac(x)=0
$${#eq:coutside}




We use and modify the effective droplet model as a toy model for the behaviour of the Golgi in the cytoplasm. More precisely, the Golgi apparatus in mammalians is a ribbon, consisting of multiple golgi stacks (identical) together. We model a stack as an active droplet in a concentration gradient. Our model is shown in figure . We consider a 1D box of length $L$ with an influx at $x=0$ of $J_{in}$ and a zero flux boundary at $x=L$. Inside the system is a droplet of radius $R$ at position $x_0$. Transport in the system is described by a advection-diffusion-decay equation with a diffusion constant $D$, advection speed $v$ and decay constant $a$ outside and $k$ inside the droplet. The phase separation is governed by a free energy density with two minima at $c_0^-$ (dilute phase) and $c_0^+$ (dense phase).
We thus end up with the following set of equations and boundary conditions in a quasi steady state approach:

$$
D\partial_x^2 c(x) - v\partial_xc(x)-kc(x)=0
$${#eq:cinside}


$$
(-D\partial_xc+vc)|_{x=0} = J_{in}
$$

$$
(-D\partial_xc+vc)|_{x=L} = 0
$$

$$
c(x_0\pm R)=
\begin{cases}
    c_0^-,& \text{inside of interface}\\
    c_0^+,& \text{outside of interface}
\end{cases}
$$

We solve this set of equations in the next section.

### Solution
The general solution of equations @eq:cinside and @eqcoutside is given by

$$
c(x) = C_1e^{-\frac{x}{l^-}}+C_2e^{\frac{x}{l^+}}
$$

where we have defined a lengthscale $l$ as:

$$
l^\pm= \frac{2D}{\sqrt{4kD+v^2}\pm v }
$${#eq:lengthscale}

where ofcourse $k$ should be replaced by $a$ outside the droplet. This lengthscale defines the typical lengthscale of the problem, defined by the diffusion, advection and decay. Setting the decay to zero, $l^\pm\to D/v$ so that both lengthscales become similar. Also, setting $v\to 0$ gives $\sqrt{D/k}$, which up to a dimension dependent numerical factor is similar to Zwickers.

Applying the boundary conditions and calculating the flux at position $x_0+R$ and $x_0-R$ gives the following fluxes outside:

$$
J_{out}^{x=-R} = J_{in}\frac{(1+\frac{l_-}{l_+})e^{\frac{-(x_0-R)}{l_-}}}{Pe_-+Pe_+\frac{l_-}{l_+}e^{\frac{-x_1}{l}}}
+\frac{c_0^{out}D}{l_+}\frac{Pe_+(1-e^{\frac{-x_1}{l}})}{1+\frac{l_-}{l_+}\frac{Pe_+}{Pe_-}e^{\frac{-x_1}{l}}}
$${#eq:leftflux}

$$
J_{out}^{x=R} = -c_0^{out}D\frac{Pe_-Pe_+(1-e^{\frac{-x_2+L}{l}})}{l_+Pe_-+e^{\frac{-x_2+L}{l}}l_-Pe_+}
$${#eq:rightflux}

where we have introduced the coordinates $x_1$ and $x_2$, which are defined respectively as $x_0\pm R$, in other words, the left and right interface the Peclet-like numbers $Pe^\pm$:

$$
Pe^\pm = 1 \mp \frac{vl^\pm}{D}
$$

and the 'average lengthscale' $l = \frac{l^+l^-}{l^++l^-}$. Again note that if $v\to 0$, $Pe^\pm \to 1$ We can recognize that the second term of @eq:leftflux and @eq:rightflux are similar, due to the same boundary conditions. The flux on the left however has the added effect of the influx, clearly visible in the first term. We present approximations of these functions in the next sections, to make them more clearly. 

For the fluxes inside, the expressions are less clear. Note however from eqs @eq: that we're not interested in the separate expressions but their sum or difference. Introducing $J_{Rad} = J_{in}^{x=R}-J_{in}^{x=-R}$ and $J_{Pos} = J_{in}^{x=R}+J_{in}^{x=-R}$, we obain:

$$
J_{rad} = \frac{-2c_0^+D}{l}\frac{\sinh\frac{R}{l^-}\sinh\frac{R}{l^+}}{\sinh\frac{R}{l}}
$$

$$
J_{pos} = 2c_0^{in}D\left[\frac{Pe_-}{l_-}\frac{\sinh\frac{R}{l_+}\cosh\frac{R}{l_-}}{\sinh\frac{R}{l}}-\frac{Pe_+}{l_+}\frac{\sinh\frac{R}{l_-}\cosh\frac{R}{l_+}}{\sinh\frac{R}{l}}\right]
$$

We study all these equations in depth in the following sections, but please note that everything so far is completely analytic; we have made no approximations. (But the whole theory is an approximation, ha-ha.)

An important point about the validity of effective droplet theory must now be made, which is most clear without advection, although our general remarks hold with advection as we'll see. Setting $v=0$ and taking the limit of $J_{rad}\to\infty$, we get:

$$
\lim_{R\to\infty} = -2c_0^+\sqrt{kD}
$$

where the $2$ arises from two interfaces. In other words: the influx due to decay saturates, which is not what we would expect. The answer can be found found by studying the minimum concentration in the droplet. For $R\gg l$, the concentration in the center of the drop goes to zero, which is unphysical and an artifact of the effective droplet model. Thus we always require $R\ll l$. When advection is added this becomes slightly more complicated, as we show in the next section. 

### No decay in the dilute phase: the effect of advection

We first study the effect of advection our test system but without decay outside, i.e. $a=0$. In this case, $l^+=l^-$ and the influx becomes becomes constant on the left side, i.e. J_{in}^{x=-R} = J_{in} and the outflux on the right side 0. Since we're working in a quasi steady state and there's no decay outside, this is expected. 

$$
J_{in}^{x=-R} = J_{in}
$$

$$
J_{out}^{x=R} = 0
$$

while the equationa for the inner flux remain unchanged because they are independent of the decay outside. Armed with these equations we can study the effect of advection. In figure .. we show the minimum concentration, $dx_0/dt$ and $dR/dt$ as a function of $R$ and $v$. 

![]()

In the left panel we show the minimum concentration as a function of $R$ and $v$. The white line shows the concentration corresponding to $l=0.5$ at $v=0$ and we indeed see that advection increases the minimum concentration. In the middle panel we show the increase in radius $dR/dt$ as a function of again $R$ and $v$. Red colors mean positive, blue negative and white zero, so we've plotted with x's the line $dRdt=0$, which corresponds to a stable droplet. On the right we show $dx_0/dt$; where the $dx_0/dt=0$ line crosses with the $dR/dt=0$ line there's a droplet with stable radius and position.

To show this more clearly, we plot the droplet radius and minimum concentration as a function of the advection velocity in figure . Observe that advection decreases the droplet radius by almost $10\%$, while simultaneously also increasing the minimum concentration. The advection is thus 'compacting' the droplet. By what process is this happening? To see this, consider an active droplet without advection. The concentration profile is symmetric and convex; the flux on both sides due to diffusion is inwards and thus in opposite directions. If we now turn on advection, this symmetry is broken. On the left side of the droplet, the diffusion and advection point in the same direction but on the other side they are aligned opposite. This causes an assymetry in the concentration and a difference in the flux to the centre: more goes to it from the left than is taken away by the right, hence compacting the droplet. 

Can advection stabilize a droplet? Zwicker et al show that an active droplet such as ours can divide through a shape instability. Our model is 1D however and not easily scalable to higher D's because of the advection. Simulations would be needed to state anything on this.

We can make a few conclusions about the situation. For a very specific set of parameters, the droplet can both be stable in radius and position. There's no position dependence so not that interesting. Also observe that there are only two situations: either the droplet is moving to the left infinitely, or moving to the right infinitely, as there's no stable position on either side. Which situation happens is controlled by the gradient of the concentration versus the advection. note that we need a non-zero convection to move the droplet from one mode to the other. The explanation is simple: the convection needs to overcome the gradient to reverse droplet movement. At the inflection point, $dx_0/dt=0$.

We now make some very speculative biological connection to the observation of Golgi properties. A strong marker is that once the microtubules are depolymerized, the stacks move away from the perinuclear area and colocate with the ERES. This is what we see when we turn of the advection, the droplet moves up the gradient to the source. A similar thing is seen with biogenesis, the stacks are made around the ERES but need microtubules to be transported to the center.

We have a model which described some features but its unstable. Can we make some position in our system inherently stable? We try in the next section by adding decay to the dilute phase.

### Decay in the dilute phase

We now wish to find a model in which the position has a stable position. So not just a set of parameters where $dx_0/dt=0$, but a position $x_0$ where the droplet is stable. The flux on the inside is independent of the position of the droplet, so to get a stable position we need a position dependent flux on the outside. To this end, we introduce a decay term in the dilute phase. We then end up with the full equations ... . We first numerically solve these equations before attempting an approximation. The result is shown in figure ... and shows a 'phase-diagram' of our active droplet model. In the left panel we show the minimum concentration in the droplet, while the middle and right panel shows the numerical value of $dx_0/dt$ and $d_R/dt$, all as a function of the CoM position $x_0$ and radius $R$. From the right two plots we've extracted the lines $dx_0/dt=0$ and $dR/dt=0$, which we've superimposed on all three panels. Where these lines cross a stable state exist. We first discuss each line independently and then discuss the stable points. 

First consider the line $dR/dt=0$, a droplet with stable radius. We observe that left of the line $dRdt>0$, with the opposite on the right. This means that each radius is stable: a perturbation w.r.t to the radius will not propagate. The $dx_0dt=0$ is more interesting. It has the apperance of a 'finger' and has a stable and unstable branch. The arm below the point is stable, where the arm above the point is not. This has important implications for the crossings: the lower intersection is stable w.r.t. to all perturbations, while the upper intersection is unstable. Pertubations above the dx0dt line will propagat, while perturbations below will move the droplet to the lower intersection. 

This is all fine and dandy, but there's one problem: the lower intersection, the stable point, is unphysical. We characterize the droplet in terms of its center of mass $x_0$ and radius $R$, meaning that the left interface is at a position $x_0-R$. The red line in the plots shows the line $x_0=R$ and everything below this line is unphysical, as it means the left interface is at a position $x_0-R<$, past the system edge. Why does this happen? First, in a dynamical description this wouldn't happen, as the left interface boundary condition prevents moving past. In a static description this can however since we specify the edge of the system as a flux boundary condition. Inspection of the concentration (see figure ) learns that the droplet moves on top of the source: the flux inside the droplet at a point is similar to the boundary condition. In 2D this wouldnt be a problem but in our 1D description it is as the BC is specified as a flux and not as a source. That means we're left with just an unstable point. Why is this point unstable? Investigating the fluxes shows that despite the decay the left interface is an order of magnitude bigger than the right interface, thus behaviour is mainly determined by the left interface. Once the left interface starts moving due to a perturbation, the rest follows. 


## Two-component model
Two components jeeej


## Conclusion


