% Input:
% dirToWrite: directory where we write and store our cfg file.
% fileprefix: the prefix of the cfg file name.
% random_seed: define the random number generator

% Output:
% The cfg files will be generated in the "dirToWrite" folder

function generate_Gaussian_simulation(fileprefix,dirToWrite,tstop,random_seed)

% configuration file for smoldyn
cfg_name = [dirToWrite '/' fileprefix '.cfg']; 
% xyz coords of species. they'll be written to the same directory as 
% the .cfg file.
xyz_name = [fileprefix '.xyz']; 
fid=fopen(cfg_name,'w');

% Time step
dt = 0.0001; 

% Random number generator
fprintf(fid,'random_seed %i\n',random_seed);

% Domain length
fprintf(fid,'variable L = 8.8623\n');

% Define the boundaries
fprintf(fid,'dim 2\n');
fprintf(fid,'boundaries x -0.2 L+0.2\n');
fprintf(fid,'boundaries y -0.2 L+0.2\n');

% Define the species
fprintf(fid,'species phe\n');

% Diffusion coefficient of the species
fprintf(fid,'difc phe %g\n',150);

% Build the domain. The boundary condition is periodic.
fprintf(fid,'start_surface inner_walls\n');
fprintf(fid,'action both all jump\n');
fprintf(fid,'action both phe absorb\n');
fprintf(fid,'polygon both edge\n');
fprintf(fid,'panel rect +x 0 0 L r1\n');
fprintf(fid,'panel rect -x L 0 L r2\n');
fprintf(fid,'panel rect +y 0 0 L r3\n');
fprintf(fid,'panel rect -y 0 L L r4\n');
fprintf(fid,'jump r1 front <-> r2 front\n');
fprintf(fid,'jump r3 front <-> r4 front\n');
fprintf(fid,'end_surface\n');

% Define the compartment which is required by Smoldyn to input molecules.
fprintf(fid,'start_compartment full_domain\n');
fprintf(fid,'surface inner_walls\n');
fprintf(fid,'point L/2 L/2\n');
fprintf(fid,'end_compartment\n');

% Set the reaction of pheromone degradation.
% The reaction rate is set to be a large number to avoid over-saturation of
% pheromone at the Gaussian source.
fprintf(fid,'reaction phe_degradation  phe -> 0 6931.5\n');

fprintf(fid,'time_start 0\n');
fprintf(fid,'time_stop %i\n',tstop);
fprintf(fid,'time_step %g\n',dt);

% We injected one pheromone molecule every 15 seconds. The distribution of 
% the pheromone molecule obeys the Gaussian. The center of the Gaussian is 
% (L/2,L/2), the standard deviation is 0.5.
fprintf(fid,'cmd I 1 %d 10 gaussiansource phe 1 L/2 0.65 L/2 0.65\n',tstop/dt);

% We stored the coordinates of pheromone molecules at each time step
% from 5 - 15 seconds.
fprintf(fid,'output_files %s\n',xyz_name);
fprintf(fid,'cmd I 50000 150000 1 molpos phe(all) %s\n',xyz_name);
end