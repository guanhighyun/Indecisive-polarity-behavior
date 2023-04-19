% Here we plotted time evolution of K values of the simulations with 
% 3000 Cdc42 and 170 Bem1-GEF. The initial conditions are uniformly 
% distributed cytosolic molecules.

load('FigureData/FigureS8.mat')
seeds = 10;
% Color map for the plots.
cmap = cool(seeds);
% Time values. Convert seconds to minutes.
time = (0:10:3000)/60;
figure('units','pixels','position',[300 300 1500 300]); 
tiledlayout(1,6,'tilespacing','loose')
nexttile; hold on
for j = 1:seeds
    % Plot time series of K
    plot(time,K(j,:),'color',cmap(j, :),'linewidth',1)
end
ylim([0,20])
xlim([0,50])
xlabel('Time (min)')
ylabel('K')
axis square
set(gca,'fontsize',25)
set(gca,'linewidth',3)
set(gca,'TickDir','out');
xticks([1,13,24,37,49])
set(gca,'xticklabel',[])
text(55,0,'50','fontsize',25)
title('Ripley''s K-function values','fontsize',25,'position',[35,75])
set(gca,'TickLength',[0.08, 0.01])

% Mark one line of K in black and plot its snapshots of Cdc42-GTP
% distribution at different time points. 
plot(time,K(1,:),'color','k','linewidth',4)
r = 2.5; % sphere radius
nexttile
plot_sphere(x_1,y_1,z_1,r,90,0);
text(0,-0.5,-3.5,'1 min','fontsize',25)
axis square;
set(gca,'linewidth',3)

nexttile
plot_sphere(x_2,y_2,z_2,r,90,0);
axis square;
text(0,-0.5,-3.5,'13 min','fontsize',25)
set(gca,'linewidth',3)

nexttile
plot_sphere(x_3,y_3,z_3,r,90,0);
axis square;
text(0,-0.5,-3.5,'24 min','fontsize',25)
set(gca,'linewidth',3)

nexttile
plot_sphere(x_4,y_4,z_4,r,90,0);
axis square;
text(0,-0.5,-3.5,'37 min','fontsize',25)
set(gca,'linewidth',3)

nexttile
plot_sphere(x_5,y_5,z_5,r,90,0);
axis square;
text(0,-0.5,-3.5,'49 min','fontsize',25)
set(gca,'linewidth',3)

function plot_sphere(X,Y,Z,r,degree1,degree2)
[x,y,z]=sphere(100);
x=x*r; y=y*r; z=z*r;
surf(x,y,z,'FaceColor',[0.95,0.95,0.95],'EdgeColor','none'); 
axis off; axis equal; grid off; box off; 
h = light;
lighting gouraud
h.Position = [0.5 0 0];
camlight; hold on; 
plot3(X,Y,Z,'b.','markersize',5)
set(gca,'xticklabel',[],'yticklabel',[],'zticklabel',[]);
view(degree1,degree2);
end