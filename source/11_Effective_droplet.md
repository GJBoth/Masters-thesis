# Golgi model

In the previous chapter we introduced the Cahn-Hilliard equation. Its non-linearity makes it extremely hard to study and in this chapter we present an approximation known as effective droplet theory. In this chapter we introduce the effective droplet approximation, discuss our models for the Golgi apparatus and show the results for these models.
We've divided the chapter into three sections:

* **Effective droplet theory -** In this section we introduce effective droplet theory.
* **Golgi as an effective droplet-** Here we introduce our model and show 
* **Two-component model-** This third section contains a possible extension of the effective droplet model to two-components.

We end the chapter with a short summary of our conclusions.





### Solution
The general solution of equations @eq:cinside and @eq:coutside is given by:

$$
c(x) = C_1e^{-\frac{x}{l^-}}+C_2e^{\frac{x}{l^+}}
$$

where we have defined $l^\pm$ as:

$$
l^\pm= \frac{2D}{\sqrt{4kD+v^2}\pm v }
$${#eq:lengthscale}

where $k$ should be replaced by $a$ outside the droplet. Note that $l^\pm$ defines the lengthscale of the problem. Without advection it simplifies to $\sqrt{D/k}$ and both lengthscales becomes similar. It is here we see that the advection combined with decay leads to some sort of 'symmetry-breaking' in the droplet and that the effect of advection is more than just translating the droplet. We study this is in the next section. Applying the boundary conditions and calculating the flux at position $x_0+R$ and $x_0-R$ gives the following fluxes outside:

$$
J_{out}^{x=-R} = J_{in}\frac{(1+\frac{l_-}{l_+})e^{\frac{-(x_0-R)}{l_-}}}{Pe_-+Pe_+\frac{l_-}{l_+}e^{\frac{-x_1}{l}}}
+\frac{c_0^{out}D}{l_+}\frac{Pe_+(1-e^{\frac{-x_1}{l}})}{1+\frac{l_-}{l_+}\frac{Pe_+}{Pe_-}e^{\frac{-x_1}{l}}}
$${#eq:leftflux}

$$
J_{out}^{x=R} = -c_0^{out}D\frac{Pe_-Pe_+(1-e^{\frac{-x_2+L}{l}})}{l_+Pe_-+e^{\frac{-x_2+L}{l}}l_-Pe_+}
$${#eq:rightflux}

where we have introduced the coordinates $x_1$ and $x_2$, which are defined respectively as $x_0\pm R$ and correspdon to the left and right interface. We have also defined the Peclet-like numbers $Pe^\pm$:

$$
Pe^\pm = 1 \mp \frac{vl^\pm}{D}
$$

and a new combined lengthscale $l = \frac{l^+l^-}{l^++l^-} = 1/l^++1/l^-$. The flux on the left of the droplet consists of two terms, with the first one accounting for the influx and the second one for the interface with the droplet. The flux on the right is clearly similar, but lacks a second term since we've set a zero-flux boundary at $x=L$.

We now turn to the fluxes on the inside of the droplet. In this case however, the fluxes on the left and right side of the droplet are not of particular importance; considering equations @eq:radius and @eq:position, we're interested in their sum and difference. Introducing $J_{Rad} = J_{in}^{x=R}-J_{in}^{x=-R}$ and $J_{Pos} = J_{in}^{x=R}+J_{in}^{x=-R}$, we obain:

$$
J_{rad} = \frac{-2c_0^+D}{l}\frac{\sinh\frac{R}{l^-}\sinh\frac{R}{l^+}}{\sinh\frac{R}{l}}
$$

$$
J_{pos} = 2c_0^{in}D\left[\frac{Pe_-}{l_-}\frac{\sinh\frac{R}{l_+}\cosh\frac{R}{l_-}}{\sinh\frac{R}{l}}-\frac{Pe_+}{l_+}\frac{\sinh\frac{R}{l_-}\cosh\frac{R}{l_+}}{\sinh\frac{R}{l}}\right]
$$

The equation for the radius can also be interpreted as the maturation flux. It contains an important point with respect to the validity of effective droplet theory. Consider the limit of $R\to\infty$:

$$
\lim_{R\to\infty} = -2c_0^+\sqrt{kD}
$${#eq:radiuslimit}

where for simplicity we have set the advection speed $v$ to zero. For an active droplet one would expect the maturation flux to scale with the radius. However, equation @eq:radiuslimit shows that the maturation flux saturates. The answer to this conundrum is found by studying the concentration profile in the droplet. For $R\gg l$, the concentration in the center of the drop goes to zero, which is unphysical and an artifact of the effective droplet model. Thus effective droplet theory is only valid in the region $R\ll l$. When advection is added back into the mix this point is slightly more nuanced, as advection changes the concentration profile. We show this in the next section.

The equation for the positional flux hints at the effects of the advection and maturation. In a droplet without decay, the concentration profile would be flat and the positional flux would be proportional to $c_0^+v$. Equation  tells a different story. We investigate this in depth in the next section.

### No decay in the dilute phase: the effect of advection

We first study the effect of advection on the droplet by setting the decay in the dilute phase to zero. In this case the flux on the outside of the droplet becomes position-independent:

$$
J_{in}^{x=-R} = J_{in}
$$

$$
J_{out}^{x=R} = 0
$$

This is expected, as the cargo can only exit the system by decaying inside the droplet. The equationa for the flux in the droplet remain unchanged because they are independent of the decay outside. Developing the internal droplet fluxes for $R\ll l^\pm$ gives:

$$
J_{rad}\approx -2 c_0^+kR
$$

$$
J_{pos}\approx
$$

Combining these equations gives us expressions for the growth rate and speed of the droplet:

$$
\frac{dR}{dt}=
$$

$$
\frac{dx_0}{dt}=
$$


Armed with these equations we can study the effect of advection. In figure .. we show the minimum concentration, $dx_0/dt$ and $dR/dt$ as a function of $R$ and $v$. 

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


