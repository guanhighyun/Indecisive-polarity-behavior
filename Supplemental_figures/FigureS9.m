clear; 
% Here we generated the sigmoidal curves with 1800 - 3500 Cdc42 
% and 0 - 1000 Bem1-GEF
n_Cdc42_list = [1800,2000,2200,2500,2800,3000,3200,3500]; BemGEF_list = 0:0.1:1000; 
% Number of realizations in each regime
seeds = 10; 
% Ripley's K function values are calculated from the coordinates of Cdc42-GTP 
% collected every 10 seconds from 2000 seconds to 4000 seconds of each 
% simulation, so each simulation produced 201 K values.
standard_num_K = 201*2*seeds; 

% The file path of stored K values.
K_file_path = '../K_values/2DCombinedPolarity';

% Figure S8A
figure('position',[300,300,650,800]);
for i = 1:numel(n_Cdc42_list)
    ax(i) = nexttile; hold on
    n_Cdc42 = n_Cdc42_list(i);
    plot_sigmoidal_curve(n_Cdc42,BemGEF_list,seeds,standard_num_K,K_file_path)
    title(sprintf('%g',n_Cdc42),'fontsize',25)
end
text(-550,-10000,'Number of Bem1-GEF','fontsize',25)
text(-1170,16000,'Difference','fontsize',25,'rotation',90)
set(ax([1,3,5,7]),'ytick',[-5000,5000],'fontsize',20);
set(ax([7,8]),'xtick',[0,650],'fontsize',20);

% Figure S8B
figure('position',[300 300 600 300]); 
subplot(1,2,1); hold on; 
n_Cdc42 = 3500;
plot_sigmoidal_curve(n_Cdc42,BemGEF_list,seeds,standard_num_K,K_file_path)
plot(135,-2754,'marker','pentagram','markersize',30,'markerfacecolor','y',...
'markeredgecolor','k','linewidth',3);
ylabel('Difference')
xlabel('Number of Bem1-GEF')
xlim([0,650]);
set(gca,'xtick',[0,650]);

subplot(1,2,2); hold on
load([K_file_path '/K_3500.mat'])
current_n_BemGEF = n_BemGEF(6);
current_K1 = K1(1,6,:);
current_K1 = cellfun(@extract_K,current_K1,'UniformOutput',false);
current_K2 = K2(1,6,:);
current_K2 = cellfun(@extract_K,current_K2,'UniformOutput',false);
current_K = cell2mat([current_K1(:), current_K2(:)]);
histogram(current_K(:),'binwidth',0.2,'normalization','pdf','facecolor',...
'#4DBEEE','edgecolor','#4DBEEE')
% Knernel density estimation for K.
[density,x] = ksdensity(current_K(:)); 
% Plot the estimated density.
plot(x, density, 'k-', 'linewidth',3); 
ylabel('Density'); xlabel('K'); hold off;
set(findall(gcf,'-property','FontSize'),'FontSize',25)

% Figure S8C
figure('position',[300 300 600 300]); 
subplot(1,2,1); hold on; 
plot_sigmoidal_curve(n_Cdc42,BemGEF_list,seeds,standard_num_K,K_file_path)
plot(165,2458,'marker','pentagram','markersize',30,'markerfacecolor','y',...
'markeredgecolor','k','linewidth',3);
ylabel('Difference')
xlabel('Number of Bem1-GEF')
xlim([0,650]);
set(gca,'xtick',[0,650]);

subplot(1,2,2); hold on
current_n_BemGEF = n_BemGEF(12);
current_K1 = K1(1,12,:);
current_K1 = cellfun(@extract_K,current_K1,'UniformOutput',false);
current_K2 = K2(1,12,:);
current_K2 = cellfun(@extract_K,current_K2,'UniformOutput',false);
current_K = cell2mat([current_K1(:), current_K2(:)]);
histogram(current_K(:),'binwidth',0.2,'normalization','pdf','facecolor',...
'#4DBEEE','edgecolor','#4DBEEE')
% Knernel density estimation for K.
[density,x] = ksdensity(current_K(:)); 
% Plot the estimated density.
plot(x, density, 'k-', 'linewidth', 3); 
ylabel('Density'); xlabel('K'); hold off;
set(findall(gcf,'-property','FontSize'),'FontSize',25)

function plot_sigmoidal_curve(n_Cdc42,BemGEF_list,seeds,standard_num_K,K_file_path)
% Identify the indices of the three regimes
[unpolarized_regime, transient_polarity_regime, polarized_regime, simulated_K_diff, K_diff, n_BemGEF] = identify_regimes(n_Cdc42,BemGEF_list,seeds,standard_num_K,K_file_path);
% Plot the sigmoidal curve. Colors marked the three different regimes.
plot(BemGEF_list(unpolarized_regime),simulated_K_diff(unpolarized_regime),'g','linewidth',8);
plot(BemGEF_list(polarized_regime),simulated_K_diff(polarized_regime),'r','linewidth',8);
plot(BemGEF_list(transient_polarity_regime),simulated_K_diff(transient_polarity_regime),'b','linewidth',8);
% Plot the original data generated from particle-based simulations. 
scatter(n_BemGEF,K_diff,55,'markerfacecolor',[1 1 1],'markeredgecolor','k','markerfacealpha',0.8);
xlim([0,650])
ylim([-5000,5000])
set(gca,'xtick',[]);
set(gca,'ytick',[]);
end

function K = extract_K(K)
K = K(201:end);
end