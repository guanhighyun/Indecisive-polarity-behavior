% Adapted from "make_smoldyn_cfg.m" from Ramirez SA, Pablo M, Burk S,
% Lew DJ, Elston TC (2021). PLoS Comput Biol 17(7): e1008525.

% Inputs:
% fileprefix: the prefix of the cfg file.
% directory: directory where we write and store our cfg file. 
% tstop: time to stop the simulation
% samplingrate: Store the coordinates of molecules every 10 seconds. 
% Units in 0.1 ms.
% n_Cdc42: total number of Cdc42.
% n_BemGEF: total number of Bem1-GEF.
% n_FarGEF: total number of Far1-GEF.
% random_seed: a number which initializes a random number generator.

% Output:
% The cfg files will be generated in the "directory" folder.

function smoldyn_cfg(fileprefix,directory,tstop,samplingrate,n_Cdc42,n_BemGEF,n_FarGEF,random_seed)
% configuration file for smoldyn
cfg_name = [directory '/' fileprefix '.cfg']; 
% xyz coords of species. they'll be written to the same directory as 
% the .cfg file.
xyz_name = [fileprefix '.xyz']; 
fid=fopen(cfg_name,'w');

% Parameters for the simulation
d_sphere = 5;
r_sphere = d_sphere/2;
% zm is the ratio of the cytoplasmic volume over the membrane area 
zm = (4/3*pi*(r_sphere)^3)/(4*pi*(r_sphere)^2);
rho = 0.05;
dt = 0.0001;
k1a = 10*zm;
k1b = 40;
P2a = 5.3*dt;
k2b = 0.35;
P3 = 180*dt;
P2c = P3;
P4a = 40*dt;
k4b = 40;
k5a = 36*zm;
k5b = 13;
P7 = 6400*dt;
P8a = 7500*dt;
k8b = 0.11;
P9 = 0.625*dt;
k10 = 0.002;
Dm = 0.0025;
Dc = 15;

% Define a random number generator
fprintf(fid,'random_seed %i\n',random_seed);
% Reaction radius rho
fprintf(fid,'variable rho = %g\n',rho);
% A really small number which helps separate molecules
fprintf(fid,'variable rho_eps = 0.00001\n');
% Set the diameter and radius of the sphere.
fprintf(fid,'variable d_sphere = %g\n',d_sphere);
fprintf(fid,'variable r_sphere = %g\n',r_sphere);

% Reaction rates
fprintf(fid,'variable k1a = %g\n',k1a);
fprintf(fid,'variable k1b = %g\n',k1b);
fprintf(fid,'variable P2a = %g\n',P2a);
fprintf(fid,'variable P2c = %g\n',P2c);
fprintf(fid,'variable k2b = %g\n',k2b);
fprintf(fid,'variable P3 = %g\n',P3);
fprintf(fid,'variable P4a = %g\n',P4a);
fprintf(fid,'variable k4b = %g\n',k4b);
fprintf(fid,'variable k5a = %g\n',k5a);
fprintf(fid,'variable k5b = %g\n',k5b);
fprintf(fid,'variable P7 = %g\n',P7);
fprintf(fid,'variable P8a = %g\n',P8a);
fprintf(fid,'variable k8b = %g\n',k8b);
fprintf(fid,'variable P9 = %g\n',P9);
fprintf(fid,'variable k10 = %g\n',k10);

% Define domain boundaries
fprintf(fid,'dim 3\n');
fprintf(fid,'boundaries x -3 3\n');
fprintf(fid,'boundaries y -3 3\n');
fprintf(fid,'boundaries z -3 3\n');

% Define species
% Cdc42T: Cdc42-GTP
% Cdc42Dc: Cdc42-GDP in the cytoplasm
% Cdc42Dm: Cdc42-GDP on the membrane
% BemGEFc: Bem1-GEF in the cytoplasm
% BemGEFm: Bem1-GEF on the membrane
% BemGEF42: Bem1-GEF bound with Cdc42-GTP
% RaGEF: Active receptor bound with Far1-GEF
% Ra: Receptor
% FarGEF: Far1-GEF
fprintf(fid,'species Cdc42T Cdc42D BemGEF BemGEF42 complex_Cdc42D_BemGEF42 complex_Cdc42D_BemGEF\n');
fprintf(fid,'species Ra FarGEF RaGEF\n');
fprintf(fid,'species complex_Cdc42D_Ra complex_Ra_Cdc42T\n');

% Define diffusion rates. Dm: membrane diffusion rate. Dc: cytosolic
% diffusion rate. Receptors and their associated complexes diffuse at 
% 0.0001 um^2/s
fprintf(fid,'difc Cdc42T(down) %g\n',Dm);
fprintf(fid,'difc Cdc42D(soln) %g\n',Dc);
fprintf(fid,'difc Cdc42D(down) %g\n',Dm);
fprintf(fid,'difc BemGEF(soln) %g\n',Dc);
fprintf(fid,'difc BemGEF(down) %g\n',Dm);
fprintf(fid,'difc BemGEF42(down) %g\n',Dm);
fprintf(fid,'difc complex_Cdc42D_BemGEF42(down) %g\n',Dm);
fprintf(fid,'difc complex_Cdc42D_BemGEF(down) %g\n',Dm);
fprintf(fid,'difc Ra(down) %g\n',0.0001);
fprintf(fid,'difc RaGEF(down) %g\n',0.0001);
fprintf(fid,'difc FarGEF(soln) %g\n',Dc);
fprintf(fid,'difc Ra(soln) %g\n',Dc);
fprintf(fid,'difc complex_Cdc42D_Ra(down) %g\n',0.0001);
fprintf(fid,'difc complex_Ra_Cdc42T(down) %g\n',Dm);

% Set up lists to store molecular coordinates
fprintf(fid,'molecule_lists list1 list2 list3 list4 list5 list6 list7\n');
fprintf(fid,'mol_list Cdc42T(all) list1\n');
fprintf(fid,'mol_list BemGEF42(all) list2\n');
fprintf(fid,'mol_list Cdc42D(all) list3\n');
fprintf(fid,'mol_list BemGEF(all) list4\n');
fprintf(fid,'mol_list Ra(all) list5\n');
fprintf(fid,'mol_list RaGEF(all) list6\n');
fprintf(fid,'mol_list FarGEF(all) list7\n');

% Define a cell sphere
fprintf(fid,'start_surface inner_walls\n');
fprintf(fid,'action both all reflect\n');
fprintf(fid,'polygon both edge\n');
% Define the membrane association/dissociation rates
fprintf(fid,'rate BemGEF bsoln down k1a\n');
fprintf(fid,'rate BemGEF down bsoln k1b\n');
fprintf(fid,'rate Cdc42D bsoln down k5a\n');
fprintf(fid,'rate Cdc42D down bsoln k5b\n');
fprintf(fid,'rate Ra down bsoln k10\n');
fprintf(fid,'panel sphere 0 0 0 r_sphere 50 50 panel_inner\n');
fprintf(fid,'end_surface\n');

% Define the compartment which is required by Smoldyn to input molecules.
fprintf(fid,'start_compartment full_domain\n');
fprintf(fid,'surface inner_walls\n');
fprintf(fid,'point 0 0 0\n');
fprintf(fid,'end_compartment\n');

% Define reactions
% Bem1-GEFm + Cdc42Dm -> Bem1-GEFm + Cdc42T
fprintf(fid,'reaction Cdc42D_2_T_bindTo_BemGEFm  Cdc42D(down) + BemGEF(down) -> complex_Cdc42D_BemGEF(down)\n');
fprintf(fid,'reaction Cdc42D_2_T_catBy_BemGEFm complex_Cdc42D_BemGEF(down) -> Cdc42T(down) + BemGEF(down)\n');
fprintf(fid,'reaction_probability Cdc42D_2_T_bindTo_BemGEFm P2a\n');
fprintf(fid,'binding_radius Cdc42D_2_T_bindTo_BemGEFm rho\n');
fprintf(fid,'reaction_probability Cdc42D_2_T_catBy_BemGEFm 1\n');
% Place molecules beyond their reactive radius
fprintf(fid,'product_placement Cdc42D_2_T_catBy_BemGEFm unbindrad rho+rho_eps\n');

% Cdc42T -> Cdc42Dm
fprintf(fid,'reaction Cdc42T_2_Cdc42D Cdc42T(down) -> Cdc42D(down) k2b\n');

% Cdc42T-Bem1-GEF + Cdc42Dm -> Cdc42T-Bem1-GEF + Cdc42T
fprintf(fid,'reaction Cdc42D_2_T_bindTo_BemGEF42  Cdc42D(down) + BemGEF42(down) -> complex_Cdc42D_BemGEF42(down)\n');
fprintf(fid,'reaction Cdc42D_2_T_catBy_BemGEF42 complex_Cdc42D_BemGEF42(down) -> Cdc42T(down) + BemGEF42(down)\n');
fprintf(fid,'reaction_probability Cdc42D_2_T_bindTo_BemGEF42 P3\n');
fprintf(fid,'binding_radius Cdc42D_2_T_bindTo_BemGEF42 rho\n');
fprintf(fid,'reaction_probability Cdc42D_2_T_catBy_BemGEF42 1\n');
fprintf(fid,'product_placement Cdc42D_2_T_catBy_BemGEF42 unbindrad rho+rho_eps # place just beyond region\n');

% Cdc42T + Bem1-GEFm -> Cdc42T-Bem1-GEF
fprintf(fid,'reaction make_BemGEF42_fromm BemGEF(down) + Cdc42T(down) <-> BemGEF42(down)\n');
fprintf(fid,'reaction_probability make_BemGEF42_frommfwd P4a\n');
fprintf(fid,'binding_radius make_BemGEF42_frommfwd rho\n');
fprintf(fid,'reaction_rate make_BemGEF42_frommrev k4b\n');
fprintf(fid,'product_placement make_BemGEF42_frommrev unbindrad rho+rho_eps\n');

% Cdc42T + BemGEFc -> Cdc42T-Bem1-GEF
fprintf(fid,'reaction make_BemGEF42_fromc BemGEF(bsoln) + Cdc42T(down) -> BemGEF42(down)\n');
fprintf(fid,'reaction_probability make_BemGEF42_fromc P7\n');
fprintf(fid,'binding_radius make_BemGEF42_fromc rho\n');

% Ric + Cdc42T -> Ram + Cdc42T
fprintf(fid,'reaction Ric_recruitBy_Cdc42T Ra(bsoln) + Cdc42T(down) -> complex_Ra_Cdc42T(down)\n');
fprintf(fid,'reaction Ric_2_Ram complex_Ra_Cdc42T(down) -> Ra(down) + Cdc42T(down)\n');
fprintf(fid,'reaction_probability Ric_recruitBy_Cdc42T P9\n');
fprintf(fid,'reaction_probability Ric_2_Ram 1\n');
fprintf(fid,'binding_radius Ric_recruitBy_Cdc42T rho\n');
fprintf(fid,'product_placement Ric_2_Ram unbindrad rho+rho_eps\n');

% Far1-GEF + Ram -> RaGEF
fprintf(fid,'reaction FarGEF_bindTo_Ra Ra(down) + FarGEF(bsoln) -> RaGEF(down)\n');
fprintf(fid,'reaction_probability FarGEF_bindTo_Ra P8a\n');
fprintf(fid,'binding_radius FarGEF_bindTo_Ra rho\n');

% RaGEF -> Far1-GEF + Ram 
fprintf(fid,'reaction RaGEF_degradation RaGEF(down) -> Ra(down) + FarGEF(bsoln) k8b\n');
fprintf(fid,'product_placement RaGEF_degradation unbindrad rho+rho_eps\n');

% Cdc42Dm + RaGEF -> Cdc42T + RaGEF
fprintf(fid,'reaction Cdc42D_2_T_bindTo_RaGEF  Cdc42D(down) + RaGEF(down) -> complex_Cdc42D_Ra(down)\n');
fprintf(fid,'reaction Cdc42D_2_T_catBy_RaGEF complex_Cdc42D_Ra(down) -> Cdc42T(down) + RaGEF(down)\n');
fprintf(fid,'reaction_probability Cdc42D_2_T_bindTo_RaGEF P2c\n');
fprintf(fid,'binding_radius Cdc42D_2_T_bindTo_RaGEF rho\n');
fprintf(fid,'reaction_probability Cdc42D_2_T_catBy_RaGEF 1\n');
fprintf(fid,'product_placement Cdc42D_2_T_catBy_RaGEF unbindrad rho+rho_eps # place just beyond region\n');

% Define the starting and ending point and time step
fprintf(fid,'time_start 0\n');
fprintf(fid,'time_stop %i\n',tstop);
fprintf(fid,'time_step %g\n',dt);

% Input initial conditions: uniformly distributed molecules:
fprintf(fid,'compartment_mol %i Cdc42D(soln) full_domain\n',n_Cdc42);
fprintf(fid,'compartment_mol %i BemGEF(soln) full_domain\n',n_BemGEF);
fprintf(fid,'compartment_mol %i FarGEF(soln) full_domain\n',n_FarGEF);
fprintf(fid,'compartment_mol 500 Ra(soln) full_domain\n');
fprintf(fid,'surface_mol 2000 Ra(down) inner_walls sphere panel_inner\n');

% Output coordinates of molecules in the "xyz_name" file
fprintf(fid,'output_files %s\n',xyz_name);
fprintf(fid,'cmd N %i molpos Cdc42T(down) %s\n',samplingrate,xyz_name);
fprintf(fid,'cmd N %i molpos BemGEF42(down) %s\n',samplingrate,xyz_name);
fprintf(fid,'cmd N %i molpos Cdc42D(down) %s\n',samplingrate,xyz_name);
fprintf(fid,'cmd N %i molpos Cdc42D(soln) %s\n',samplingrate,xyz_name);
fprintf(fid,'cmd N %i molpos BemGEF(down) %s\n',samplingrate,xyz_name);
fprintf(fid,'cmd N %i molpos BemGEF(soln) %s\n',samplingrate,xyz_name);
fprintf(fid,'cmd N %i molpos Ra(down) %s\n',samplingrate,xyz_name);
fprintf(fid,'cmd N %i molpos Ra(soln) %s\n',samplingrate,xyz_name);
fprintf(fid,'cmd N %i molpos RaGEF(down) %s\n',samplingrate,xyz_name);
fprintf(fid,'cmd N %i molpos FarGEF(soln) %s\n',samplingrate,xyz_name);
end