% Detect clusters by the algorithm based on Voronoi tessellation.

% Inputs for the sample data:
% random_seeds: 2. Random seeds generator.
% n_BemGEF: 170. Total number of Bem1-GEF.
% n_Cdc42: 3000. Total number of Cdc42.
% n_FarGEF: 30. Total number of Far1-GEF.

% Add the folders "VoronoiLimit", "intersections", and "SampleData" to the MATLAB Path.
function pipeline(random_seeds,n_BemGEF,n_Cdc42,n_FarGEF)
nframes = 401;
density_distrs = cell(1,nframes);
uniform_density_distrs = cell(1,nframes);
uniform_coordinate = cell(1,nframes);
updated_coordinate = cell(1,nframes);
cutoff = nan(1,nframes);
n_cluster = nan(1,nframes);

% The threshold area of a polarity site.
area_threshold = 0.785; 
% The threshold number of Cdc42-GTP in a polarity site.
number_threshold = 90; 
% The threshold Cdc42-GTP density of a polarity site.
cluster_density_threshold = number_threshold/area_threshold; 
L = 8.8623;

% The sample data file contains spatiotemporal coordinates of all molecules.
xyzname = sprintf('Cdc42_%g-Bem_%g-Far_%g-seeds_%d.xyz',n_Cdc42,n_BemGEF,n_FarGEF,random_seeds);
filename = sprintf('SampleData/%s',xyzname);

% Get the coordinates of all molecules.
[~, pos]=read_molPos3(filename,nframes);
% Extract the coordinates of Cdc42-GTP.
active_cdc42=get_active_Cdc42_distr(pos,nframes);

for i = 2:nframes
    [density_distrs{i}, updated_coordinate{i}, ~] = calculate_density_distributions(active_cdc42{i},L);
    [uniform_density_distrs{i}, uniform_coordinate{i}, ~] = simulate_uniform_density_distributions(active_cdc42{i},L);
    [cutoff(i)] = compare_voronoicell_size_distributions(density_distrs{i}, uniform_density_distrs{i});
    % Get the number of clusters at each time point.
    [n_cluster(i)] = calculate_number_of_clusters(updated_coordinate{i}, cutoff(i), area_threshold, cluster_density_threshold, L);
end
% Store the data. 
save(sprintf('Cluster_detection_%s.mat',xyzname)) 

% Plot the number of clusters across time
tfinal = 401;
time = (0:10:(tfinal-1)*10)/60; % Convert seconds to minutes
figure; plot(time,n_cluster,'color',[0 0.4470 0.7410]);
xlabel('Time (min)')
ylabel('Number of clusters')
set(gca,'fontsize',20)
xlim([0,time(end)])
ylim([0,3])
end