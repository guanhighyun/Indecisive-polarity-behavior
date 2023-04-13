% Detect clusters by the algorithm based on Voronoi tessellation ("pipeline.m").
% Plot the number of clusters across time (n = 10).

% Figure S4A
load('../FigureData/FigureS6A.mat') % Core polarity circuit
time = (0:10:4000)/60; % Convert seconds to minutes
figure('position',[300 300 1000 300]);
subplot(1,2,1); hold on;
for i = 1:height(n_cluster)
    p = plot(time,n_cluster(i,:),'linewidth',0.5);
    p.Color = [p.Color 0.2];
end
plot(time,n_cluster(1,:),'color','k','linewidth',2)
xlabel('Time (min)'); 
ylabel('Number of clusters')
set(gca,'fontsize',20)
xlim([0,time(end)])
ylim([0,3])

% Figure S4B
load('../FigureData/FigureS6B.mat') % Combined polarity circuit
subplot(1,2,2); hold on;
for i = 1:height(n_cluster)
    p = plot(time,n_cluster(i,:),'linewidth',0.5);
    p.Color = [p.Color 0.2];
end
plot(time,n_cluster(2,:),'color','k','linewidth',2)
xlabel('Time (min)'); 
ylabel('Number of clusters')
set(gca,'fontsize',20)
xlim([0,time(end)])
ylim([0,3])