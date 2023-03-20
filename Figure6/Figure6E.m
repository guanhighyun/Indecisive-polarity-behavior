% Plot time till stabilization
% with pheromone gradients of different steepness.

load('FigureData/Figure6E.mat')
% Data cleaning for generating the box chart and the swarm chart.
index = repelem(pheromone_gradient,numel(random_seeds),1);
data = reshape(time_till_stabilization2,1,numel(time_till_stabilization));
% Generate the figure.
figure('position',[300 300 700 500])
swarmchart(index,data/60,100,'b','filled'); hold on;
boxchart(index,data/60,'boxfacecolor','b','BoxFaceColorMode','manual',...
'MarkerColor','none','linewidth',3.5);
set(gca,'fontsize',25)
xlabel({'Pheromone gradient (nM)'})
ylabel('Time till stabilization (min)')
ylim([0, 35])