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

We now include the decay outside the system. In this case the outer fluxes are dependent on the position of the droplet  and this changes the story quite a bit as we'll see. We solve equations @eq:dingen numerically in figure @fig: by finding simultaneously the set $R_{stable}$ and $x_{0,stable}$ for which $dr/dt$ and $dx_0/dt$ are zero inside the domain of our system, i.e. $0<x_0<L$, $0<R<L/2$. For k=0.3, a=0.1, D=1 c0=0.1,0.9 we find the following:

![](source/figures/pdf/Rstable.pdf)

![](source/figures/pdf/Xstable.pdf)

We observe completely different behaviour of the droplet compared to the system with no decay. First, note that there's no droplet in the system for a large area of the parameters. This has three different causes: due to the decay outside the droplet, a minimum influx is required for a droplet, as cargo can now exit the system without passing through the droplet. This explains the lower left cutoff of the 'finger' for both plots. Studying the stable position diagram, we see that the upper left cutoff is caused by the droplet exiting the system on the right and the lower right cutoff by the droplet exiting the system on the left. This is extremely peculiar: by increasing the advection, the droplet moves closer to the source. Why? 1D effect or not?

We study the equilibrium of this point in figures @fig, where we plot the for Jin=0.18, v=0.1 $dx/dt$ and $dR/dt$. The solid black lines superimposed on the plot denote the line $dr/dt=0$ and the dashed lines $dx_0/dt=0$. The red line is the line $x_0=R$. If the crossing is below that line, it is unphysical as the the left interface would outside of the system.  Note that the line $dr/dt=0$ is zero, i.e. the droplet radius is stable w.r.t to fluctuations, but the droplet position is not. This means that the steady state is unstable. 

![](source/figures/pdf/dRdt.pdf)

![](source/figures/pdf/dXdt.pdf)

 To conclude, save for the unstable equilibria, there exists no point at which the droplet is stable in the middle of the system. It either keeps moving to the right ($dx/dt>0$) or to the left, $dx/dt<0$. However, our system is finite and this model doesnt describe that. We thus develop a model where the droplet is stuck to the sides of the system like a wetting layer. 

## Droplet stuck to walls

We've shown that the free droplet moves either left or right. This means that the only steady states are droplets stuck to the walls. In this section we study how such a droplet would behave. In the previous section we assumed the existence of a droplet and studied its behaviour. In this section we take broader view and first estimate when a droplet would appear. We then prove that a stable droplet exists if such a transition occurs and find that, even though our approach is an approximation, mass is conserved through the phase separation. Finally we present the final phase diagram and state the biological implications. 

### Occurence of phase separation



In the previous section we've shown that once the concentration reaches one of the inflection points, the system will phase separate. We now study when exactly this happens. We thus study an advection-diffusion-decay system with a source on one side and a no-flux boundary on the left. The highest concentrations will then always be at the edges of the system, so we determine the concentrations at each side of the system. We're most interested in the influx $J_{in}$ and advection speed $v$, so we determine for $v$ at which $J_{in}$ the concentration on the left and right reaches the inflection point.
$$
\text{Left:  }J_{in} = - \frac{ 2al((1-\frac{1}{\sqrt{3}}c_0^+)+(1+\frac{1}{\sqrt{3}}c_0^-))}{\frac{vl}{D}-coth(\frac{L}{2l})}
$$

$$
\text{Right: } J_{in} =al((1-\frac{1}{\sqrt{3}}c_0^+)+(1+\frac{1}{\sqrt{3}}c_0^-))\left(e^{-\frac{L}{2l}(\frac{vl}{D}-1)}-e^{-\frac{L}{2l}(\frac{vl}{D}+1)}\right)
$$



Where $l$ is some lengthscale $l=D/\sqrt{4aD+v^2}$. We plot these two curves in the figure below:

![Blue line: Minimum J left side. Orange line: minimum J right side.](/Users/gert-janboth/Library/Application%20Support/typora-user-images/image-20181112113459099.png)

We can recognize four areas in this plot. Below both the blue and the orange line, the concentration doesn't become high enough anywhere and no phase separation will happen. Below the orange line and above the blue line, on the left, only a droplet on the left is stable, while on the right exactly the reverse; only the right is stable. Above both lines the concentration is high enough on both sides. This plot onyl tells us when phase-separation should happen; it doesn't tell if it does. We investigate this in the next section.

Where do the two lines cross? We expand the minimal J's to second order in $v$ around 0, as the plot above shows that doing it in first order will severely underestimate the crosspoint. The obtained expressions are then again linearized to first order  in $a$, yielding:
$$
v^* = \frac{aL}{2}
$$
which, compared to the plot, is remarkably close. 

### Effective droplet

We now need to prove that indeed a stable droplet exists if phase separation happens according to the plot above.We thus investigate at which parameters a droplet with $R=0$ and $dR/dt|_{R=0}=0$ exists. For the left and right droplet, we find the following relations:
$$
\text{Left:  }J_{in} = - \frac{ 2a c_0^-l}{\frac{vl}{D}-coth(\frac{L}{2l})}
$$

$$
\text{Right: } J_{in} =ac_0^-l\left(e^{-\frac{L}{2l}(\frac{vl}{D}-1)}-e^{-\frac{L}{2l}(\frac{vl}{D}+1)}\right)
$$

where $l$ is some lengthscale $l=D/\sqrt{4aD+v^2}$. We now compare this to the 'phase-diagram' we have obtained from studying the flow equation. By dividing the minimum flux from the flow model by the minimum flux obtained from the effective droplet model, we obtain:
$$
\frac{J^{AD}}{J^{ED}} = \frac{(3-\sqrt{3})c_0^++(3+\sqrt{3})c_0^-}{6c_0^-}
$$
For both the droplet on the left and right. We see that $J^{AD}/J^{ED}>1$ if $c_0^+>c_0^-$, which it is by definition. In other words, if dilute concentration reaches the inflection point in the AD model, a stable effective droplet is guaranteed to exist. It also means that once phase separation occurs to the AD model, the effective droplet predicts a non-zero radius. Although this is dynamics and we do statics so there's nothing more we can really say about it. We also have:
$$
\frac{J^{AD}_{left}}{J^{AD}_{right}} = \frac{J^{ED}_{left}}{J^{ED}_{right}}
$$
meaning that the velocity at which the two left and right minima cross is the same for the both models. The implication of this is that the difference between when the phase-separation happens according the AD model and the ED model is due to the difference in concentration. As we're looking for a steady state description, we continue with the AD model. According to our calculations, there is an area where both droplets can exist at the same time. We investigate this using   a model with two droplets. Performing a similar analysis (i.e. dR1/dt=dR2dt=0, R1=R2=0) yields:
$$
J = \frac{c_0^-D}{2l}\left(\frac{vl}{D}+\frac{(1+e^{\frac{L}{l}}-2e^{\frac{-L}{2l}(\frac{vl}{D}-1)})}{(1-e^{\frac{L}{l}})}\right)
$$
and a critical speed above which droplets appear:
$$
v^*=\frac{aL}{2}
$$
This critical speed is similar to the crossing of the left and right droplet! This means there's some sort of critical point? As the numerics in the next section show, this a robust point and not just a first order effect. 





![image-20181112121152157](/Users/gert-janboth/Library/Application%20Support/typora-user-images/image-20181112121152157.png)

There is a tiny sliver of left or right between the droplets on the left and right and droplets on the right, but we ignore this as its really small. 

### Mass conservation

We now study mass conservation by comparing the mass in a non-separated system with a phase separated. For simplicity we set $k\to a$. Given any concentration profile (either above or below critical concentration) given by an advection-diffusion-decay equation, the mass in the system is:
$$
\int_0^L c(x)dx = \frac{J_{in}}{a}
$$
which makes sense as $J_{in}$ is what comes into the system and $a$ what goes out. Now, given the same parameters $J_{in}, a$ there exists some phase-separated configuration with stable droplet radius $R^*$. Without loss of generality, we assume $J_{in}$ and $a$ are such the droplet appears on the left side of the system. The total mass inside such a system is:
$$
\int_0^{R^*}c_{in}(x)dx + \int_{R^*}^Lc_{out}(x)dx
$$
Where the stable droplet radius $R^*$ corresponds to $dR/dt|_{R=R^*}=0$. Assuming the droplet radius remains small, we expand both the total mass as well as the stable droplet radius in a first order Taylor series around $R=0$,  which when combined gives:
$$
\int_0^{R^*}c_{in}(x)dx + \int_{R^*}^Lc_{out}(x)dx=\frac{J_{in}}{a}
$$
We thus see that mass is conserved when phase separation occurs. 

## ### Analysis of droplet and numerical results

Bladiebladiebla analytical expressions of the droplet size. 

We numerically solve equations xxx for the interface speed to obtain a phase diagram:![image-20181112150413329](/Users/gert-janboth/Library/Application%20Support/typora-user-images/image-20181112150413329.png)

## Biological implications

We've build a model 

We now make some very speculative biological connection to the observation of Golgi properties. A strong marker is that once the microtubules are depolymerized, the stacks move away from the perinuclear area and colocate with the ERES. This is what we see when we turn of the advection, the droplet moves up the gradient to the source. A similar thing is seen with biogenesis, the stacks are made around the ERES but need microtubules to be transported to the center.

