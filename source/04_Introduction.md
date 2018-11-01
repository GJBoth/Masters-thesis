# Introduction

The cell is a highly dynamic object and requires dozens of proteins for proper functioning. Most of these proteins are produced in the Endoplasmic Reticulum (ER), an organelle found in eukariotic cells around the nucleus. Secretions from the ER don't travel directly to their destination. Rather, they move through the cell to the Golgi apparatus, after which they move to their destination. The Golgi doesn't only act as some sort of sorting centre, but it also matures the proteins coming in. The Golgi apparatus is thus a key component in intracellular trafficking, more specifically the secretory pathway. Despite intense effort, an integrated model is lacking. It is exactly this model which we're pursuing in this thesis. 

## The secretory pathway: a biological perspective

Proteins which move through the Golgi typically start out in the endoplasmatic reticulum. The ER is network of something around the nucleus and is sort of an protein factory. THe lipids and proteins exit the ER at specific sites known as Endoplasmic reticulum exit sites, or ERES. Cargo is transported through the cell packed in a lipid bilayer - the whole package is known as a vesicle. 

Vesicles are transported by two main pathways: either diffusive through the cytoplasm or by active transport. The active transport takes place by molecular motors across microtubules. Microtubules are tube-like structures made from tubulin and stretch throughout the cell, forming a sort of protein highway. Microtubules are nucleated by objects known are MicroTubular Organization Centers (MTOC), with the centrosome being the primary one. Many evidence exists however for the Golgi also being an important MTOC. Basically like having a highway down your front door. 

Many different types of cells have golgi apparatuses, with different appearances of the Golgi. It consists of several independent completely functional subunits known as stacks. In plants for example, these stacks are distributed throughtout the cell, whereas (normally) they form a single ribbon next to the nucleus in mammals. The exact reason for this is not yet known, and we leave this question for what it is. We focus only on mammalian cells.

As stated, in mammalians the golgi forms a single big organelle known as a ribbon and that each ribbon consists of fully functional stacks. Each stack consists of a number of compartments known as cisternae. We show a ribbon in figure **ref** and a stack in figure **ref**. Cisternae are flattened membranes and look like a disk, so a stack is liteally a stack of these cisternae disks. The membrane is made of vesicular material from the ER. The golgi is not isotropic: absorption of vesicles happens on one side, known as the cis-face (cis-compartments) while secretion happens on another - the trans-face. Compartments inbetween are known as medial compartments. Vesicles fusing with the cis-face releasing their contents. Depending on the final location of the proteins, the proteins will be modified ('matured') and sent on. The Golgi thus acts like a post office, receiving mail and sending it on to the right receiver. 

Exactly how this sorting and maturing inside the Golgi happens is not sure. Two main models are currently contenders. The first one is known as maternal (?) and assumes that the cargo proteins move through each cisterna as a multi stage step, each cisterna has a specific task and the cargo moves from one cisterna to the next. The other model is called cisternal maturation and states that each cisterna matures as a whole, moving through each step. Each model offers explanations for some observations, but not all. Cargo is budded of from the Golgi in vesicles. These vesicles move to where they need to go, such as the plasma membrame. 

### Quantitative work on golgi so far
One such model is offered by Hirschberg **ref** in their 1997 paper. They follow a virus fused to a fluorescent protein from the ER through the Golgi to the plasma membrane. They determine the fluorescence in each area in time. The model they've developed is simple although seems to fit quite nicely. Its a kinetic model, meaning they have a rate for each step (see figure **ref**). Although this model fits their data, their model does not take into account several crucial features such as size of the Golgi, transport properties etc. All transport from the ER to the Golgi is reduced to a single kinetic parameter. **EXPLAIN MODEL MORE CLEARLY**.

## This thesis

Years of research have quantified key players in the process off maturation and secretion, transport etc. A single integrated model coupling Golgi function and shape to transport parameters is lacking however. In order to understand more about the Golgi, we believe such a model is required and in this thesis we seek to fill this gaping hole in our knowledge. We hypothesize that we can describe the Golgi apparatus as a phase separated droplet. More strongly, since the Golgi matures proteins, we need a description allowing for this and thus make the droplet active - the golgi as an *active phase-separated droplet*. 

We also compare the model we've developed to data. We've worked with biologists in the team of Frank Perez. They've developed a new technique known as RUSH, which allows precise timing of release of proteins from the ER and allows them to take really nice videos. In the next sections, we state why we believe we can describe the golgi as an active droplet and how we intend to perform the data analysis. 

**SOMETHING ABOUT QUANTITATIVE BIOLOGY?**

### Golgi as a phase-separated droplet

Why do we think we can describe the Golgi as a phase separated droplet? First and foremost, phase separation turns out be quite important in biology and shows quite some promising feauture such as able to predict the growth of the centrosome or even cell division. A second stronger argument is the biogenesis of the Golgi. Roughly speaking, there are two ways for an organelle to form. One could follow some sort of template, while a second way is self organization. Ronchi et al use laser nano-surgery to completely remove the Golgi apparatus and next observe the *de novo* formation of the Golgi. They identify a few stages: in the beginning, vesicles are released from the ER but nothing happens. Without Golgi, the microtubular transport is not working so the vesicles stay around the ERES. After some concentration, stack-like structures are formed, including the cisterna like topology. After microtubules have recovered/been built, these move the golgi to its location next to the nucleus and the mtoc. This sounds peculiarly like a phase transition: once a certain critical concentration is reached, the solvent phase separates. In this case, the golgi would be modeled as a dense droplet in a sea of dilute phase; the cytoplasm.

The cytoplasm isn't a simple dilute phase though; its where the transport from the ER to the Golgi/droplet takes place. The transport of the vesicles from the ER to golgi takes place mainly across microtubules. We hypothesize we can model this as some kind of flow, next to diffusion and to model the golgi as a marriage between a flow model and phase separation.  

The interested reader will say that phase separation has been used to describe membraneless organelles and entities and that the Golgi is one big batch of membranes almost. We still think we can use it though. To see why, consider the following argument. Cargo is released from the ER in vesicles i.e. a lipid membrame. Once it reaches the golgi, the membrame becomes part of the cisternae. So the golgi is also a mix of cargo in various stages of maturation and membrane, while the cargo leaving the golgi is also a vesicle. Thus although the membrane has an important biological function, we state the physically we can 'ignore' it by defining our phase separating material to be just cargo or some mix of cargo. 

### Biological image analysis

Over the years many different techniques for analyzing biological movies and images have been developed. We can group them roughly by type of technique or type of microscopy. Save several types of super resolution techniques, we can define fluorescent images, where some fluorescent particle is attached to the cargo and bright and dark field, where we use normal light to view at the images. The RUSH experiments only allow us access to fluorescence images.

In analysis techniques we can roughly make two categories: single particle tracking and everything else. In single particle tracking, small fluorescent beads or particles are used which are a very small spot in a video and which we can localize. From frame to frame we can follow the particles to obtain a trajectory for each particle. From these trajectories we can then obtain transport properties. These techniques are very popular and powerful, but we require us to be able to track the particles. Unfortunately, for the data we have we cant.

Other methods which don't require single particle tracking often look at correlations. The correlation function $G$ is actually connected to the local transport properties. Unfortunately we need quite a bit of data to get some decent results out of this. Furthemore, this assumes that the particles are passive, which is not a given. Other techniques requires shifting the concentration profile to find the velocity, but we don't get any diffusion from this. Authors **ref** give another methods for calcuting the derivative and minimizing this, its called PIV. All these methods are cool but still very specific. 

All these methods are very specific solutions to general problems. The basic question among all these methods is: I have a model and some data, and I want to fit the model to the data to, for example, obtain a diffusion coefficient or advection speed. Since most of the times a model is written as a partial differential equation, performing a model fit is not an entirely trivial business. In other words, if we have a model in the form of a PDE, we're actually asking if the temporal evolution of a dataset if governed by our PDE We have developed and evaluated two different methods for doing this. Our first method attacks the problem rather directly, by calculating spatial and temporal derivatives directly from the data using something known as image gradients. Our second alternative method is an almost new highly experimental method based on neural networks. As it turns out, neural networks have some inherent properties which make it extremely useful for fitting models to data. 

### Structure and main questions

This thesis consists of two parts. Part I shows the two different model fitting methods we have developed and applies them to rush data, while part II discusses the model I have developed for the Golgi. More specifically:

* **Part I - Model fitting and data analysis**
    * **Chapter 2** introduces the framework we have developed for model fitting spatiotemporal data using image gradients. 
    * **Chapter 3** applies the method developed in chapter 2 to experimental data.
    * **Chapter 4** shows an alternative method for model fitting based on neural networks.
* **Part II - Model for Golgi biogenesis**
    * **Chapter 5** introduces the Cahn-Hilliard equation, which describes phase separation, an approximation of it known as effective droplet theory and describes our model. 
    * **Chapter 6** contains the predictions the model developed in chapter 5 and investigates the biological link.
* **Chapter 7-** is the concluding chapter and summarizes all the findings from the previous chapters.






