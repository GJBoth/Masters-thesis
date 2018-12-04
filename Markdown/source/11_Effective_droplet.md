# Results model

The previous chapter introduced phase separation and our model for the Golgi as a phase-separated droplet. In this chapter we study the behaviour of our model. In the first section, we analytically solve the model for a free droplet, i.e. a droplet free to move throughout the system. Using these expressions, we investigate the effect of advection on an active droplet and study the steady states of our model. Considering the biology, the diffusion constant $D$ and the decay rates $k$ and $a$ will most likely be system parameters and thus fixed. On the other hand, the advection speed $v$ encompasses the active transport across the microtubules and could easily vary, depending on the amount of molecular motors available and the rate at which they use ATP; the influx $J_{in}$ is dependent on the activity of the ER and would probably vary too. We are thus interested in creating a phase diagram with the stable radius and position as a function of$J_{in}$ and $v$. 

The Golgi stack is either located at the ribbon or at the ERES. In the second section we investigate this using a droplet stuck to the edge of the system. Taking a broader view, we study when phase separation takes place and if an effective droplet exists when phase separation should take place. We also validate the effective droplet model by checking mass conservation and this section with a numerical investigation. The chapter ends with a short section discussing our conclusions and possible biological connections. 

## Effective droplet

In this section we derive analytical expressions for the fluxes across the interface of the droplet. We present the most general case, including advection, decay and maturation, and derive simplified expressions later. Both the dense and dilute phase are described by an advection-diffusion-decay equation, which has a general solution given by
$$
c(x) = C_1e^{-\frac{x}{l^-}}+C_2e^{\frac{x}{l^+}}.
$$ {#eq:cgeneral}

We have defined a lengthscale $l^\pm$ as

$$
l^\pm= \frac{2D}{\sqrt{4kD+v^2}\pm v },
$$ {#eq:lengthscale}

where the maturation rate $k$ should be replaced by the decay rate $a$ in the dilute phase. Note it is a combination of a  lengthscale set by the diffusion $l_D=\sqrt{D/k}$ and a lengthscale set by the advection $l_v=2D/v$: 
$$
\frac{1}{l^{\pm}} = \sqrt{\frac{k}{D}+\left(\frac{v}{2D}\right)^2}\pm\frac{v}{2D}=\sqrt{\frac{1}{l_D^2}+\frac{1}{l_v^2}}\pm\frac{1}{l_{v}}.
$$
We have defined symmetric boundary conditions for the droplet, $c(R)=c(-R)=c_0^+$. Solving equation @eq:cgeneral with these boundary conditions will lead to a convex concentration profile. We can thus associate $l^-$ with $x<0$, the left side of the droplet, and $l^+$ with $x>0$, the right side. In a system without advection we have $l^+=l^-=l_D$ and the concentration profile will thus be symmetric around $c(0)$. If $v>0$ however, we have $l^- >l^+$ and the droplet is no longer symmetric around $c(0)$; rather, the position of the minimum concentration moves right, while the minimum concentration itself increases. This is shown in figure @fig:concprofile, where we have plotted a concentration profile for $v=0$ in blue and $v>0$ in orange. 

![Concentration profiles inside an active droplet for v=0 (blue) and v>0 (orange). Note that the minimum concentration increases and that its location moves right.](source/figures/pdf/concprofile.pdf){#fig:concprofile}

For a diffusive-advective flow, the flux is determined by $J(x) = -D\partial_xc(x)+vc(x)$ and applying this to the droplet concentration yields the fluxes. The fluxes itself are not particularly insightful, but considering equations @eq:radius and @eq:position, we can define a *maturation flux* $J_{mat} = J_{in}^{x=R}-J_{in}^{x=-R}$ and a *positional flux* $J_{pos} = J_{in}^{x=R}+J_{in}^{x=-R}$, so that
$$
\frac{dR}{dt}=\frac{1}{2\Delta c}\left[J_{mat}+(J_{out}^{x=-R}-J_{out}^{x=R})\right]
$$ {#eq:drdtalt}

$$
\frac{dx_0}{dt}=\frac{1}{2\Delta c}\left[J_{pos}-(J_{out}^{x=-R}+J_{out}^{x=R})\right]
$$ {#eq:dxdtalt}

The maturation flux $J_{mat}$ is the flux at the interface due to the maturation in the droplet. Note it is solely determined by the diffusive flux, as
$$
J_{in}^{x=R}-J_{in}^{x=-R} = (-D\partial_xc(x)+vc(x))|_{x=R}-(-D\partial_xc(x)+vc(x))|_{x=-R}=D(\partial_xc(x)|_{x=-R}-\partial_xc(x)|_{x=R}).
$$
The maturation flux does have a dependence on the advection through its effect on the concentration profile. Since $J_{rad}$ is solely determined by the diffusive flux and the solutions of @eq:cgeneral are convex, the fluxes at the two interfaces have opposite signs. More so, $J_{in}^{x=R}<0$ and $J_{in}^{x=-R}>0$, so that $J_{mat}<0$. This means that the droplet will shrink unless sustained by some influx from outside the droplet, as can be seen from equation @eq:drdtalt. If the maturation flux is exactly balanced by this influx, the droplet radius remains stable. Whereas passive droplets will grow to an infinite radius, active droplets remain at a finite radius due to their suppresion of the Ostwald Ripening[@zwicker_suppression_2015]. For our particular choice of boundary conditions, we have derived for $J_{mat}$: 
$$
J_{mat} = \frac{-2c_0^+D}{l}\frac{\sinh\frac{R}{l^-}\sinh\frac{R}{l^+}}{\sinh\frac{R}{l}},
$$ {#eq:Jmat}
where we have defined an 'effective lengthscale' $l$ as 
$$
l = \frac{l^+l^-}{l^++l^-}.
$$
For a small, non-advected droplet, $l^-=l^+=l_D$ , $l=l_D/2$  and $R\ll l_D$ , we can approximate the maturation flux as
$$
J_{mat}=-2c_0^+kR.
$$ {#eq:Jmatapprox}
Effectively, we have approximated the concentration profile inside the droplet as $c(x)=c_0^+$, so that the flux lost due to decay with rate $-k$ for a droplet with size $2R$ indeed gives equation @eq:Jmatapprox. One would thus expect that the limit of $R\to \infty$ would yield an infinite flux but taking the limit of @eq:Jmat gives 
$$
\lim_{R\to\infty} = -2c_0^+\sqrt{kD},
$$
which does not yield the shocking result that $\infty = \sqrt{D/k}$, but that the flux saturates for $R>\sqrt{D/k}=l_D$. When $R\gg  l_D$, the concentration in the middle of the droplet drops to zero and since the maturation scales with the concentration, the flux saturates. In this regime, the effective droplet theory is not valid and hence we require that $R<l_D$. In the case of an advected droplet this is a more subtle point, as advection increases the minimum concentration inside the droplet (as can be seen in figure @fig:concprofile). We study this numerically in the next section. 

The positional flux $J_{pos}$ is the internal flux which leads to droplet movement. For our set of boundary conditions, we have derived
$$
J_{pos} = 2c_0^{in}D\left[\frac{Pe_-}{l_-}\frac{\sinh\frac{R}{l_+}\cosh\frac{R}{l_-}}{\sinh\frac{R}{l}}-\frac{Pe_+}{l_+}\frac{\sinh\frac{R}{l_-}\cosh\frac{R}{l_+}}{\sinh\frac{R}{l}}\right],
$$ {#eq:Jpos}
where we have defined the Peclet-like numbers
$$
Pe^\pm = 1 \mp \frac{vl^\pm}{D}
$$
In a passive droplet $c(x)=c_0^+$ so that the positional flux equals $2c_0^+v$, but in an active droplet we need to take into account the internal diffusion. Recall that the diffusive fluxes point inwards and hence are aligned antiparallely, whereas the advective fluxes are aligned parallely. The net flux at the two interfaces is thus different, leading to equation @eq:Jpos instead of $2c_0^+v$. 

We now turn to the fluxes on the outside of the droplet. A droplet of radius $R$ at position $x_0$ has its interfaces at $x_0 \pm R$ and defining $x_1=x_0-R$ and $x_2=x_0=R$ we have derived the following expressions for the flux at the interfaces
$$
J_{out}^{x=-R} = J_{in}\frac{(1+\frac{l_-}{l_+})e^{\frac{-x_1}{l_-}}}{Pe_-+Pe_+\frac{l^-}{l_+}e^{\frac{-x_1}{l}}}
+\frac{c_0^{out}D}{l_-}\frac{Pe_+(1-e^{\frac{-x_1}{l}})}{\frac{l^+}{l^-}+\frac{Pe_+}{Pe_-}e^{\frac{-x_1}{l}}}
$$ {#eq:leftflux}

$$
J_{out}^{x=R} = -c_0^{out}D\frac{Pe_-Pe_+(1-e^{\frac{-x_2+L}{l}})}{l_+Pe_-+e^{\frac{-x_2+L}{l}}l_-Pe_+}
$$ {#eq:rightflux}

Although not particularly enlightening, we note the similarity between the second term of @eq:leftflux and @eq:rightflux. The flux on the left of the droplet has anothe term in $J_{in}$, accounting for the source we have placed at the left boundary. In the next section we study the phase diagram equations @eq:Jmat, @eq:Jpos, @eq:leftflux and @eq:rightflux give rise to. 

## Free droplet

We now wish to study the phase diagrams of free droplets and their steady states. More specifically, we wish to investigate when droplets have a stable state (i.e. $dR/dt=dx_0/dt=0$) at some position $x^*$ in the system. The first configuration we study ignores the decay outside the droplet, i.e. $a=0$. In this case, the outside fluxes become constant and independent of the location of the droplet, as the only way for the cargo to 'exit' the system is to mature in the droplet:
$$
J_{out}^{x=-R} = J_{in}
$$

$$
J_{out}^{x=R} =0
$$

The flux on the right interface of the droplet is zero as there is no source nor decay and in our quasi-steady state approximation the flux then must become zero. The equations for the flux in the droplet remain unchanged as they are independent of the transport parameters. Developing the internal droplet fluxes for $R\ll l^\pm$ gives:
$$
J_{rad}\approx -2 c_0^+kR
$$ {#eq:jrad}

$$
J_{pos}\approx2 c_0^+v 
$$ {#eq:posfluxapprox}

Putting these expressions in equations @eq:drdtalt and @eq:dxdtalt gives
$$
\frac{dR}{dt} \approx \frac{1}{2\Delta c}(J_{in}-2 c_0^+kR),
$$ {#eq:drdtapproxnodecay}

$$
\frac{dx_0}{dt} \approx \frac{1}{2\Delta c}(2 c_0^+v-J_{in}).
$$

The stable radius, $R_{stable} \approx J_{in}/2c_0^+k$ is thus independent of the velocity $v$ and the droplet will maintain its position if $v_{stable}\approx J_{in}/2c_0^+$ . This means that, save for $v_{stable}$, the droplet will always move either right or left and that the movement direction switches at the switching velocity $v_{stable}$. It is non-zero due to the self-movement of an active droplet; recall that an active droplet will move itself up a concentration gradient. The advection needs to compensate for this movement, giving rise a non-zero $v_{stable}$.

We now study this system numerically. As the fluxes on the outside of the droplet are independent of the velocity, we are in fact studying the effect of advection on an active droplet, irrespective of its environment. We plot the stable radius of the droplet in figure @fig:stableradnodecay and the corresponding minimum concentration in @fig:minconnodecay . We have used the following parameters: $D=1, k=0.1, c_0^+=0.9$. 

![The stable radius as a function of the velocity $v$ and influx $J_{in}$. The dashed line is the line $dx_0/dt=0$.](source/figures/pdf/Stable_nodecay.pdf){#fig:stableradnodecay}

![The minimum concentration in a stable droplet as a function of the velocity $v$ and influx $J_{in}$. In areas with a low concentration the effective droplet model is not valid.](source/figures/pdf/minimumconcentration.pdf){#fig:minconnodecay}

Note that the stable radius of small droplets is independent of the velocity, but that we do observe some dependence for bigger droplets. However, concurrently with the size increase is the minimum concentration decrease, as shown in figure @fig:minnodecay . For very low $v$ and high $J_{in}$, the concentration even drops to 0.4 - a concentration corresponding to the dilute well of the free energy and thus clearly unphysical. Increasing $v$ raises the minimum concentration, while also slightly decreasing the radius of the droplet. To understand this decrease in radius, consider again figure @fig:concprofile. Calculating some average concentration $\bar{c}=\frac{1}{V}\int c(x)dV$, it is clearly visible that this is higher for the advected droplet. Estimating the maturation flux as $J_{mat}\propto -2Rk\bar{c}$, an advected droplet thus has a higher maturation flux than a non-advected droplet. The maturation flux needs to be balanced by the influx $J_{in}$ for a stable droplet so that
$$
R = \frac{J_{in}}{2k\bar{c}}.
$$ {#eq:jmathandwavy}
Since both $J_{in}$ and $k$ are fixed, $R$ must decrease and thus advection compacts active droplets. The superimposed dashed line in figure @fig:stableradnodecay corresponds to $dx_0/dt=0$ and thus represents the stable droplets for which $dR/dt=dx_0/dt=0$. Observe that for small $v$ it indeed shows a linear dependence between $J_{in}$ and $v$ as predicted, but that for higher $v$ we do observe some non-linearity. Due to the low concentrations those areas are unphysical however. We now investigate the stability of this line by perturbing @eq:drdtapproxnodecay around $R_{stable}$. We obtain
$$
\frac{d\delta r}{dt}=-2c_0^+k\delta r.
$$
Since both $k>0$ and $c_0^+>0$, any fluctutations cancel; the steady state is stable. The system we have studied so far is completely independent of the position in the system as the outside fluxes are constant. By including decay outside the droplet, i.e. $a\neq 0$, the outside fluxes will become dependent on the position of the droplet. 

 We solve equations @eq:Jmat, @eq:Jpos, @eq:leftflux and @eq:rightflux numerically by finding the $x_0^*$ and $R^{*}$ for which  $dx_0/dt=dR/dt=0$ inside our system, i.e. $0<x_0^*<L$, $0<R^*<L/2$. Using $k=0.3, a=0.1, D=1 ,c_0^-=0.1,c_0^+=0.9, L=5$ , we plot the steady state radii and positions in figures @fig:rstabledecay and @fig:xstabledecay.

![Steady state radius as a function of $v$ and $J_{in}$ made using $k=0.3, a=0.1, D=1 ,c_0^-=0.1,c_0^+=0.9, L=5$. Blue areas correspond to no droplet.](source/figures/pdf/Rstable.pdf){#fig:rstabledecay}

![Steady state position as a function of $v$ and $J_{in}$ made using $k=0.3, a=0.1, D=1 ,c_0^-=0.1,c_0^+=0.9, L=5$. Blue areas correspond to no droplet.](source/figures/pdf/Xstable.pdf){#fig:xstabledecay}

In areas which are blue in both plots no droplet exists in the system. We identify two causes, each connected to a corresponding 'cutoff line' in the stable position plot. First, by adding decay, we have added another 'exit' for the contents of the system. Thus, for low $J_{in}$ and $v$ a droplet won't exist. This explains the lower left cutoff and is supported by the fact that this edge corresponds to the line $R=0$. The other edge has $x_0=0$, meaning that the droplet moved past the edge of the system. In the radius plot we also observe a third cutoff in the upper left corner. This corresponds to the $x_0=5$ edge and represents a droplet at the far end of the system. To satisfy the no-flux boundary condition, the droplets' radius must go to zero. Hence this area is shaded blue in the radius plot, but not in the position plot. 

Note that advection increases the droplet radius, contrary to the no-decay case. Recall that advection decreased the radius because the outside fluxes were constant. Having added decay to the system, this not the case anymore. For a droplet at a fixed point $x_0$, increasing $v$  increases the outside flux as less is lost to decay. Although increasing $v$ also increases the maturation flux inside the droplet, the increase of the outside flux is dominant and hence the droplet radius increases with increasing $v$. Also observe in figure @fig:xstabledecay that increasing $v$ decreases $x_0$. Increasing the flow thus leads to the droplet moving further up that flow, a very counterintuitive situation.  To see why this happens, consider a droplet of fixed radius $R$ at position $x_0$. Remembering equation @eq:jmathandwavy, increasing $v$ increases $\bar{c}$, which can only be compensated by a higher influx $J_{in}$. In a system with decay and advection, the influx is higher upstream and hence the droplet moves upstream. 

We study the stability of these steady states by plotting $dx_0/dt$ and $dR/dt$ at $J_{in} = 0.18$ and $v=0.1$ in figures @fig:drdtdecay and @fig:dxdtdecay. 

![$dR/dt$ as a function of $x_0$ and $R$. The solid black line denotes the $dR/dt=0$ and the dashed line $dx_0/dt=0$. The red line is the line $x_0=R$.](source/figures/pdf/dRdt.pdf){#fig:drdtdecay}

![$dx_0/dt$ as a function of $x_0$ and $R$. The solid black line denotes the $dR/dt=0$ and the dashed line $dx_0/dt=0$. The red line is the line $x_0=R$.](source/figures/pdf/dXdt.pdf){#fig:dxdtdecay}

The solid black lines denote $dR/dt=0$ and the dashed lines $dx_0/dt=0$. The red line is the line $x_0=R$; a steady state needs to be above this line, as below this line $x_0-R<0$, meaning that the droplets' left interface is outside of the system. We observe that the line $dR/dt=0$ is stable, but as $dx_0/dt=0$ is not, the steady state is unstable. This plot is typical for all parameters, so we conclude that all steady states are unstable: the droplet either moves left or right until it hits the edges of the system. The free droplet model does not properly describe this situation, as it always has two interfaces. In reality, when the droplet hits the edges of the system one of the two interfaces disappears and the droplet becomes like a wetting layer. We investigate this in the next section.

## Droplet stuck to walls

In the previous section we showed that a droplet will always move left or right until it hits the edges of the system, but that this situation is not properly described by our free droplet model. In this section we present a slighly modified model to account for this situation. Once the droplets' interface hits the edge of the system, it ceases to be an interface between a dense and a dilute phase: rather, the boundary condition of the droplet must become the boundary condition of the system. For a droplet on the left of the system we thus have the boundary conditions $c(R)=c_0^+$ and $J(0)=J_{in}$, while for the droplet on the left we have $c(L-R)=c_0^+$ and $J(L)=0$. We present the behaviour of this modified model in this section, taking a slightly wider view than before. Instead of assuming the existence of a droplet, we first investigate when droplets phase separate at the edges of the system. We will then prove the existence of a stable effective droplet when such a phase separation should take place and that mass is conserved. Finally, we present a phase diagram and discuss the biological connection and implications.  

### Occurence of phase separation

Consider again the double well free energy with minima at $c_0^-$ and $c_0^+$:
$$
f(c) = \frac{b}{2\Delta c^2}(c-c_0^-)^2(c-c_0^+)^2
$$ {#eq:energydensity}
This free energy describes a system phase separating into a dense area with concentration $c_0^+$ and a dilute area of concentration $c_0^-$. Our system is open

We thus ask at which concentration the dilute and dense phases becomes unstable. For the thermodynamics we know that stability requires  $d^2f/dc^2>0$. In areas where $d^2f/dc^2<0$, fluctuations keep growing and the system will phase separate. For the free energy density given by @eq:energydensity, the area between the two inflection points $c=(c_0^++c_0^-)/2\pm\sqrt{3}(c_0^+-c_0^-)$ is unstable. Thus, if the concentration in the dense phase becomes lower than upper inflection point, a dilute phase will form. On the other hand, if the dilute phase reaches the lower inflection point, a droplet will form. Note that we have neglected the gradient term. We thus have a criterium for when a droplet is formed. 

To study when this minimum concentration is reached, we consider our system without a droplet which is described by a single advection-diffusion-decay equation with boundary conditions $J(0)=J_{in}$ and $J(L)=0$. Resulting concentration profiles will have the highest concentrations at the edges and we thus calculate at which $J_{in}$ the concentration reaches the lower inflection point. We obtain:
$$
\text{Left:  }J_{in} = - \frac{ 2al((1-\frac{1}{\sqrt{3}}c_0^+)+(1+\frac{1}{\sqrt{3}}c_0^-))}{\frac{vl}{D}-coth(\frac{L}{2l})}
$$ {#eq:jminleft}

$$
\text{Right: } J_{in} =al((1-\frac{1}{\sqrt{3}}c_0^+)+(1+\frac{1}{\sqrt{3}}c_0^-))\left(e^{-\frac{L}{2l}(\frac{vl}{D}-1)}-e^{-\frac{L}{2l}(\frac{vl}{D}+1)}\right),
$$ {#eq:jminright}

where $l$ is a lengthscale defined as $l=D/\sqrt{4aD+v^2}$. Equations @eq:jminleft and @eq:jminright represent the minimum influx required to form a droplet on the left or right and we plot these two curves in figure @fig:minJconc

![Blue line: Minimum J left side. Orange line: minimum J right side.](source/figures/pdf/Jmin.pdf){#fig:minJconc}

The blue line shows the minimum $J_{in}$ for the left side of the system, while the orange line shows the minimum for the right. We can recognize four areas in figure @fig:minJconc. Below both the blue and the orange line, the concentration never reaches the lower inflection point and thus no droplets will be formed. In the area below the orange line but above the blue line, only a droplet on the left is formed, while exactly the reverse happens on the right side of the plot: only a droplet on the right is formed. Finally, we note that in the upper area both droplets can be formed. In this regime, $J_{in}$ and $v$ are high enough for the concentration to reach the inflection point at both sides of the system. 

This approach only determines when a droplet is formed and does not yield any information about the size and stability of such newly-formed droplets. In fact, we require the existence of a stable droplet with non-zero radius in areas where figure @fig:minJconc predicts a droplet is formed. We investigate this in the next section 

 Above both lines the concentration is high enough on both sides. This plot onyl tells us when phase-separation should happen; it doesn't tell if it does. We investigate this in the next section by comparing the phase diagram of figure @fig:minJconc with the phase diagram of the effective droplet model.

### Effective droplet

We construct the effective droplet phase diagram for this system by determining for which $J^{*}_{in}$ a stable droplet (dR/dt=0) with radius $R=0$ exists. For an influx higher than $J_{in}^*$, a droplet with $R>0$ then exists, so that $J_{in}^*$ is the minimum influx required for a droplet to exist.  For the left and right droplet, we find the following:
$$
\text{Left:  }J_{in} = - \frac{ 2a c_0^-l}{\frac{vl}{D}-coth(\frac{L}{2l})}
$$ {#eq:jminlefted}

$$
\text{Right: } J_{in} =ac_0^-l\left(e^{-\frac{L}{2l}(\frac{vl}{D}-1)}-e^{-\frac{L}{2l}(\frac{vl}{D}+1)}\right)
$$ {#eq:jminrighted}

Note that these equations have the same form as @eq:jminleft and @eq:jminright, save for some prefactor. Defining the minimum flux as defined by equations @eq:jminleft and @eq:jminright as $J^{AD}$ and the minimum flux as calculated by the effective droplet model in equations @eq:jminlefted and @eq:jminrighted we obtain the same ratio for both the left and right sides:
$$
\frac{J^{AD}}{J^{ED}} = \frac{(3-\sqrt{3})c_0^++(3+\sqrt{3})c_0^-}{6c_0^-}
$$
Note that $J^{AD}>J^{ED}$ if $c_0^+>c_0^-$. In other words, the minimum flux required for a stable droplet is smaller than the minimum flux required to form a droplet if the concentration in the dense phase is higher than the concentration in the dilute phase, which it is by definition. We thus see that a stable droplet with a non-zero radius is guaranteed to exist if phase separation should occur as determined by equations @eq:jminleft and @eq:jminright. A second criterium would be mass conservation: the mass in a separated system should be similar to the mass in a phase separated system.  Given any concentration profile (either above or below critical concentration) given by an advection-diffusion-decay equation, the mass in the system is:
$$
\int_0^L c(x)dx = \frac{J_{in}}{a}
$$
which makes sense as $J_{in}$ is what comes into the system and $a$ what goes out. Without loss of generality, we assume $J_{in}$ and $a$ are such the droplet appears on the left side of the system. The total mass inside such a system is:
$$
\int_0^{R^*}c_{in}(x)dx + \int_{R^*}^Lc_{out}(x)dx
$$
Where the stable droplet radius $R^*$ corresponds to $dR/dt|_{R=R^*}=0$. Assuming the droplet radius remains small, we can determine the stable droplet radius. For simplicity assuming that $k=a$, we obtain:
$$
\int_0^{R^*}c_{in}(x)dx + \int_{R^*}^Lc_{out}(x)dx=\frac{J_{in}}{a}
$$
We thus see that mass is conserved when phase separation occurs. 

The effective droplet phase diagram also predicts an area in which droplets on both the left and right are stable. We now investigate if both droplets can coexist, i.e. that the system has a droplet on the left and the right, using a two droplet model. Again solving the fluxes for $dR_1/dt=dR_2/dt=R_1=R_2=0$ yields a minimum influx $J_{in}$ 
$$
J_{in} = \frac{c_0^-D}{2l}\left(\frac{vl}{D}+\frac{(1+e^{\frac{L}{l}}-2e^{\frac{-L}{2l}(\frac{vl}{D}-1)})}{(1-e^{\frac{L}{l}})}\right)
$$
and if $l_D,l_v\gg L$ we also obtain a minimum advection velocity $v^*$:
$$
v^*=\frac{aL}{2}
$$ {#eq:minadv}
We plot the corresponding phase diagram in figure @fig:phasediagramapprox .

![Caption.](source/figures/pdf/phaseapprox.pdf){#fig:phasediagramapprox}

We observe six 'phases' and that all these cross at a single point. Note some sort of symmetry exists: considering the area above the diagonal of the plot and following it clockwise from the origin, we first observe no droplets, then a droplet on the left, followed by either a droplet on the left or right and finally the area where its possible for a single droplet on the left or right or two droplets to exist. Below the diagonal we observe an analogous trajectory, where instead of a single droplet on the left we now have a droplet on the right. Considering the flow problem we presented in the previous section this symmetry makes perfect sense: for low $v/J_{in}$ the concentration will be highest on the left hence favouring droplets being formed on the left. For high $v/J_{in}$ exactly the opposite happens and droplets on the right are favoured. All phases intersect at a single point. Expanding the crossing of the minimal fluxes for $l_D,l_v\gg L$ we obtain 
$$
v_{cross}=\frac{aL}{2}
$$
which is similar to equations @eq:minadv, meaning that the intersection at this point is a system property and not just a side-effect of our parameter choice. In figure @fig:phasediagramnumerical we plot the results of numerically solving the equations. 

![Caption.](source/figures/pdf/Numericalphase.pdf){#fig:phasediagramnumerical}

The red solid and dashed lines represent the minimum influx required for respectively a droplet on the left and right. The  black dashed line corresponds to $dR_{left}/dt=0$ in the two droplet model, while the dotted-dashed line is $dR_{right}/dt=0$. Since only the line this line is determined numerically, all the other lines exactly match what is plotted in figure @fig:phasediagramapprox. Contrary to this plot however, $dR_{right}/dt=0$ is not vertical. This is because @eq:minadv has been derived assuming that both the left and right droplet appear at the same time; in reality, one of the droplet can have a non-zero radius before a second droplet appears. Numerically we also find that all the phases are connected through some critical point. To see why this happens, consider the crossing of the two minima $J_{in}$. At this point, the concentration profile is such that the concentration on each side of the system is similar: $dR/dt=R=0$ on both sides and by changing $J_{in}$ or $v$ any of the phases can be reached. 

We now have several areas where multiple configurations are stable. Which one exactly depends on where the initial droplet is formed. Thus, the phase diagram depends on the initial dynamics. We have neglected the effect of the term penalizing the gradient and it could be that adding this term would yield a phase diagram with only a single stable state. This would require simulations however so for now the mystery remains. 

## Biological implications

We now link the behaviour of our model to biological observations. First off, our model predicts that the only stable position for the droplet is at the edges of the system. Biologically, stacks are either located at the ribbon or at the ERES, thus matching our model. Furthermore, this position is dependent on the microtubules: when the microtubules are depolymerized, the ribbon breaks up and the stacks colocalize with the ERES. Our free droplet model predicts a similar movement, with the switching happening at a finite advection velocity. Also note that our droplet size is dependent on the amount of trafficking through $J_{in}$. Observation have been made that the Golgi size is dependent on the amount of trafficking too. 

Active droplets propel themselves by imbalanced fluxes; it grows on one side while decaying on the other. In the cisternal maturation model, the Golgi grows on one side by vesicles forming a cis compartment, whereas the opposite happens on the trans side. Cisternal maturation could thus be the process by which the stack moves from its position in the ribbon to the ERES.

All taken together, the model we've presented is able to explain the position of the Golgi stack, why it is formed around the ERES and why it moves close to the eres once the microtubules are depolymerized. 

