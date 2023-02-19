% This code is adapted from:
% Clark-Cotton MR, Henderson NT, Pablo M, Ghose D, Elston TC, Lew DJ. 
% Mol Biol Cell. 2021;32(10):1048-1063.

% Input:
% dirToWrite: directory where we write and store our cfg file.
% fileprefix: the prefix of the cfg file name.
% outputname: the name of the output file where the molecular coordinates
% are stored.
% randomseedvalue: define the random number generator

% Output:
% The cfg files will be generated in the "dirToWrite" folder

function generate_vesicle_simulation(dirToWrite,fileprefix,outputname,randomseedvalue)
cfg_name = [dirToWrite '/' fileprefix '.cfg'];

fid=fopen(cfg_name,'w');
write_setup(fid,randomseedvalue,outputname);
fclose(fid);
end

function write_setup(fid,randomseedvalue,outputname)
fprintf(fid,'random_seed %i\n',randomseedvalue);

fprintf(fid,'variable d_sphere 5\n');
fprintf(fid,'variable sep_dist 0.25\n');
fprintf(fid,'variable Dpher 150 # um2/s\n');
% We found no significant difference in distribution of pheromone concentration
% between the simulations with a domain length of 10 um and the ones with 50 um
fprintf(fid,'variable d_simdomain 10\n'); 
fprintf(fid,'variable sim_dt 0.0001 # seconds, use this to correct emission rate\n');


fprintf(fid,'dim 3\n');
fprintf(fid,'boundaries x -d_simdomain-sep_dist d_simdomain+sep_dist\n');
fprintf(fid,'boundaries y -d_simdomain-sep_dist d_simdomain+sep_dist\n');
fprintf(fid,'boundaries z -d_simdomain-sep_dist d_simdomain+sep_dist\n');
fprintf(fid,'\n\n');

fprintf(fid,'species pheromone\n');
fprintf(fid,'difc pheromone(all) Dpher\n\n');

fprintf(fid,'start_surface receiver\n');
fprintf(fid,'polygon both edge\n'); %%%
fprintf(fid,'action both all reflect\n');
fprintf(fid,'panel sphere d_sphere/2+sep_dist/2 0 0 -d_sphere/2 10 10\n');
fprintf(fid,'end_surface\n\n');

fprintf(fid,'start_surface emitter\n');
fprintf(fid,'polygon both edge\n'); %%%
fprintf(fid,'action both all reflect\n');
fprintf(fid,'panel sphere -(d_sphere/2+sep_dist/2) 0 0 -d_sphere/2 10 10\n');
fprintf(fid,'end_surface\n\n');

fprintf(fid,'start_surface sim_boundary\n');
fprintf(fid,'action both all absorb\n'); 
fprintf(fid,'polygon both none\n'); %%%
fprintf(fid,'panel sphere 0 0 0 -d_simdomain 10 10\n');
fprintf(fid,'end_surface\n\n');

fprintf(fid,'# Pseudosurface for keeping track of molecular coordinates.\n');
fprintf(fid,'start_surface surveillance_boundary\n');
fprintf(fid,'polygon both edge\n'); %%%
fprintf(fid,'action both all transmit\n');
fprintf(fid,'panel sphere d_sphere/2+sep_dist/2 0 0 -(d_sphere/2+1) 50 50\n');
fprintf(fid,'end_surface\n\n');

fprintf(fid,'# Pseudocompartment for keeping track of molecular coordinates.\n');
fprintf(fid,'start_compartment surveillance_compartment\n');
fprintf(fid,'surface surveillance_boundary\n');
fprintf(fid,'point d_sphere/2+sep_dist/2 0 0\n');
fprintf(fid,'end_compartment\n\n');

fprintf(fid,'time_start 0\n');
fprintf(fid,'time_stop 15\n');
fprintf(fid,'time_step sim_dt\n\n');

write_vesicle_events(fid);

fprintf(fid,'output_files %s.xyz\n',outputname);
fprintf(fid,'cmd I 50000 150000 1 listmolscmpt pheromone(all) surveillance_compartment %s.xyz\n',outputname);
fprintf(fid,'end_file\n');
end

function write_vesicle_events(fid)
% Generate timepoints at which to create vesicles.
t=0;
times=[]; % milliseconds
while t<(15) % 101 second simulation time
    vesicle_time = exprnd(1.188); % new vesicle every 1.188 seconds on avg
    t=t+vesicle_time;
    times=[times;t];
end
for i=1:numel(times)
    % Release 1663 pheromone once when simulation time exceeds times(i)
    fprintf(fid,'cmd @ %.4f pointsource pheromone 1663 -sep_dist/2+0.001 0 0\n',times(i));
end
end
