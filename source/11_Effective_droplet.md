# Effective droplet

Cahn-Hilliard is a beautiful theory, but not quite handy due to its non-linearity. In this chapter we show an effective droplet theory which is able to reproduce many results of the cahn-hilliard theory but in a more wieldy format. We discuss the following three sections:

* **Effective droplet -** Here we present the derivation of a standard effective droplet theory.
* **Expanding effective droplet-** We discuss the effects of adding advection and decay on the phase diagram.
* **Two-component model-** We show a two component model and several effects and behaviours of this. 

## Effective droplet 

Consider again the Cahn-Hilliard equation:

$$
\frac{\partial\phi}{\partial t} = m\nabla^2 f'(\phi) - k\nabla^4\phi
$$ 

where $f'(\phi)=\partial f/\partial \phi=\mu$ with $f$ the free energy density and $k$ is a energy-like term and $m$ a mobility term. The first term is basically the bulk energy while the second term penalizes interfaces. If we assume our interface is very thin (i.e.flat), the interface term is much smaller than the bulk term and be neglected. We also consider a double well free energy density:

$$
f(c) = \frac{b}{2\Delta c}(c-c_0^+)^2(c-c_0^-)^2
$$

which gives a chemical potential $\mu$ as:

$$
\mu = \frac{b}{\Delta c^2}(c-c_0^+)(c-c_0^-)(2c-c_0^--c_0^+)
$$

Putting this back into equation gives back a diffusion equation:

$$
\partial_t c = D \nabla^2 c
$$

with $D=$ and we've changed $\phi \to c$. Working with this equation is a lot easier than the full cahn-hilliard. The cahn-hilliard equation forms domains as seen in figure and this equation doesn't. We thus need to manually ensure domain formation. Assuming there is a droplet, we need the right boundary conditions to solve the system.

### Boundary conditions

To calculate the boundary conditions, consider a two phase system desribed by a free energy density $f(\phi)$ with two minima $\phi_1$ and $\phi_2$. The system phase separates into two phases, so that the total free energy of the system is:

$$
F = V_1 f(\phi_1) + V_2 f(\phi_2)
$$

We also have incompressibility ($V_1+V_2=V$) and conservation of particles ($V_1\phi_1+V_2\phi_2=V\phi$). This leaves us with two independent variables. In equilibrium, the free energy $F$ is minimized and we minimize it w.r.t to $\phi_1$ and $V_1$. This gives us to conditions:

$$
f'(\phi_1) = f'(\phi_2) = 0
$$

$$
0 = f(\phi_1) + f(\phi_2) + (\phi_2-\phi_1)f'(\phi_2)
$$

The first equation states that across the interface the two chemical potential $\mu(\phi)=f'(\phi)$ must be equal and the second one states that the osmotic pressure should be similar. One obvious solution is $\phi_1=\phi_2$; a completely mixed state. A solution however also exists for a free energy with two minima where the solution is the two minima; this can be found by Maxwells tangent construction.

If we assume local that our system is locally (around the interface) at thermodynamic equilibrium, we can apply this solution as boundary conditions. Concretely,

$$
c(R) = 
\begin{cases}
    c_0^-,& R \text{ from above}\\
    c_0^+,& R \text{ from below}
\end{cases}
$$

Now that we have derived the boundary conditions, we can finish the effective droplet model.

### Fluxes and movement of interfaces

Using the boundary conditions derived in the previous section, we have the concentration profile inside and outside the droplet. The idea of effective droplet theory is to write the interface speed $v$ in terms of fluxes accross the interface. Since we've calculated the concentration, we can calculate the flux as:

$$
J = -D\frac{\partial c}{\partial x}
$$
 
in the case diffusion (Fick's law). Inside the droplet we can thus define a flux $J_{in}$ and outside the droplet a flux $J_{out}$. As we're dealing with active droplets, the flux $J_{in}$ will typically be inwards, i.e. away from the interface. The flux outside the droplet will also be inwards when stuff is typically moving into the droplet; both fluxes are thus negative. Now its visible were dealing with an *active* system: the fluxes will never become $0$, in other words we'll never reach equilibrium, but we can reach a stable state when $J_{in}=J_{out}$. If this is not the case, the interface will move. We can derive an interface speed $v$ in terms of the fluxes. Consider figure . If we wish to move the interface a distance $\Delta x$, we need a net gain of $\Delta x \delta c$. Thus, in a time $\Delta t$, we need:

$$
\Delta x \Delta c = (J_{in}-J_{out})\Delta t
$$

which can be rewritten as:

$$
\frac{\Delta x}{\Delta t} = v = \frac{J_{in}-J_{out}}{\Delta c}
$$

Note that $in$ and $out$ here refer to at which position the flux is calculated (inside or outside the droplet) and not to the effect of the flux. In our system, $J_{in}$ will always be negative but $J_{out}$ can be both, depending on the parameters.

![](source/figures/pdf/interface.pdf)

We've derived an expression for the interface velocity in terms of the fluxes. When we have a free droplet in an environment, we have two interfaces. Thus we can define a radius $R$ which grows or decays but if the interfaces move differrently due a difference in flux, the center of mass of the droplet $x_0$ will move: an active droplet can move on its own. Consider two interfaces $v_l$ and $v_r$, where the velocity $v_l$ is the interface on the left and $v_r$ the interface on the right. If we have a droplet at $x_0$ with radius $R$ and the interfaces move with a speed $v_l$ and $v_r$, in a time $dt$ they're at:

$$
x_0-R+v_ldt=x_0+dx-(R+dR)
$$
$$
x_0+R+v_rdt=x_0+dx+(R+dR)
$$

Solving this for $dx$ and $dR$ gives:

$$
\frac{dR}{dt}=\frac{1}{2}(v_r-v_l)
$$
$$
\frac{dx_0}{dt}=\frac{1}{2}(v_l+v_r)
$$

which proves that if the velocity of the interface on the left is not similar to the one on the right, the droplet will move. In terms of the fluxes, this means that the flux on one side is bigger than the other. Since the flux is dependent on the differences in concentration, this means that * a droplet in a gradient concentration moves up the gradient on its own*. This goes for any dimension, but its most easily seen in 1D: The interface on the side with the higher concentration outside experiences a larger influx, thus growing faster than the other side than the other interface. The droplet thus moves by growing on one side and decaying on the other. Writing in the frame of the droplet, we can finally write the growth speed and movement of the droplet in terms of the fluxes:

$$
\frac{dR}{dt}=\frac{1}{2\Delta c}\left[(J_{in}^{x=R}-J_{in}^{x=-R})+(J_{out}^{x=-R}-J_{out}^{x=R})\right] 
$$

$$
\frac{dx_0}{dt}=\frac{1}{2\Delta c}\left[(J_{in}^{x=-R}+J_{in}^{x=R})-(J_{out}^{x=-R}+J_{out}^{x=R})\right]
$$

The expressions above all describe the droplet in terms of time-derivatives, but we're interested in stable configurations. We thus look for solutions of equations with $dR/dt=0$, $dx/dt=0$. Where both   are zero, we have a droplet with a stable radius and position. 

## Expanding effective droplet: advection and decay

We use and modify the effective droplet model as a toy model for the behaviour of the Golgi in the cytoplasm. More precisely, the Golgi apparatus in mammalians is a ribbon, consisting of multiple golgi stacks (identical) together. We model a stack as an active droplet in a concentration gradient. Our model is shown in figure . We consider a 1D box of length $L$ with an influx at $x=0$ of $J_{in}$ and a zero flux boundary at $x=L$. Inside the system is a droplet of radius $R$ at position $x_0$. Transport in the system is described by a advection-diffusion-decay equation with a diffusion constant $D$, advection speed $v$ and decay constant $a$ outside and $k$ inside the droplet. The phase separation is governed by a free energy density with two minima at $c_0^-$ (dilute phase) and $c_0^+$ (dense phase).
We thus end up with the following set of equations and boundary conditions in a quasi steady state approach:

$$
D\partial_x^2 c(x) - v\partial_xc(x)-kc(x)=0
$${#eq:cinside}

$$
D\partial_x^2 c(x) - v\partial_xc(x)-ac(x)=0
$${#eq:coutside}

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



## Two-component model


