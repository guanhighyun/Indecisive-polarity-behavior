% Here we generated the bifurcation diagram with 1800 - 3500 Cdc42 
% and 0 - 1000 Bem1-GEF.
n_Cdc42_list = [1800,2000,2200,2500,2800,3000,3200,3500]; 
BemGEF_list = 0:0.5:1000; 
% Number of realizations in each regime.
seeds = 10; 
% Ripley's K values are calculated from the coordinates of Cdc42-GTP 
% collected every 10 seconds from 2000 seconds to 4000 seconds of each 
% simulation, so that produced 201 K values.
standard_num_K = 201*2*seeds; 
% The file path of stored K values.
K_file_path = '../K_values/2DCombinedPolarity';

figure; hold on
for i = 1:numel(n_Cdc42_list)
    n_Cdc42 = n_Cdc42_list(i);
    % Identify the indices of the three polarity regimes. 
    % See identify_regimes.m.
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
xlabel('Number of Bem1-GEF')
ylabel('Number of Cdc42')
set(gca,'fontsize',10)
xlim([0,550])
ylim([1800,3500])
set(gcf,'Position',[300 300 600,350]); 
set(gca,'fontsize',25)
