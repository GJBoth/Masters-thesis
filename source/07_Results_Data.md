# Data analysis

In this chapter we apply the method developed in the previous chapter to experimental data obtained using the RUSH technique. Our first section introduces the RUSH technique and discusses our model for the intracellular transport. In the following section we discuss the experimental data, investigate the fluorescence curves of several areas of interest. and gain more insight into the data by studying its time derivative. We then present a linear least squares fit and show that this can lead to unphysical results, such as a negative diffusion coefficient. This problem is fixed by modifying the least-squares fit to constrain the coefficients. 

## Experimental data

The transport of vesicles from the ERES to the Golgi is both diffusive and directive and a technique known as RUSH (Retention Using Selective Hooks) has recently been developed [@boncompain_synchronization_2012] in the team of Frank Perez at Institut Curie to study this trafficking. RUSH allows precise timing of the release of proteins from the ER and can be used to follow the secretory pathway from the ER to the Golgi and even post-golgi using fluorescent live-cell imaging. Several other methods have been developed (@presley_er--golgi_1997, @mccaughey_er--golgi_2018), but lack the non-toxicity, timing and versatility of the RUSH technique. 

![Schematic overview of the RUSH system. Image taken from @boncompain_synchronization_2012](source/figures/png/RUSH.png){#fig:RUSH}

Figure @fig:RUSH shows the principle of the RUSH system. Inside the ER, a core streptavidin is fused to it using a hook protein. Another protein known as a streptavidin-binding-protein (SBP) binds to streptavidin, but connected to the SBP are also the protein to be transported ('reporter') and a fluorescent protein. Upon the addition of biotin, the SBP is released from the streptavidin as the biotin binds to it. The SBP-reporter-fluorescent complex then exits the ER and can be followed the entire secretory pathway with fluorescence microscopy. 

The RUSH technique can be used for many different proteins, but in this thesis we mainly focus on the $\alpha$-mannosidase-II, generally referred to as ManII. The ManII protein resides in the Golgi apparatus and thus upon reaching it will remain there. This means that the data we obtain will only contain transport *towards* the golgi, greatly simplifying the analysis as we won't have to post and pre-golgi traffic. Figure @fig:manII shows two frames in a typical RUSH experiment of ManII trafficking. The left panel shows an image obtained just after the addition of the biotion, so that most of the cargo is still retained in the ER. A later frame is shown on the right: we can observe the localization of fluorescence in the Golgi, while there's still fluorescence in the rest of the cells. 

![Two frames of the ManII transport images using the RUSH technique.](source/figures/pdf/frames.pdf){#fig:manII}

### Model

Vesicles exiting the ERES are transported towards the ER over the microtubules. This is a stochastic process with the proteins detaching from and (re-) attaching to the microtubules randomly, while the vesicles move diffusely once detached. Several models have been developed to describe such intracellular transport processes (@bressloff_stochastic_2013, @holcman_modeling_2007), many in the light of virus trafficking (@lagache_effective_2008, @dinh_model_2005, @brandenburg_virus_2007). In general, these models assume a two population model, with one population being cargo attached to a microtubule and another cargo freely diffusing in the cytoplasm. If one assumes that the timescale for attaching and detaching from the microtubules is much smaller than the transport timescale, the two populations can be assumed to be in equilibrium. In this assumption, known as a quasi-steady-state reduction, the two population model reduces to a Fokker-Planck equation. As the Fokker-Planck equation is functionally equivalent to an advection-diffusion equation, we hypothesize that we can model protein transport using an advection-diffusion equation:
$$
\partial_t c = D\nabla^2c-v\nabla c
$$ {#eq:adeq}
where $c$ is the concentration of the cargo, $D$ a diffusion coefficient and $v$ an advection velocity. Equation @eq:adeq is thus the model we fit our data to. Note that the fluorescence images obtained from the RUSH experiment return an intensity $I$ and not a concentration $c$, and hence we make the assumption $c \propto I$. 

## Initial analysis

We first study the evolution of the fluorescence in two ways, plotting both the mean fluorescence for each frame and the mean fluorescence in the golgi region. To get rid of the background in our statistics, we normalize the fluorescence between before computing the mean. The left panel of frame #fig:fluorescence shows the average fluorescence of each frame and shows a significant drop of almost $30\%$ between the initial and final frame. We observe a strong initial drop and a slower decay after roughly frame 100, which can probably be attributed to photobleaching. The transition between the two decays roughly matches the saturation of the fluorescence in the Golgi (see the right panel), casting strong doubts on our assumption that $c\propto I$. Compensating for this is possible (see @hirschberg_kinetic_1998), but requires significant effort on the experimentalists' part and we thus leave this for future work

.![left panel: normalized fluorescence. Right panel: fluorescence of three golgis.](source/figures/pdf/general_fluorescence.pdf){#fig:fluorescence}

In the right panel we show the fluorescence in the Golgi ROI for each of the three cells. Specifically, we plot the mean intensity in each ROI, normalized on the maximum intensity and compensated for the loss of fluorescence as shown in the left panel. Interestingly, we observe that all three curves roughly follow a similar pattern. Although one of the cells (blue line) seems to have some sort of delay, the fluorescence seems to increase in a linear way up to frame 100, when the fluorescence saturates. The purple cell shows a significant drop at frame 200, but since the ManII protein remains in the Golgi, this is not caused by any type of intracellular transport and thus not of interest to us. The linear increase and common pattern suggests that the transport properties are not concentration dependent at these concentrations.

To perform our fit in the next section, we have also determined the time derivative of the dataset, $\partial_tI$. We plot this for four different frames in figure @fig:timederiv .

![The determined time derivative four different frames of the ManII RUSH experiments.](source/figures/pdf/time_deriv.pdf){#fig:timederiv}

Areas where the derivative is positive (thus were the concentration increases) are coloured red, while areas where the concentration decreases are coloured blue. As expected, the Golgi shows up in each cell as a bright red object. Note however that we also observe red areas towards the edges of the cell. As the concentration close to the Golgi decreases, the red area moves outwards and slowly takes over the blue area. This could be caused by ERES acting as a in that area, but given that ERES are located throughout the cell it seems more likely such a pattern would be caused by diffusion. 

## Analysis of LS-fit

In this section we analyse results of the least squares fit. We've used a 7x7 window in the spatial domain to perform the sliding window operation, fitting each frame of the movie independently. We analyse the diffusion, advection and the error of our fit.

![Diffusion]()

![Advection]()

![Pixel in time]()

![Error]()

### Diffusion

### Advection

### Error?





## 

## 


