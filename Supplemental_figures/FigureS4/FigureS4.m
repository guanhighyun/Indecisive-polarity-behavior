% Detect clusters by the algorithm based on Voronoi tessellation ("pipeline.m").
% Plot the number of clusters across time (n = 10).

% Figure S4A
load('../FigureData/FigureS4A.mat') % Core polarity circuit
time = (0:10:4000)/60; % Convert seconds to minutes
figure('position',[300 300 1000 400]);
subplot(1,2,1); plot(time,n_cluster,'color',[0 0.4470 0.7410 0.2])
hold on; plot(time,n_cluster(1,:),'color',[0 0.4470 0.7410],'linewidth',2)
xlabel('Time (min)'); 
ylabel('Number of clusters')
set(gca,'fontsize',20)
xlim([0,time(end)])
ylim([0,3])

% Figure S4B
load('../FigureData/FigureS4B.mat') % Combined polarity circuit
subplot(1,2,2); plot(time,n_cluster,'color',[0 0.4470 0.7410 0.2])
hold on; plot(time,n_cluster(2,:),'color',[0 0.4470 0.7410],'linewidth',2)
xlabel('Time (min)'); 
ylabel('Number of clusters')
set(gca,'fontsize',20)
xlim([0,time(end)])
ylim([0,3])