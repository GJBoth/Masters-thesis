





# Phase diagram

Gert-Jan Both - 12/11/2018

## Free energy

Consider the double well free energy with minima at $c_0^-$ and $c_0^+$:
$$
f(c) = \frac{b}{2\Delta c^2}(c-c_0^-)^2(c-c_0^+)^2
$$
A system is a thermal equilibrium when $\mu = df/dc =0$ and a state is stable if $d^2f/dc^2>0$. If $d^2f/dc^2<0$, the state is unstable as fluctuations keep growing; the system phase separates. The points at which $d^2f/dc^2=0$ is called the spinodal/inflection points and the area between the spinodal phase separates. Plotting the free energy density, we see that the middle hill between the points $c=(c_0^++c_0^-)/2\pm\sqrt{3}(c_0^+-c_0^-)$ is unstable.  

What does this mean for our system? The effect of the advection is to change the concentration; the dilute phase becomes denser while the dense phase becomes more dilute. Once the concentration reaches the inflection points, the dilute phase will phase separate, hence the occurence of a droplet, while once the dense phase goes past the inflection point, it will introduce a dilute phase; we get another interface. In the next section we investigate when this happens.

## Advection-Diffusion: when does phase separation happen?

In the previous section we've shown that once the concentration reaches one of the inflection points, the system will phase separate. We now study when exactly this happens. We thus study an advection-diffusion-decay system with a source on one side and a no-flux boundary on the left. The highest concentrations will then always be at the edges of the system, so we determine the concentrations at each side of the system. We're most interested in the influx $J_{in}$ and advection speed $v$, so we determine for $v$ at which $J_{in}$ the concentration on the left and right reaches the inflection point.
$$
\text{Left:  }J_{in} = - \frac{ 2al((1-\frac{1}{\sqrt{3}}c_0^+)+(1+\frac{1}{\sqrt{3}}c_0^-))}{\frac{vl}{D}-coth(\frac{L}{2l})}
$$

$$
\text{Right: } J_{in} =al((1-\frac{1}{\sqrt{3}}c_0^+)+(1+\frac{1}{\sqrt{3}}c_0^-))\left(e^{-\frac{L}{2l}(\frac{vl}{D}-1)}-e^{-\frac{L}{2l}(\frac{vl}{D}+1)}\right)
$$



Where $l$ is some lengthscale $l=D/\sqrt{4aD+v^2}$. We plot these two curves in the figure below:

![Blue line: Minimum J left side. Orange line: minimum J right side.](/Users/gert-janboth/Library/Application Support/typora-user-images/image-20181112113459099.png)


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





![image-20181112121152157](/Users/gert-janboth/Library/Application Support/typora-user-images/image-20181112121152157.png)

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

## Numerics

We numerically solve equations xxx for the interface speed to obtain a phase diagram:![image-20181112150413329](/Users/gert-janboth/Library/Application Support/typora-user-images/image-20181112150413329.png)

We note that this pretty much matches our analytical work, save for the two-droplet line. The reason for this is that we've calculated where both droplets appear, which is not always true. We can also have a second droplet appear, while the first one is already there. Thus the speed $v$ we have found is actually the $v$ of the crossing, but analytically we're not gonna do much better...

### Taking into account concentration

Although we have the droplet stability program, at some speeds and influxes the concentration inside the droplet becomes too low or outside too high. We plot this in the figure below. Everything to the right and above the dashed lines is unstable.

![image-20181112152459201](/Users/gert-janboth/Library/Application Support/typora-user-images/image-20181112152459201.png)

The solid lines correspond to the interfaces from the phase diagram, while the dashed lines are the lines at which the concentration becomes too high or too low. We see that the single droplets are always stable in their domain, but not the two droplet model. Inside the blue dashes curve, the concentration in the left droplet drops below the inflection point and the droplet thus becomes 'free'. As we've seen, the free droplet will move to the right untill the other side of the system, so inside the blue dotted curve only the droplet on the right is stable. 

Unfortunately, I don't see a way to get analytically nice stuff out as the inflection point is 'just' a concentration for the advection diffusion model....