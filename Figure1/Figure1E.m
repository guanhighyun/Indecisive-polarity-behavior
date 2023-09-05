% Detect clusters by the algorithm based on Voronoi tessellation.
% Plot the number of clusters across time (n = 10).

load('FigureData/Figure1E.mat') % Core polarity circuit
time = (0:120:4000)/60; % Convert seconds to minutes
figure('position',[300 300 1500 400]);
subplot(1,2,1); hold on;
% seeds = 10; cmap = jet(seeds);
% for i = 1:height(n_cluster_simulation)
%     p = plot(time,n_cluster_simulation(i,:),'color',cmap(i,:),'linewidth',0.5);
% end
plot(time,n_cluster_simulation(9,:),'color','k','linewidth',3)
xlabel('Time (min)'); 
ylabel('Number of clusters')
set(gca,'fontsize',25)
set(gca,'linewidth',1)
set(gca,'TickDir','out');
xlim([0,time(end)])
ylim([0,3])

time = 1:2:61*2;
subplot(1,2,2);
plot(time,n_cluster_experiment,'color','k','linewidth',3)
xlim([0,4000/60]);
set(gca,'fontsize',25)
set(gca,'linewidth',1)
set(gca,'TickDir','out'); box off;
ylim([0,3])
