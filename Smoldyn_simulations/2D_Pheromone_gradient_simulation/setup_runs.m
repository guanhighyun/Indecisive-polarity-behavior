% Create the directory that stores the simulations
directory = 'GaussianSourcePheromoneSimulation';
mkdir(directory);

% End point of the simulation. Units in seconds.
tstop=15;
% Number of realizations
random_seeds = 1:50;

% Create the script file for SLURM to run the jobs.
fid=fopen(sprintf('%s/run.sh',directory),'w');
fprintf(fid,'#!/bin/bash\n\n');
for j = random_seeds
    curr_seed  = j;
    curr_fileprefix = sprintf('Gaussian_%02d',j);
    generate_Gaussian_simulation(curr_fileprefix,directory,tstop,curr_seed);
    cfg_name = sprintf('%s.cfg',curr_fileprefix);
    fprintf(fid,'sbatch -p general -N 1 -J Smoldyn -t 24:00:00 --mem=1g --wrap="/nas/longleaf/home/kaiyun/Smoldyn/cmake/smoldyn %s"\n',cfg_name);
end
fclose(fid);