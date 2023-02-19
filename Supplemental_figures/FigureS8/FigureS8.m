clear; 
% Here we generated the sigmoidal curves with 2000 - 5000 Cdc42 
% and 0 - 1000 Bem1-GEF
n_Cdc42_list = [1800,2000,2200,2500,2800,3000,3200,3500]; BemGEF_list = 0:0.5:1000; 
% Number of realizations in each regime
seeds = 10; 
% Ripley's K function values are calculated from the coordinates of Cdc42-GTP 
% collected every 10 seconds from 1990 seconds to 4000 seconds of each 
% simulation, so each simulation produced 201 K values.
standard_num_K = 201*2*seeds; 

% The file path of stored K values.
K_file_path = '../../K_values/2DCorePolarity';

% Figure S8A
figure('position',[300,300,650,800]);
for i = 1:numel(n_Cdc42_list)
    ax(i) = nexttile; hold on
    n_Cdc42 = n_Cdc42_list(i);
    % Identify the indices of the three regimes
    [unpolarized_regime, transient_polarity_regime, polarized_regime, simulated_K_diff, K_diff, n_BemGEF] = identify_regimes(n_Cdc42,BemGEF_list,seeds,standard_num_K,K_file_path);
    % Plot the sigmoidal curve. Colors marked the three different regimes.
    plot(BemGEF_list(unpolarized_regime),simulated_K_diff(unpolarized_regime),'g','linewidth',8);
    plot(BemGEF_list(polarized_regime),simulated_K_diff(polarized_regime),'r','linewidth',8);
    plot(BemGEF_list(transient_polarity_regime),simulated_K_diff(transient_polarity_regime),'b','linewidth',8);
    % Plot the original data generated from particle-based simulations. 
    scatter(n_BemGEF,K_diff,55,'markerfacecolor',[1 1 1],'markeredgecolor','k','markerfacealpha',0.8);
    xlim([0,320])
    ylim([-5000,5000])
    set(gca,'xtick',[]);
    set(gca,'ytick',[]);
    title(sprintf('%g',n_Cdc42),'fontsize',25)
end
xlabel(ax(8),'Number of Bem1-GEF','fontsize',25)
set(ax([7,8]),'xtick',[0,320],'fontsize',25);
ylabel(ax(1),'Difference','fontsize',25)
set(ax([1,3,5,7]),'ytick',[-5000,5000],'fontsize',25);

