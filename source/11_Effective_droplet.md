# Results model

The previous chapter introduced phase separation and our model for the Golgi as a phase-separated droplet. In this chapter we solve the equations and present the results and biological implications. The first section solves the model and presents the calculated fluxes through the interface. It also introduces several lengthscales and dimensionless parameters of the problem. As adding advection to an active droplet is a novel approach, we study the affect of advection in the second section. We present the full active-droplet phase diagram in the last section and discuss the biological implications. 

### Solving the model

The first step is to find a general solution to equations @eq:cinside and @eq:coutside. As they are of the same form, the general solution is given by:
$$
c(x) = C_1e^{-\frac{x}{l^-}}+C_2e^{\frac{x}{l^+}}
$$ {#eq:cgeneral}

where we have defined $l^\pm$ as:

$$
l^\pm= \frac{2D}{\sqrt{4kD+v^2}\pm v }
$$ {#eq:lengthscale}

where $k$ should be replaced by $a$ for the concentration in the dilute phase. Note that $l^\pm$ defines the lengthscales of the problem and that due to addition of advection there are two;  without advection it simplifies to $\sqrt{D/k}$. It is here we see that the advection leads to some sort of 'symmetry-breaking' in the droplet and that the effect of advection is more than just moving the droplet. A typical concentration profile for a droplet is shown in figure **FIGURE**. We can associate $l^+$ with the right side of the well and $l^-$ with the left side. We study the effect of advection in the next section. Applying the boundary conditions and calculating the flux at position $x_0+R$ and $x_0-R$ gives the following fluxes outside:
$$
J_{out}^{x=-R} = J_{in}\frac{(1+\frac{l_-}{l_+})e^{\frac{-(x_1)}{l_-}}}{Pe_-+Pe_+\frac{l_-}{l_+}e^{\frac{-x_1}{l}}}
+\frac{c_0^{out}D}{l_+}\frac{Pe_+(1-e^{\frac{-x_1}{l}})}{1+\frac{l_-}{l_+}\frac{Pe_+}{Pe_-}e^{\frac{-x_1}{l}}}
$$ {#eq:leftflux}

$$
J_{out}^{x=R} = -c_0^{out}D\frac{Pe_-Pe_+(1-e^{\frac{-x_2+L}{l}})}{l_+Pe_-+e^{\frac{-x_2+L}{l}}l_-Pe_+}
$$ {#eq:rightflux}

where we have introduced the coordinates $x_1$ and $x_2$, which are defined respectively as $x_0\pm R$ and correspond to the position of the left and right interface. We have also defined the Peclet-like numbers $Pe^\pm$:

$$
Pe^\pm = 1 \mp \frac{vl^\pm}{D}
$$

and a new combined lengthscale $l = \frac{l^+l^-}{l^++l^-} = 1/l^++1/l^-$. The flux on the left of the droplet consists of two terms, with the first one accounting for the influx and the second one for the interface with the droplet. The flux on the right is clearly similar, but lacks a second term since we've set a zero-flux boundary at $x=L$.

We now turn to the fluxes on the inside of the droplet. These fluxes separately are not particularly insightful, but, considering equations @eq:radius and @eq:position, we can study their sum and difference. Introducing $J_{rad} = J_{in}^{x=R}-J_{in}^{x=-R}$ and $J_{pos} = J_{in}^{x=R}+J_{in}^{x=-R}$, we obain:
$$
J_{rad} = \frac{-2c_0^+D}{l}\frac{\sinh\frac{R}{l^-}\sinh\frac{R}{l^+}}{\sinh\frac{R}{l}}
$$

$$
J_{pos} = 2c_0^{in}D\left[\frac{Pe_-}{l_-}\frac{\sinh\frac{R}{l_+}\cosh\frac{R}{l_-}}{\sinh\frac{R}{l}}-\frac{Pe_+}{l_+}\frac{\sinh\frac{R}{l_-}\cosh\frac{R}{l_+}}{\sinh\frac{R}{l}}\right]
$$

The flux $J_{rad}$ is the total flux lost due to maturation, while the flux $J_{pos}$ is the difference in fluxes due to maturation on both sides of the droplet, which is clearly visible in its symmetric construction. $J_{rad}$ contains an important point about the validity of effective droplet theory. Consider it in the limit of $R\to\infty$:
$$
\lim_{R\to\infty} = -2c_0^+\sqrt{kD}
$$ {#eq:radiuslimit}

where for simplicity we have neglected advection. As we have included a maturation term, we would expect the flux due to maturation to scale with $R$, which indeed for small $R$ it does. However, equation @eq:radiuslimit tells us that the maturation flux saturates. Consider again equation @eq:ceq and note that inside the droplet the concentration is convex and decays on a lengthscale $l$. If $R\gg l$, the concentration in the centre of the droplet will go to zero and hence the maturation flux will saturate.  Thus, effective droplet theory is only valid in the region for $R<l$. When we include advection the point is slighly more subtle as advection changes the internal concentration profile of the droplet. We investigate this in the next section. 

## Free droplet

### No decay - the effect of advection

In this section we investigate the effect of advection on an active droplet. Naively, one would expect advection to move the droplet with a velocity $v$, and indeed, for a passive droplet this happens. As the concentration profile is flat inside a passive droplet, the only non-zero flux inside the droplet is due to advection: $J_{adv}=c_0^+v$ , while outside we have $J_{adv} = c_0^-v$, thus giving $dR/dt=0, dx_0/dt=v$. In an active droplet the situation is slight more complex due to the convexity of the concentration profile. The diffusive fluxes point inwards from the interfaces; they're equal in magnitude, but aligned antiparallel. The advective fluxes at the interfaces however are aligned parallelly. The net flux at both interfaces is thus different, as shown in figure **FIGURE**. We now quantify this effect. 

![Figure about fluxes in droplet]()

For simplicity, but without loss of generality, we neglect decay outside the droplet, so that $a=0$. The flux then becomes location independent:
$$
J_{out}^{x=-R} = J_{in}
$$

$$
J_{out}^{x=R} =0
$$

The flux on the right interface of the droplet is zero as there is no source nor decay on the right side of the droplet and in a quasi-steady state approximation the flux then must become zero.The equations for the flux in the droplet remain unchanged as they are independent of the transport parameters. Developing the internal droplet fluxes for $R\ll l^\pm$ gives:
$$
J_{rad}\approx -2 c_0^+kR \left(1 - \frac{k R^2}{3D}\right)
$$ {#eq:jrad}

$$
J_{pos}\approx2 c_0^+v \left(1- \frac{k R^2}{3D}\right)
$$ {#eq:posfluxapprox}

Observe that the positional flux is modified by the same factor as the maturation flux and that due to the activity, the positional flux is a factor $kR^2/3D$ smaller. To see why activity reduces the positional flux, first consider the concentration profile inside the a non-convected active droplet. In this case, the lengthscales $l_-$ and $l_+$ are equal and the droplet is 'symmetric' around the middle of the droplet. Turning on the advection, this symmetry is broken and the lengthscales $l_-$ and $l_+$ change. Specifically, as can be seen from equation @eq:cgeneral, we can associate $l_-$ with the left of the droplet and $l_+$ with the right side of the droplet. Plotting these lengthscales in figure @fig:lengthscales, we observe that $l_+$ decreases with $v$, while $l_-$ increases; the location of the minimum concentration is thus shifted in the directio of the advection. This means that the concentration profile on that side is steeper and hence has a bigger diffusive flux, as shown in **FIGURE**, leading to the decrease in the positional flux. 

Ignoring the third order term in @eq:jrad, we have the following equations for the radius and the position of the droplet:
$$
\frac{dR}{dt} = (-2 c_0^+kR + J_{in})/2\Delta c
$$

$$
\frac{dx_0}{dt} = (2 c_0^+v-J_{in})/2\Delta c
$$

As we are interested in stable droplets, we have $dR/dt=0$, so that $R_{stable} = J_{in}/2c_0^+k$. For the positional change, we have $v=J_{in}/2c_0^+$. This means that a finite velocity is required for the droplet to change direction. To see why, we note that $dx_0(v=0)/dt=-J_{in}/2\Delta c$ and since $J_{in}$ sets the gradient when no advection is present, we see @eq:position in action: the droplet moves up the gradient. Thus, for the droplet to change direction of movement, the advection needs to cancel out the movement due to the gradient and hence a finite advection is required. 

We now study this system numerically. We're most interested in the behaviour of the droplet as a function of $v$ and $J_{in}$ and thus plot in figure @eq:nodecay the stable radius in the left panel and the minimum concentration in the droplet in the right panel as a function of $J_{in}$ and $v$. 

![Plotting in mathematica is terrible.](source/figures/pdf/nodecay.pdf){#eq:nodecay}

We see that for low $v$ the radius is independent of the velocity, but that for higher $v$ the radius decreases. Concurrently, in the right panel we observe that the minimum concentration in the droplet decreases with increasing $J$, but decreases with $v$. The reason is that for increasing $J$, the droplet grows and the concentration inside the droplet thus decreases. We study this in detail in figure @fig:advectioneffect, where we plot the radius and minimum concentration of the line $J=0.25$. 

![Effect of advection.](source/figures/pdf/advectioneffect.pdf){#fig:advectioneffect}

Observe that advection decreases the droplet radius by almost $5\%$, while simultaneously also increasing the minimum concentration. The advection is thus 'compacting' the droplet. This compacting is also the cause of the increased minimum concentration. The compaction is again a consequence of the fluxes; since the fluxes are aligned on the side facing the advection, this side experiences a higher flux than the interface on the other side, hence compacting the droplet. 

How stable is the equilibrium droplet? Perturbing $dR/dt$ around the equilibrium $R$ gives $d\delta r/dt=-2c_0^+k\delta r$. Since both $k$ and $c_0^+$ are bigger than zero, any fluctutations cancel so that the equilibrium is stable.  The blue line is $dx_0/dt=0$. As expected, increasing the $J_{in}$ increases the gradient and a larger velocity is required to counteract the movement of the droplet up this flow. These positions where both the droplet radius and droplet position are stable are not specific points inside the system; rather they are a specific set of parameters for which the droplet speed becomes zero. 

### 

We now wish to find a model in which the position has a stable position. So not just a set of parameters where $dx_0/dt=0$, but a position $x_0$ where the droplet is stable. The flux on the inside is independent of the position of the droplet, so to get a stable position we need a position dependent flux on the outside. To this end, we introduce a decay term in the dilute phase. We then end up with the full equations ... . We first numerically solve these equations before attempting an approximation. The result is shown in figure ... and shows a 'phase-diagram' of our active droplet model. In the left panel we show the minimum concentration in the droplet, while the middle and right panel shows the numerical value of $dx_0/dt$ and $d_R/dt$, all as a function of the CoM position $x_0$ and radius $R$. From the right two plots we've extracted the lines $dx_0/dt=0$ and $dR/dt=0$, which we've superimposed on all three panels. Where these lines cross a stable state exist. We first discuss each line independently and then discuss the stable points. 

First consider the line $dR/dt=0$, a droplet with stable radius. We observe that left of the line $dRdt>0$, with the opposite on the right. This means that each radius is stable: a perturbation w.r.t to the radius will not propagate. The $dx_0dt=0$ is more interesting. It has the apperance of a 'finger' and has a stable and unstable branch. The arm below the point is stable, where the arm above the point is not. This has important implications for the crossings: the lower intersection is stable w.r.t. to all perturbations, while the upper intersection is unstable. Pertubations above the dx0dt line will propagat, while perturbations below will move the droplet to the lower intersection. 

This is all fine and dandy, but there's one problem: the lower intersection, the stable point, is unphysical. We characterize the droplet in terms of its center of mass $x_0$ and radius $R$, meaning that the left interface is at a position $x_0-R$. The red line in the plots shows the line $x_0=R$ and everything below this line is unphysical, as it means the left interface is at a position $x_0-R<$, past the system edge. Why does this happen? First, in a dynamical description this wouldn't happen, as the left interface boundary condition prevents moving past. In a static description this can however since we specify the edge of the system as a flux boundary condition. Inspection of the concentration (see figure ) learns that the droplet moves on top of the source: the flux inside the droplet at a point is similar to the boundary condition. In 2D this wouldnt be a problem but in our 1D description it is as the BC is specified as a flux and not as a source. That means we're left with just an unstable point. Why is this point unstable? Investigating the fluxes shows that despite the decay the left interface is an order of magnitude bigger than the right interface, thus behaviour is mainly determined by the left interface. Once the left interface starts moving due to a perturbation, the rest follows. 

## Droplet stuck to walls


## Conclusion

### Biological implications

We now make some very speculative biological connection to the observation of Golgi properties. A strong marker is that once the microtubules are depolymerized, the stacks move away from the perinuclear area and colocate with the ERES. This is what we see when we turn of the advection, the droplet moves up the gradient to the source. A similar thing is seen with biogenesis, the stacks are made around the ERES but need microtubules to be transported to the center.

