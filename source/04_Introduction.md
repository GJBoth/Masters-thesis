# Introduction


## The golgi and the cell, a perspective

ER
ERES
Ribbon
Microtubules
Sorting and maturation
Maternal vs cisternal
Secretory pathway
De novo 

### Quantitative work on golgi so far

Not much quantitative work on the Golgi seems to have been done. We have found two studies, where only one provides an actual model. The first one by **ref** Ronchi uses laser nano-surgery to partially or completely remove the Golgi and they obtain two different growth curves as shown in figure **ref**. Observe that the fluorescence of the partially removed Golgi recovers immediatly, while there's a delay in the completely removed Golgi. Although they offer an explanation (see section golgi as active droplet), no quantitative model has been made. **GIVE EXPLANATION PAPER**

![Recovery curves Golgi]()

One such model is offered by Hirschberg **ref** in their 1997 paper. They follow a virus fused to a fluorescent protein from the ER through the Golgi to the plasma membrane. They determine the fluorescence in each area in time. The model they've developed is simple although seems to fit quite nicely. Its a kinetic model, meaning they have a rate for each step (see figure **ref**). Although this model fits their data, their model does not take into account several crucial features such as size of the Golgi, transport properties etc. All transport from the ER to the Golgi is reduced to a single kinetic parameter. **EXPLAIN MODEL MORE CLEARLY**.

## RUSH system

A technique known as RUSH (Retention Using Selective Hooks) has recently (2012) been developed in the team of Frank Perez at Institut Curie to study secretory traffic. It allows for the precise timing of the release of proteins from the endoplasmatic reticulum and can be used to follow the secretory pathway from the ER to the Golgi and even post-golgi using fluorescent live-cell imaging. 

![RUSH system]()

Figure **ref** shows the principle of the RUSH system. Inside a donor compartment, a hook protein in fused to a core streptavidin. A streptavidin-binding-protein (SBP) binds reversibly to the streptavidin and has both the protein to be followed attached to it (the reporter) and a fluorescent protein. Upon the addition of biotin, it binds to the streptavidin and releases the reporter complex. In this case, the reporter complex starts it secretory pathway and is released from the ER. The advantage of the RUSH system is its precise timing, non-toxicity and thats its adaptable to a wide array of cargo proteins. In this thesis we mainly focus on the $\alpha$-mannosidase-II (ManII). This cargo protein has some function inside the golgi apparatus and, contrary to most proteins, is retained in the Golgi. As it is retained in the Golgi, the movies we will analyze will only contain the transport towards the golgi, so that we don't have to separate post and pre-golgi traffic. Figure **ref** shows several frames of the ManII transport cycle. Initially, the reporter is still in the ER and no cargo is observed in the Golgi. Then we observe a rise in the Golgi, where it remains. 

![Couple of frames of the ManII transport. ]()

## This thesis



### Image analysis


### Golgi as a phase-separated droplet

In no particular order, there's a few notable things about golgi which  warrant a phase separation description:

* The Golgi is able to form de novo (Bevis)
* Microtubules position the golgi near the mtoc (Sengupta)
* Nocadazola depolymerizes microtubules -> golgi stacks move towards ERES (sengupta)
* Golgi size is dependent on amount of trafficking (Sengupta)
* Separate ministacks seems to be fully functional (Wei)
* Golgi disassembly is due to imbalanced trafficking: exit from ER is blocked, while outflow still continues (Ronchi)
* When golgi is completely cut out, stack like structures form around ERES (Ronchi) and then later move towards mtoc. 

We think we can describe this using an active droplet. Our model basically consists of two parts: We hypothesize that we can describe the transport between the ER and the golgi as a advection-diffusion equation and use a Cahn-Hilliard equation (see next section) to describe the phase separation. We thus need a a way to couple the transport model to the phase separation model. 

### Structure and main questions

This thesis consists of two parts. Part I contains my work related to the analysis of the RUSH experiments, while part II discusses the model I have developed for the Golgi. Although our image analysis was developed with the RUSH data in mind, it answers to a more general question: *how do we fit a 


