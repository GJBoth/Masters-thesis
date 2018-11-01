# Introduction


## The golgi, biological perspective

### Quantitative work on golgi so far

## RUSH system

## Thesis


### Image analysis & Model fitting

Over the years many different techniques for analyzing biological movies and images have been developed. We can group them roughly by type of technique or type of microscopy. Save several types of super resolution techniques, we can define fluorescent images, where some fluorescent particle is attached to the cargo and bright and dark field, where we use normal light to view at the images. The RUSH experiments only allow us access to fluorescence images.

In analysis techniques we can roughly make two categories: single particle tracking and everything else. In single particle tracking, small fluorescent beads or particles are used which are a very small spot in a video and which we can localize. From frame to frame we can follow the particles to obtain a trajectory for each particle. From these trajectories we can then obtain transport properties. These techniques are very popular and powerful, but we require us to be able to track the particles. Unfortunately, for the data we have we cant.

Other methods which don't require single particle tracking often look at correlations. The correlation function $G$ is actually connected to the local transport properties. Unfortunately we need quite a bit of data to get some decent results out of this. Furthemore, this assumes that the particles are passive, which is not a given. Other techniques requires shifting the concentration profile to find the velocity, but we don't get any diffusion from this. Authors **ref** give another methods for calcuting the derivative and minimizing this, its called PIV. All these methods are cool but still very specific. 

Last years a lot of different methods for data analysis have come up. We can place the image analysis in a broader perspective to make use of these techniques. consider a movie: its taken as a number of frames, with each frame consisting of a bunch of points. We can regards each 

All these questions give rise to a more general question: given some spatio temporal data, such as a movie, and some model in the form of a 



### Physical Modeling

## Golgi as a phase-separated droplet

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



