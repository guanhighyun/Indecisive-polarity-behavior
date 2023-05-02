% Plot time to K >= 50 under two types of gradients

load('FigureData/Figure6C.mat')
figure('units','pixels','position',[300 300 1000 600]); 
boxchart([repelem(1,10),repelem(2,10)],reshape(time_to_stabilization,[1,numel(time_to_stabilization)]),'boxfacecolor','b','BoxFaceColorMode','manual',...
'markercolor','none','linewidth',3.5); hold on;
swarmchart(repelem(1,10),time_to_stabilization(:,1),150,'k','filled','linewidth',1)
swarmchart(repelem(2,10),time_to_stabilization(:,2),150,'k','filled','linewidth',1)
xticks([1,2,3])
xticklabels({'1.5-5.8','0-1.2'})
ylabel('Time to stabilization (min)')
% Kolmogorov–Smirnov test
[~,p] = kstest2(time_to_stabilization(:,1),time_to_stabilization(:,2));
text(1.2,100,sprintf('p = %.2e',p),'fontsize',35)
plot([1,2],[95,95],'k-','linewidth',2)
ylim([0 110])
xlabel('Pheromone gradient (nM)')
ylabel('Time to K ≥ 50 (min)')
set(gca,'fontsize',35)
set(gca,'linewidth',3)
yticks([0:40:110])
