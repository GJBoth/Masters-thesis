# Introduction

The cell uses needs thousands of proteins and lipids to function and many of these are produced in the Endoplasmic Reticulum (ER), an organelle found in eukariotic cells. Exiting the ER, the cargo is transported throughout and outside the cell, completing what is called the *secretory pathway*. Key component in this intracellular trafficking is the Golgi apparatus, an organelle responsible for biochemically maturing proteins and lipids exiting the ER and directing them to the right location. Intense research over the last years has identified key players in the secretory pathway (@emr_journeys_2009, @tang_cell_2013) but an integrated model coupling Golgi size and function to the intracellular transport is lacking (@rothman_future_2010, @gosavi_function_2017). In this thesis, we seek exactly such a model. 


## The secretory pathway: biology 101 for physicists

Proteins produced in the ER exit the organelle at specific places known as ER Exit Sites - ERES. At the ERES, cargo is packaged into a lipid bilayer and this package, known as a vesicle, buds off into the cytoplasm[@budnik_er_2009]. As ERES are located throughout the cell, the vesicles need to be transported to the Golgi apparatus. In general, intracellular transport has two modes: diffusive and active [@bressloff_stochastic_2013]. In the active mode, molecular motors pull the vesicles across microtubules. Microtubules (MTs) are tubular polymers which form a network throughout the cell (in fact, they are part of the cytoskeleton) and act as the backbone for intracellular transport. They nucleate and organise around objects known as MicroTubular Organisation Centers (MTOCs). The primary MTOC is the centrosome, an organelle located next to the nucleus, but strong evidence exists that the Golgi apparatus acts a nucleation center too [@wei_unraveling_2010],[@ronchi_positive_2014]. 

MTs are polarized, having two distinct ((+) and (-)) ends, and use different molecular motors (dynesin and kynesin respectively) for transport towards each end [@newby_quasi-steady_2010]. Research has shown that cargo constantly switches between these two transport directions in a random fashion, making active transport in the cell a stochastic process which can be described by a tug-of-war model [@newby_random_2010]. It's also possible for the cargo to completely detach from the MT. The cargo will then move through the cytoplasm in a diffusive way, until it reattaches to a microtubule. 

The appearance of the Golgi is strongly dependent on the cell type. In plants for example, the Golgi is distributed throughout the cell in separate but fully functional subunits [@staehelin_nanoscale_2008] known as stacks, whereas in mammals all these stacks are localized in a single organelle, the *Golgi Ribbon* [@wei_unraveling_2010].  Each Golgi stack consists of a number of stacked compartments with a disk-like shape called cisternae. These are membrane enclosed objects with enzymes responsible for biochemically altering proteins. The golgi has distinct entry and exit faces known respectively as the cis and trans face, with the cisternae being labeled analogously. At the cis-face vesicles fuse with the golgi, releasing their cargo into a compartment, while their lipid bilayer becomes part of the golgi membrane. At the trans-face, the cargo is encapsulated again in a lipid bilayer made from the golgi membrane and is transported to its destination. The Golgi thus acts as a sort of post-office of the cell, receiving cargo, repackaging and sending it to the right destination [@alberts_molecular_nodate].

![**Left panel**: the cisternal maturation model. **Right panel**: the vesicle-shuttle model. Image taken from @griffiths_rubisco_nodate](source/figures/png/golgimodels.png){#fig:golgimodels}

Exactly how this sorting and maturing inside the Golgi happens is debated [@glick_models_2011, @griffiths_rubisco_nodate]. The two main competing models are known respectively as the *cisternal maturation* and *vesicle shuttle*. In figure @fig:golgimodels we show the structure of the Golgi and and a schematic view of each model. In the cisternal maturation model (see the left panel of @fig:golgimodels) , incoming vesicles form a cis-compartment which then matures as whole to a medial and finally trans-compartment. Vesicles are budded off and any excess membrane is trafficked back to the cis face. In the vescile shuttle model, the cisternae are static entities with a defined task and cargo is moved from one compartment to the next by vesicles. This is shown in the right panel. After budding off from the trans face, the cargo is transported to either some location in the cell or secreted. 

### Quantitative models of the Golgi

Although the Golgi has been intensively studied by biologists for many years, very few quantitative work has appeared. Our research only turned up a single attempt by Hirschberg et al @hirschberg_kinetic_1998 in which they use a kinetic model to describe the trafficking of a virus (VSVG) from the ER through the Golgi to the plasma membrane.  We reprint their main result in figure @fig:ratemodel. 



![**Left panel**: First order rate model fitted to experimental data by Hirschberg et al. **Right panel**: Inferred concentration in ER, Golgi and PM using the fitted parameters from the left panel and their model.  Image taken from @hirschberg_kinetic_1998 ](source/figures/png/kineticmodel.png){#fig:ratemodel}



Hirschberg et al model the secretory pathway by dividing it into three reservoirs: each one representing respectively the ER, Golgi and the PM. The compartments are connected by a first-order rate equation, i.e. $d \phi_{golgi}/dt=k_{ER \to Golgi}\phi_{ER}$ and they show (see figure @fig:ratemodel) that such an equation is sufficient to model both total concentration in the cell as well as the concentration in the Golgi. Although this model fits the experimental data well, it's a phenomological model, reducing many processes to a single rate parameter $k$ and neglecting any spatial dependence. It is thus unable to provide any information on how the intracellular transport of the vesicles couples to the function and size of the Golgi. 

## This thesis

In this thesis we seek to build a model which couples intracellular transport to the Golgi function and size. We hypothesize that we can describe the Golgi as an *active, phase separated droplet*. We also confront our model with experimental data, obtained by the group of Frank Perez at Institut Curie. This group developed a new technique called RUSH[@boncompain_synchronization_2012] which allows precise timing of the release of proteins from the ER and study the intracellular transport using fluorescence microscopy. In the next sections, we justify the description of the Golgi as an active phase-separated droplet and how we intend to perform the data analysis of the experimental data.

### Golgi as an active phase-separated droplet

Many biological processes require a relatively high concentration of some protein or lipid to occur. This can be reached by physically separating this protein inside a membrane, but the cell has several membraneless organelles. Such an organelle thus needs a different process to reach such concentrations. The prime candidate is liquid-liquid phase separation and indeed it is able to correctly describe several phenomena such as P-granules[@hyman_liquid-liquid_2014]  and centrosome growth[@zwicker_centrosomes_2014]. 

The strongest clue for describing the Golgi comes from its biogenesis: upon removal, the Golgi is able to form *de novo*. Ronchi et al [@ronchi_positive_2014] study golgi biogenesis in detail and found several phases of growth. First, vesicles are released from the ER until after some time stack-like structures are formed, including a cisternae-like topology. In the second phase, the stacks are transported by the microtubules to thelocation of the would-be golgi, where the stacks are fused into a single golgi ribbon. The first phase resembles phase transition: once the solution reaches some critical density, phase separation occurs and a dense droplet is formed. One crucial detail we've skipped over is that the golgi isn't a membraneless organelle. The cargo entering and exiting the Golgi isnt membraneless either; while these membranes ensure phase separation of the cargo, if we interpret the vesicles as the liquid to separate, phase separation occurs if the vesicles combine into a single dense droplet - the Golgi. A droplet arising from such a description would be a passive droplet however, forever growing. Contrarily, the golgi constantly takes up vesicles with immature proteins while vesicles with mature proteins bud off. Including a term to mimic this process makes the droplet *active*. We can thus model a membrane-delimited organelle using tools normally used for membraneless ones. 

### Biological image analysis

Image analysis is a lively subject in cell biology, with many different methods and techniques being developed constantly.  The last years image analysis is being developed with the specific goal of quantification in mind[@de_vos_seeing_2016], specifically as an insight into intracellular transport (@hutchison_computational_2014, @lee_image-based_2015, @yang_bioimage_2013). To analyze intracellular transport or flow in a cell, single particle tracking (SPT) is a powerful method. SPT uses small fluorescent beads or particles suspended in a flow which can be tracked by a computer. The obtained trajectories can then be analyzed to obtain information about the transport. The RUSH method doesn't make use of such beads or particles, so that these techniques cannot be applied. Alternative methods mainly utilize some sort of correlation spectroscopy (@hebert_spatiotemporal_2005, @kisley_characterization_2015, @semrau_particle_2007). One can derive a general relation between the correlation of the noise and transport properties such as the diffusion constant. These techniques require a signal roughly constant in time, which unfortunately is not a given for the RUSH experimental data. Thus, none of the techniques we found are applicable to the RUSH data. 

All these methods are a specific solution to a general problem: how do we fit a model to a spatiotemporal dataset?  Since most of the times a model is written in the form a partial differential equation  (i.e. $df/dt = \alpha df/dx+\beta d^2f/dx^2+...$), while the data is $f(x,t)$, this is not a trivial problem. In this case, we're actually asking what set of parameters in our model (such as a diffusion coefficient) best describes the temporal evolution of a dataset. We have developed and evaluated two different methods for doing this. Our first method attacks the problem rather directly, by calculating spatial and temporal derivatives directly from the data using something known as image gradients. Our second alternative method is based on a recently invented method based on neural networks [@raissi_physics_2017].  We'll show that by encoding physics into the neural network, we're not only able to infer the optimal parameters, but even an optimal parameter *field*.

### Structure and main questions

The rest of this thesis is divided into two parts. In the first part we show the two model fitting methods we have developed and apply them to the RUSH experimental data. The second part discusses the model we have developed for the Golgi. In a chapter-by-chapter breakdown, we have the following:

* **Part I - Model fitting and data analysis**
    * **Chapter 2** introduces the framework we have developed for model fitting spatiotemporal data using image gradients. 
    * **Chapter 3** applies the method developed in chapter 2 to experimental data.
    * **Chapter 4** shows an alternative method for model fitting based on neural networks.
* **Part II - Model for Golgi **
    * **Chapter 5** introduces the Cahn-Hilliard equation, which describes phase separation, an approximation of it known as effective droplet theory and describes our model. 
    * **Chapter 6** contains the predictions the model developed in chapter 5 and investigates the biological implications.
* **Chapter 7-** is the concluding chapter and summarizes all the findings from the previous chapters.






