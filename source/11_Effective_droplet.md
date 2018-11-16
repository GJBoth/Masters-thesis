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

We now study this system numerically. As the fluxes on the outside of the droplet are independent of the velocity, we are in fact studying the effect of advection on an active droplet, irrespective of its environment. We plot the stable radius of the droplet in figure @fig:stableradnodecay and the corresponding minimum concentration in @fig:minconnodecay. We have used the following parameters: $D=1, k=0.1, c_0^+=0.9$. 

![The stable radius as a function of the velocity $v$ and influx $J_{in}$. The dashed line is the line $dx_0/dt=0$.](source/figures/pdf/Stable_nodecay.pdf){#fig:stableradnodecay}

![The minimum concentration in a stable droplet as a function of the velocity $v$ and influx $J_{in}$. In areas with a low concentration the effective droplet model is not valid.](source/figures/pdf/minimumconcentration.pdf){#fig:minconnodecay}

Note that the stable radius of small droplets is independent of the velocity, but that we do observe some dependence for bigger droplets. However, concurrently with the size increase is the minimum concentration decrease, as shown in figure @fig:minnodecay. For very low $v$ and high $J_{in}$, the concentration even drops to 0.4 - a concentration corresponding to the dilute well of the free energy and thus clearly unphysical. Increasing $v$ raises the minimum concentration, while also slightly decreasing the radius of the droplet. To understand this decrease in radius, consider again figure @fig:concprofile. Calculating some average concentration $\bar{c}=\frac{1}{V}\int c(x)dV$, it is clearly visible that this is higher for the advected droplet. Estimating the maturation flux as $J_{mat}\propto -2Rk\bar{c}$, an advected droplet thus has a higher maturation flux than a non-advected droplet. The maturation flux needs to be balanced by the influx $J_{in}$ for a stable droplet so that
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

The solid black lines denote the $dR/dt=0$ and the dashed lines $dx_0/dt=0$. The red line is the line $x_0=R$. A steady state needs to be above this line, as below this line $x_0-R<0$, meaning that the droplets' left interface is outside of the system. We observe that the line $dR/dt=0$ is stable, but as $dx_0/dt=0$ is not, the steady state is unstable. As this plot is typical for all parameters, we conclude that all steady states are unstable: the droplet either moves left or right until it hits the edges of the system. The free droplet model does not properly describe this situation, as it always has two interfaces. In reality, when the droplet hits the edges of the system one of the two interfaces disappears and the droplet becomes like a wetting layer. We investigate this in the next section.

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

We've build a model describing the Golgi as a phase separated droplet, linking the transport parameters such as $v$ , $D$ and $a$ to the Golgi size and its function through the maturation flux. We've also shown a phase diagram and have studied active droplets.

One counterintuitive result is that the unstable equilibrium moves closer to the source with increasing $v$. We've checked the effective droplet model and found that mass is conserved and an effective droplet exists when phase separation should happen. We've further shown a phase diagram with four different areas and shown that they always intersect at the same point. Why? We dont know...

We now make some very speculative biological connection to the observation of Golgi properties. A strong marker is that once the microtubules are depolymerized, the stacks move away from the perinuclear area and colocate with the ERES. This is what we see when we turn of the advection, the droplet moves up the gradient to the source. A similar thing is seen with biogenesis, the stacks are made around the ERES but need microtubules to be transported to the center. Our model shows this behaviour. Even more crazy, we've seen that the droplet moves by growing in the front and decaying in the back. This is similar to how the maternal cisturation model for the golgi works. Thus, the cisternal maturation could be the mechanism by which the golgi moves.

More in general, we've applied a theory normally used for membrane organelles to membraneless organlles. Nice. 

