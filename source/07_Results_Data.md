# Data analysis

In the previous chapter we developed a general system to fit our advection-diffusion model to the data obtained from the RUSH experiments. In this chapter we apply said system to the MANII movies. MANII has been chosen as after arriving at the Golgi, it remains there. Dealing with only one transport direction makes everything a lot easier for us. This chapter consists of five sections:

* **Section 1** presents a general analysis of the fluorescence data of the movies
* In **section 2** we discuss the time derivative of the fluorescence, $\partial_t I$, as this also has some interesting points.
* **Section 3** contains our analysis of the least squares fit.
* **Section 4** is similar to section 3, only now we analyse a constrained fit with $D>0$.
* **Section 5** summarizes our findings and presents possible improvements for the system.

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

