% Create the directory that stores the simulations
directory = '2D_core_polarity_circuit';
mkdir(directory);

% End point of the simulation. Units in seconds.
tstop=4000;
% Store the coordinates of molecules every 10 seconds. Units in 0.1 ms.
samplingrate=100000;
% Range of Bem1-GEF. Modify if needed.
n_BemGEF = 40:40:600; 
% Range of Cdc42. Modify if needed.
n_Cdc42 = [1800,2000,2200,2500,2800,3000,3200,3500];
% Number of realizations
random_seeds = 1:10;

% Create the script file for SLURM to run the jobs.
fid=fopen(sprintf('%s/run.sh',directory),'w');
fprintf(fid,'#!/bin/bash\n\n');
for j = random_seeds
    for u = 1:numel(n_Cdc42)
        for v = 1:numel(n_BemGEF)
            curr_seed  = j;
            curr_fileprefix = sprintf('Cdc42_%g-Bem_%g-seeds_%d',n_Cdc42(u),n_BemGEF(v),j);
            smoldyn_cfg(curr_fileprefix,directory,tstop,samplingrate,n_Cdc42(u),n_BemGEF(v),curr_seed);
            cfg_name = sprintf('%s.cfg',curr_fileprefix);
            fprintf(fid,'sbatch -p general -N 1 -J Smoldyn -t 168:00:00 --mem=3g --wrap="/nas/longleaf/home/kaiyun/Smoldyn/cmake/smoldyn %s"\n',cfg_name);
        end
    end
end
fclose(fid);