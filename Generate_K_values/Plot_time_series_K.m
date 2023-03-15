%% Calculate time series of Ripley's K values
% We will read the sample data file which includes coordinates of all molecules.
filename = 'SampleData.xyz';
% Read molecular coordinates from each line of the .xyz file.
% nframes: total number of time points in the simulation
nframes = 401;
[~,coordinates]=read_molPos3(filename,nframes);
% Extract coordinates of active Cdc42 (in the form of Cdc42-GTP and
% the complex Bem1-GEF-Cdc42-GTP)
[active_xyz] = get_active_Cdc42_distr(coordinates,nframes);
K = nan(1,nframes);
r = 0.5:0.1:2.5; % The range of search radius for calculation of Ripley's K
for i = 1:nframes
K(i) = max(compute_Kr(active_xyz{i}(:,1),active_xyz{i}(:,2),r,L));
end
%% Plot time series of Ripley's K values
% The nth time point is (n-1)*10 seconds because we stored molecular coordinates
% every other 10 seconds and the first time point is 0 seconds.
time = 0:10:(nframes-1)*10; 
time = time/60; % convert from seconds to minutes
plot(time, K, 'linewidth', 4, 'color', 'k'); set(gca,'fontsize',25);
xlabel('Time (min)'); ylabel('K'); xlim([0,67]); ylim([0,4])
% This plot is the same as the black line in Figure 3C, which was generated
% with the .xyz same data file.