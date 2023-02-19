load('FigureData/FigureS1.mat')
L = 8.8623; % domain length
r = 0.5:0.1:L/2; % search radius for calculation of the K value. See Methods.
figure('position',[300,300,1200,300]);
tiledlayout(1,6,'Padding', 'none', 'TileSpacing', 'compact');
plot_nexttile(x_1,y_1,r,L)
plot_nexttile(x_2,y_2,r,L)
plot_nexttile(x_3,y_3,r,L)
plot_nexttile(x_4,y_4,r,L)
plot_nexttile(x_5,y_5,r,L)
plot_nexttile(x_6,y_6,r,L)

function plot_nexttile(x,y,r,L)
nexttile;
% Compute the maximum K value of the current molecular distribution
H = max(compute_Kr(x,y,r,L));
plot(x,y,'b.','linewidth',0.1,'markersize',0.01);  
title(sprintf('%.1f',H),'fontsize',25)
axis([-L/2,L/2,-L/2,L/2]); axis square; set(gca,'xtick',[]); set(gca,'ytick',[]); 
end