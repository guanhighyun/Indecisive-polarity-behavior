% Plot the relationship between time till polarization and number of
% fixed Far1-GEF.

load('FigureData/Figure4D.mat'); 

%% Generate the boxchart.
figure('position',[300,300,800,600]);
subplot(12,12,1:108)
% Create a list of number of Far1-GEF clusters for the swarmchart and boxchart.
index = repelem(Far_totalcluster,1,numel(random_seeds));
% Make the list of categorical variables for nicer plots.
index = categorical(index);
% Reshape the data for nicer plots.
data = reshape(time_till_stabilization,1,numel(time_till_stabilization));
% Generate the plot.
swarmchart(index,data/60,50,'k','filled'); hold on;
boxchart(index,data/60,'boxfacecolor','b','BoxFaceColorMode','manual',...
'markercolor','none','linewidth',3.5);
set(gca,'fontsize',25)
text(1.75,-25,'Number of Far1-GEF molecules','fontsize',25)
ylabel('Time to K ≥ 3 (min)')
set(gca,'linewidth',3)

%% Visualize the spatial distribution of 1, 9, 12 and 14 fixed Far1-GEF molecules.
L = 8.8623; % domain length

subplot(12,12,[121,122,133,134])
x = L/2;
y = L/2;
plot(x,y,'r.','markersize',10)
axis([0,L,0,L])
set(gca,'xtick',[]); set(gca,'ytick',[]); axis square;
set(gca,'linewidth',1)

subplot(12,12,[123,124,135,136])
X = L/3:L/3:L-L/3;
Y = L/3:L/3:L-L/3;
[x,y] = meshgrid(X,Y);
plot(x,y,'r.','markersize',10)
axis([0,L,0,L])
set(gca,'xtick',[]); set(gca,'ytick',[]); axis square;
set(gca,'linewidth',1)

subplot(12,12,[125,126,137,138])
X = L/4:L/4:L-L/4;
Y = L/4:L/4:L-L/4;
[x,y] = meshgrid(X,Y);
plot(x,y,'r.','markersize',10)
axis([0,L,0,L])
set(gca,'xtick',[]); set(gca,'ytick',[]); axis square;
set(gca,'linewidth',1)

subplot(12,12,[127,128,139,140])
X = L/4:L/4:L-L/4;
Y = L/5:L/5:L-L/5*2;
[x,y] = meshgrid(X,Y);
plot(x,y,'r.','markersize',10); hold on
x = [L/4, L/4*2];
y = [L/5*4,L/5*4];
plot(x,y,'r.','markersize',10); hold off
axis([0,L,0,L])
set(gca,'xtick',[]); set(gca,'ytick',[]); axis square;
set(gca,'linewidth',1)

subplot(12,12,[129,130,141,142])
X = L/4:L/4:L-L/4;
Y = L/5:L/5:L-L/5;
[x,y] = meshgrid(X,Y);
plot(x,y,'r.','markersize',10)
axis([0,L,0,L])
set(gca,'xtick',[]); set(gca,'ytick',[]); axis square;
set(gca,'linewidth',1)

subplot(12,12,[131,132,143,144])
X = L/5:L/5:L-L/5;
Y = L/5:L/5:L-L/5*2;
[x,y] = meshgrid(X,Y);
plot(x,y,'r.','markersize',10); hold on
x = [L/5];
y = [L/5*4];
plot(x,y,'r.','markersize',10); hold off
axis([0,L,0,L])
set(gca,'xtick',[]); set(gca,'ytick',[]); axis square;
set(gca,'linewidth',1)
