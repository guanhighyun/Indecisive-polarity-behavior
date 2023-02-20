% Create the directory that stores the simulations
directory = '2D_combined_polarity_circuit_with_fixed_Far1GEF';
mkdir(directory);

% End point of the simulation. Units in seconds.
tstop=4000;
% Store the coordinates of molecules every 10 seconds. Units in 0.1 ms.
samplingrate=100000;
% Number of Bem1-GEF. Modify if needed.
n_BemGEF = 170; 
% Number of Cdc42. Modify if needed.
n_Cdc42 = 3000;
% Number of realizations. Modify if needed.
random_seeds = 1;
% Number of Far1-GEF. Modify if needed.
n_FarGEF = [1,4,9,11,12,13,14];

% Create the script file for SLURM to run the jobs.
fid=fopen(sprintf('%s/run.sh',directory),'w');
fprintf(fid,'#!/bin/bash\n\n');
for j = random_seeds
    for u = 1:numel(n_Cdc42)
        for v = 1:numel(n_BemGEF)
            for w = 1:numel(n_FarGEF)
                curr_seed  = j;
                curr_fileprefix = sprintf('Cdc42_%g-Bem_%g-Far_%g-seeds_%d',n_Cdc42(u),n_BemGEF(v),n_FarGEF(w),j);
                smoldyn_cfg(curr_fileprefix,directory,tstop,samplingrate,n_Cdc42(u),n_BemGEF(v),n_FarGEF(w),curr_seed);
                cfg_name = sprintf('%s.cfg',curr_fileprefix);
                fprintf(fid,'sbatch -p general -N 1 -J Smoldyn -t 264:00:00 --mem=5g --wrap="/nas/longleaf/home/kaiyun/Smoldyn/cmake/smoldyn %s"\n',cfg_name);
            end
        end
    end
end
fclose(fid);