% Show the bimodal distribution of K values for simulations in the transient
% polarity regime.

% Number of Cdc42 and Bem1-GEF.
n_Cdc42_list = [1800,2000,2200,2500,2800,3000,3200,3500]; BemGEF_list = 0:0.5:1000; 
% Number of realizations in each regime.
seeds = 10; 
% Ripley's K values are calculated from the coordinates of Cdc42-GTP 
% collected every 10 seconds from 2000 seconds to 4000 seconds of each 
% simulation, so that produced 201 K values.
standard_num_K = 201*2*seeds; 
% The file path of stored K values.
K_file_path = '../K_values/2DCorePolarity';

% Threshold difference in frequency of K for a transient polarity regime
upper_threshold = 2814;
lower_threshold = -2814;

K_transient_polarity_regime = [];
for i = 1:numel(n_Cdc42_list)
    n_Cdc42 = n_Cdc42_list(i);
    load(sprintf('%s/K_%g.mat',K_file_path,n_Cdc42));
    % Get the differences in frequency of K.
    [~, ~, ~, ~, K_diff, ~] = identify_regimes(n_Cdc42,BemGEF_list,seeds,standard_num_K, K_file_path);
    % Find the indices of K_diff in the transient polarity regime.
    idx_transient_polarity = find(K_diff>=lower_threshold & K_diff<=upper_threshold);
    % Combine the K values in all of the transient polarity regimes.
    K_transient_polarity_regime = [K_transient_polarity_regime, K1{1,idx_transient_polarity ,:}, K2{1,idx_transient_polarity,:}];
end
% Generate the histogram.
figure; hold on; histogram(K_transient_polarity_regime,'binwidth',0.2,'normalization','pdf','facecolor','#4DBEEE','edgecolor','#4DBEEE')
% Knernel density estimation for K.
[density,x] = ksdensity(K_transient_polarity_regime); 
% Plot the estimated density.
plot(x, density, 'k-', 'linewidth', 5); 
set(gcf,'Position',[300 300 400 250]); xlim([-0.1,Inf])
set(gca,'fontsize',25); ylabel('Density'); xlabel('K'); hold off;