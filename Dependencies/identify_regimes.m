% Identify parameter regimes of different polarity site dynamics.

% Inputs:
% n_Cdc42: total number of Cdc42.
% BemGEF_list: a wider range of Bem1-GEF used to generate the bifurcation 
% diagram.
% seeds: initialize a random number generator.
% standard_num_K: number of Ripley's K values produced from each simulation. 
% Each simulation should have 201 K values so standard_num_K = 201*10*2 = 
% 4020 here.
% K_values_path: The file path of K values. There are two paths:
% '../K_values/2DCombinedPolarity' contains K values from the 2D combined
% polarity circuit model simulations.
% '../K_values/2DCorePolarity' contains K values from the 2D core polariy
% circuit model simulations.

% Outputs:
% unpolarized_regime: index of the unpolarized regime.
% transient_polarity_regime: index of the transient polarity regime.
% polarized_regime: index of the polarized regime.
% simulated_K_diff: Difference between K>=1.5 and K<1.5 estimated from a 
% sigmoidal function.
% K_diff: Difference between K>=1.5 and K<1.5 calculated from particle-based 
% simulations. It is used as data points to fit the sigmoidal function for 
% estimating the relation between difference in K and number of Bem1-GEF.
% n_BemGEF: total number of Bem1-GEF in the particle-based simulations.

function [unpolarized_regime, transient_polarity_regime, polarized_regime, ...
    simulated_K_diff, K_diff, n_BemGEF] = identify_regimes(n_Cdc42,BemGEF_list,...
    seeds,standard_num_K,K_values_path)
% load Ripley's K function values, number of Cdc42 and number of Bem1-GEF in 
% each particle-based simulation. Each ".mat" file was titled with the particular  
% number of Cdc42. Each file contains K values at different number of
% Bem1-GEF.
load(sprintf('%s/K_%g.mat',K_values_path,n_Cdc42));

curr_K1 = cell(1,numel(n_BemGEF),seeds);
curr_K2 = cell(1,numel(n_BemGEF),seeds);
K = cell(numel(n_BemGEF));
N1 = nan(numel(n_BemGEF));
N2 = nan(numel(n_BemGEF));
K_diff = nan(1,numel(n_BemGEF));

% A regime is considered to be transient polarity regime if 
% lower_threshold <= K_diff <= upper_threshold.
% The thresholds are chosen to ensure the portion of one state 
% (either polarized or unpolarized) is at least 15% and the other state is 
% at most 85%. 
upper_threshold = 2814;
lower_threshold = -2814;

for k = 1:numel(n_BemGEF)
    for j = 1:seeds
        % Extract the K values from 2000 seconds to 4000 seconds
        % K1 is a list of K values collected from simulations with
        % an initial condition of uniformly distributed cytosolic Cdc42-GDP.
        % K2 is a list of K values collected from simulations with
        % an initial condition of a pre-polarized Cdc42-GTP cluster.
        curr_K1{k,j} = K1{1,k,j}(201:end);
        curr_K2{k,j} = K2{1,k,j}(201:end);
    end
    % Combine K values from simulations of the two sets of initial conditions.
    K{k} = [curr_K1{k,1:seeds}, curr_K2{k,1:seeds}];
    % Check if the total number of K = standard_num_K = 4020.
    num_K = sum(sum(~isnan(K{k})));
    if num_K >= standard_num_K 
        % Frequency of low K indicating no polarization.
        N1(k) = sum(K{k}<1.5); 
        % Frequency of high K indicating polarization.
        N2(k) = sum(K{k}>=1.5);
        % Difference between frequency of high K minus frequency of low K.
        K_diff(k) = N2(k)-N1(k); 
    else
        K_diff(k) = nan;
    end
end
% Data cleaning.
n_BemGEF(isnan(K_diff)) = []; 
K_diff(isnan(K_diff)) = []; 
% Add the point with no BemGEF in the system.
n_BemGEF = [0,n_BemGEF]; 
% With no BemGEF in the system, all K = 0, so K_diff = 
% -1 * 201(number of data points in each simulation) * 10 (number of  
% realizations for a particular number of Bem1-GEF) * 2 (simulations are 
% performed with 2 different initial conditions) = -4020.
K_diff = [-4020,K_diff]; 

% Empirically estimate the guess value of c for the sigmoidal function: 
% use the K_diff value closest to zero as the guess value. 
[~,guess_index] = min(abs(K_diff));
c_guess_value = n_BemGEF(guess_index);

% Use the "Curve Fitting" Toolbox
[param, ~] = fit_sigmoidal_curve(n_BemGEF,K_diff,c_guess_value);
% Generate simulated difference in frequency of K for a wider range of
% Bem1-GEF
simulated_K_diff = param.a./(1+exp(-param.b*(BemGEF_list-param.c)))-param.a/2;

% Identify the indices of the unpolarized regime
unpolarized_regime = find(simulated_K_diff<lower_threshold);
% Identify the indices of the transient polarity regime
transient_polarity_regime = find(simulated_K_diff>=lower_threshold ...
    & simulated_K_diff<=upper_threshold);
% Identify the indices of the polarized regime
polarized_regime = find(simulated_K_diff>upper_threshold);
end
    