% This code is adapted from:
% Clark-Cotton MR, Henderson NT, Pablo M, Ghose D, Elston TC, Lew DJ. 
% Mol Biol Cell. 2021;32(10):1048-1063.

dirToWrite = 'PointSourcePheromoneSimulation'; % directory where we write and store our cfg file for Smoldyn simulations.
% generate the directory
mkdir(dirToWrite);
% open the run_all.sh bash file and write command lines into it
fid=fopen(sprintf('%s/run_all.sh',dirToWrite),'w');
fprintf(fid,'#!/bin/bash\n\n');
% Generate 174 config files for simulations
for i=1:50
    vesname = sprintf('ves_%02d',i);
    % Generate config files
    generate_vesicle_simulation(sprintf('%s/',dirToWrite),vesname,vesname,i);
    % Write command lines into the bash file for submitting jobs to the
    % computing cluster
    fprintf(fid,'sbatch -p general -N 1 -J ves%02d -t 24:00:00 --mem=1g --wrap="/nas/longleaf/home/kaiyun/Smoldyn/cmake/smoldyn %s.cfg"\n',i,vesname);
end
fclose(fid);