load('../K_values/2DCombinedPolarity/K_3000.mat')
idx = find(n_BemGEF==170);
K = cell2mat([K1(1,idx,:),K2(1,idx,:)]);
K = K(:);
K(isnan(K)) = [];
figure('units','pixels','position',[300 300 600 400]); hold on;
histogram(K,'binwidth',0.02,'normalization','pdf','facecolor','b','edgecolor','b')
% Knernel density estimation for K.
[density,x] = ksdensity(K); 
% Plot the estimated density.
plot(x, density, 'k-', 'linewidth', 5); 
xlim([0,Inf])
set(gca,'fontsize',25); set(gca,'linewidth',3); 
title('Distribution of K');
ylabel('Density'); xlabel('K'); 
set(gca,'TickDir','out');