# Structure for report
_Gert-Jan Both, 20/08/18_

## Introduction & general background
* Biological background
* RUSH system
* Explanation of model
* Description of project

## Part I - Data analysis of RUSH experiments

### I.I - Background w.r.t. data analysis and microscopy techniques
* Introduction to different microscopy techniques 
* Explanation why none of them will work
* Issues in cell transport: crowding, anomalous diffusion, 'dead' zones
* Different cargoes, general qualitative understanding
* General question: how to fit model?

### I.II - Preprocessing, naive fitting and analysis of results
* Explanation of pipeline
* Explanation of each part (filtering, derivative)
* Show fits of least-squares and analyze these pictures

## Part II - Modeling of Golgi biomaintenance and genesis

### II.I Background w.r.t to Cahn-Hilliard, active droplets and effective droplet model
* Phase separation, cahn-hilliard equation
* Activity and broken balance
* active and effective droplet model 

### II.II Effective droplet models
* Biological considerations
* Add advection
* Effective droplet model with 2 droplets

## Conclusion & Discussion
* Smart and vague things since that's probably gonna be all we can say


# To do

## Major
* Work on effective droplet models/ effect of convection on phase separation

## Hopefully
* Simulations on golgi maintenance (numerically solving cahn hilliard)
* Neural network on real data

## Minor
* Run least squares fit with right time steps
* Implement stridge/l1 regression with neural network (new and original work)


## Maybe if time
* Bayesian neural network (extremely cool and very new!)

