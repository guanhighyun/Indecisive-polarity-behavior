### Accompanies ... (paper title to be determined)

The simulations were performed on Longleaf, a Linux-based computing system, using Smoldyn v2.67/v2.71 and analyzed in MATLAB 2021a/2021b. Representative scripts and data are provided to generate particle-based simulations and figures. 


### Contents contain code for:
1. Generating the main text and supplementary figures.
2. Writing Smoldyn scripts for particle-based simulations (`Smoldyn_simulations`):
- Simulations of 2D core polarity circuit model (`2D_core_polarity_circuit_model`) (Fig. 1).
- Simulations of 2D and 3D combined polarity circuit model (`2D_combined_polarity_circuit_model`, `3D_combined_polarity_circuit_model`) (Fig. 2 (set initial Bem1-GEF number = 0), Fig. 3, Fig. 4).
- Simulations of 2D combined polarity circuit model with fixed Far1-GEF (`2D_combined_polarity_circuit_model_with_fixed_Far1GEF`) (Fig. 4D, E)
- Simulations of 2D and 3D pheromone gradients for concentration measurement (`2D_pheromone_gradient_simulation`, `3D_pheromone_gradient_simulation`) (Fig. 5, Fig. 6). 
- Simulations of 2D and 3D combined polarity circuit model with the pheromone gradient (`2D_combined_polarity_circuit_model_with_pheromone`, `3D_combined_polarity_circuit_model_with_pheromone`) (Fig. 5, Fig. 6).

Add the "Dependencies" to the MATLAB path.

The folder "FigureData" contains x and/or y values of the figure.
The folder "Coordinates" contains coordinates of molecules in the particle-based simulations.
The folder "K_values" contains Ripley's K function values calculated from the molecular coordinates generated by particle-based simulations at a particular number of Cdc42.
For example, "K_1800.mat" contains the values of K generated by simulations with 1800 Cdc42.
