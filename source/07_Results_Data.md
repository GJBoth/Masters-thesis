# Data analysis

In the previous chapter we developed a general system to fit our advection-diffusion model to the data obtained from the RUSH experiments. In this chapter we apply said system to the MANII movies. MANII has been chosen as after arriving at the Golgi, it remains there. Dealing with only one transport direction makes everything a lot easier for us. This chapter consists of five sections:

* **Section 1** presents a general analysis of the fluorescence data of the movies
* In **section 2** we discuss the time derivative of the fluorescence, $\partial_t I$, as this also has some interesting points.
* **Section 3** contains our analysis of the least squares fit.
* **Section 4** is similar to section 3, only now we analyse a constrained fit with $D>0$.
* **Section 5** summarizes our findings and presents possible improvements for the system.

## Rush

A technique known as RUSH (Retention Using Selective Hooks) has recently (2012) been developed in the team of Frank Perez at Institut Curie to study secretory traffic. It allows for the precise timing of the release of proteins from the endoplasmatic reticulum and can be used to follow the secretory pathway from the ER to the Golgi and even post-golgi using fluorescent live-cell imaging. 

![RUSH system]()

Figure **ref** shows the principle of the RUSH system. Inside a donor compartment, a hook protein in fused to a core streptavidin. A streptavidin-binding-protein (SBP) binds reversibly to the streptavidin and has both the protein to be followed attached to it (the reporter) and a fluorescent protein. Upon the addition of biotin, it binds to the streptavidin and releases the reporter complex. In this case, the reporter complex starts it secretory pathway and is released from the ER. The advantage of the RUSH system is its precise timing, non-toxicity and thats its adaptable to a wide array of cargo proteins. In this thesis we mainly focus on the $\alpha$-mannosidase-II (ManII). This cargo protein has some function inside the golgi apparatus and, contrary to most proteins, is retained in the Golgi. As it is retained in the Golgi, the movies we will analyze will only contain the transport towards the golgi, so that we don't have to separate post and pre-golgi traffic. Figure **ref** shows several frames of the ManII transport cycle. Initially, the reporter is still in the ER and no cargo is observed in the Golgi. Then we observe a rise in the Golgi, where it remains. 

![Couple of frames of the ManII transport. ]()

## Analysis of fluorescence

We first perform a general analysis of the fluorescence intensity. We plot the average normalized fluorescence (that is, we normalize the fluorescence between 0 and 1 to get rid of the background in our statistics, average each frame and then normalize that between 0 and 1). The average fluorescence decays with almost $30\%$, which is a lot. We can also observe two 'regimes': between frame 0 and 100 we roughly see a very strong decay and after frame 100 we see a slower decay. The first regime is where all the cargo moves towards the Golgi, showing that the assumption that $I\propto c$ might not necessarily be true, while the second regime is probably caused by fluorescence extinction. 
![left panel: normalized fluorescence. Right panel: fluorescence of three golgis.](source/figures/pdf/general_fluorescence.pdf){#fig:fluorescence}
In the right panel we show the fluorescence in each of the golgi bodies. This has been calculated by averaging the fluorescence in each of the golgi for each frame, taking into account the decay of the fluorescence due as shown in the left panel and finally normalizing between 0 and 1. We observe that the fluorescence increase in each of the three cells is nearly similar; although one cells transport starts later than the rest, it seems to catch up to them. ALl three rise mostly before frame 100 and then plateau off. This suggests a common pattern, but what exactly??

## Analysis of time derivative
For the fit we have also determined the time derivatve of the fluorescence. This can also give us some qualitative data. We show 4 frames in figure .

![](source/figures/pdf/time_deriv.pdf)

We see that the initial cargo comes from an area close to the golgi and then slowly moves outwards. In the end all we see changing in time is the golgi. This shows that initially stuff gets released from an inner ring and maybe diffusies outward, before it condenses into the golgi.

## Analysis of LS-fit
We now turn towards an analysis of our LS fits. We used a window with of 7x7 in the spatial domain and 1 in the temporal domain, i.e. the fit of each frame is independent. We first show several 



## Analysis of constrained LS-fit

## Conclusion
Bayesian heeeeee

