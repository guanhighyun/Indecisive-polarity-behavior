% Generate the bifurcation diagram with 1800 - 3500 Cdc42 
% and 0 - 1000 Bem1-GEF.

% Number of Cdc42 and Bem1-GEF
n_Cdc42_list = [1800,2000,2200,2500,2800,3000,3200,3500]; 
BemGEF_list = 0:0.5:1000; 
% Number of realizations in each parameter regime.
seeds = 10; 
% Ripley's K function values are calculated from the coordinates of active 
% Cdc42 collected every 10 seconds from 2000 seconds to 4000 seconds of each 
% realization, so that produced 201 K values. We have 10 realizations for
% each of two initial conditions. The total number of stored K values for a 
% parameter regime is:
standard_num_K = 201*2*seeds; 
% File path of the stored K values.
K_file_path = '../K_values/2DCorePolarity';

figure; hold on
for i = 1:numel(n_Cdc42_list)
    n_Cdc42 = n_Cdc42_list(i);
    % Identify the indices of the three polarity regimes. 
    % See "identify_regimes.m".
    [unpolarized_regime, transient_polarity_regime, polarized_regime, ...
        ~, ~, ~] = identify_regimes(n_Cdc42,BemGEF_list,seeds,...
        standard_num_K,K_file_path);
    num_of_unpolarized_elements = numel(unpolarized_regime);
    num_of_transient_polarity_elements = numel(transient_polarity_regime);
    num_of_polarized_elements = numel(polarized_regime);
    
    % Plot the bifurcation diagram.
    if num_of_unpolarized_elements > 0 
        plot(BemGEF_list(unpolarized_regime),...
            repmat(n_Cdc42,[1,num_of_unpolarized_elements]),'g|',...
            'linewidth',0.1,'markersize',15);
    end
    if num_of_transient_polarity_elements > 0 
        plot(BemGEF_list(transient_polarity_regime),...
            repmat(n_Cdc42,[1,num_of_transient_polarity_elements]),'b|',...
            'linewidth',0.1,'markersize',15);
    end
    if num_of_polarized_elements > 0 
        plot(BemGEF_list(polarized_regime),...
            repmat(n_Cdc42,[1,num_of_polarized_elements]),'r|',...
            'linewidth',0.1,'markersize',15);
    end
end
xlim([-4,550])
ylim([1680,3600])
set(gca,'ytick',[1800,2000,2200,2500,2800,3000,3200,3500],'fontsize',15)
set(gca,'xtick',0:100:550,'fontsize',15)
set(gca,'TickDir','out');
set(gcf,'Position',[300 300 450 250]); 
xlabel('Number of Bem1-GEF','fontsize',20)
ylabel('Number of Cdc42','fontsize',20)
set(gca,'LineWidth',3)
