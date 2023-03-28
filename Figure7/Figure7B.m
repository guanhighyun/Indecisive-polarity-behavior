load('FigureData/Figure7B.mat')
figure('Position',[300 300 600 500])
boxchart([repelem(1,10),repelem(2,10),repelem(3,10)],reshape(time_to_stabilization,[1,numel(time_to_stabilization)]),'boxfacecolor','b','BoxFaceColorMode','manual',...
'markercolor','none','linewidth',3.5);
hold on; swarmchart(repelem(1,10),time_to_stabilization(:,1),100,'k','filled','linewidth',1)
swarmchart(repelem(2,10),time_to_stabilization(:,2),100,'k','filled','linewidth',1)
swarmchart(repelem(3,10),time_to_stabilization(:,3),100,'k','filled','linewidth',1)
xticks([1,2,3])
xticklabels({'1-5','1-6','0-1'})
ylabel('Time to stabilization (min)')
[~,p] = kstest2(time_to_stabilization(:,1),time_to_stabilization(:,2));
text(1.2,100,sprintf('p = %.3f',p),'fontsize',20)
plot([1,2],[95,95],'k-','linewidth',0.5)
[~,p] = kstest2(time_to_stabilization(:,2),time_to_stabilization(:,3));
plot([2,3],[82,82],'k-','linewidth',0.5)
text(2,89,sprintf('p = %.2e',p),'fontsize',20)
ylim([0 110])
xlim([0.5,3.5])
xlabel('Pheromone gradient (nM)')
ylabel('Time to K ≥ 50 (min)')
set(gca,'fontsize',25)
