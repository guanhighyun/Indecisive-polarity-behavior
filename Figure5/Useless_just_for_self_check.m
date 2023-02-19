figure('position',[300 300 400 400])
data = [distance(:,1,2),distance(:,2,2),distance(:,3,2)];
concentration = {'2 - 6.5','2 - 4','2 - 3'};
index = repelem(concentration,1,numel(random_seeds));
index = categorical(index);
data = reshape(data,1,numel(data));
swarmchart(index,data,60,'k','filled'); hold on;
boxchart(index,data,'boxfacecolor','b','BoxFaceColorMode','manual',...
'markercolor','none','linewidth',3.5);
set(gca,'fontsize',20)
xlabel('Gradient (nM)')
ylabel('Distance (\mum)')