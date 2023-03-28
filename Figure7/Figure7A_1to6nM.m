% Plot the snapshots of 3D Cdc42-GTP distribution at different time points.
% Simulations were performed with 1 nM uniform pheromone for the first 5 min 
% and then switched to a 1-6 nM pheromone gradient

load('FigureData/Figure7A1.mat')
seeds = 10;
% Color map for the plots.
cmap = cool(seeds);
% Time in the unit of minutes.
time = (0:10:8000)/60;
figure('units','pixels','position',[300 300 800 700]); 
for j = 1:seeds
    subplot(10,10,41:100); hold on
    % Plot time series of K
    plot(time,K(j,:),'color',cmap(j, :),'linewidth',1)
end
% Mark the time point where uniform pheromone was switched to a pheromone
% gradient.
patch([0,0,300/60,300/60],[0,70,70,0],'r',...
    'edgecolor','r','facealpha',0.15,'edgealpha',0.15)
plot([300/60,300/60],[0,70],'k-','linewidth',4)
patch([8000/60,8000/60,300/60,300/60],[0,70,70,0],'c',...
    'edgecolor','c','facealpha',0.15,'edgealpha',0.15)
ylim([0,70])
xlim([0,50])
xlabel('Time (min)')
ylabel('K')
set(gca,'fontsize',25)
set(gca,'linewidth',3)
text(0,75,'Uniform (1 nM)','fontsize',25,'color','#A52A2A')
text(34,75,'Gradient (1-6 nM)','fontsize',25,'color','#0072BD')
title('Ripley''s K function values','fontsize',25,'position',[25,80])

% Mark one line of K in black and  plotted its snapshots of Cdc42-GTP
% at different time points. 
plot(time,K(10,:),'color','k','linewidth',4)
L = 8.8623; % domain length
load('Coordinates/Figure7A1_coordinates.mat')
r = 2.5;
subplot(10,10,[1,2,11,12])
plot_sphere(x_1,y_1,z_1,r,90,0);
text(0,-0.5,-3.5,'1 min','fontsize',25)

subplot(10,10,[3,4,13,14])
plot_sphere(x_2,y_2,z_2,r,90,0);
text(0,-0.5,-3.5,'18 min','fontsize',25)

subplot(10,10,[5,6,15,16])
plot_sphere(x_3,y_3,z_3,r,90,0);
text(0,-0.5,-3.5,'35 min','fontsize',25)

subplot(10,10,[7,8,17,18])
plot_sphere(x_4,y_4,z_4,r,90,0);
text(0,-0.5,-3.5,'50 min','fontsize',25)

subplot(10,10,[9,10,19,20])
Gaussian_on_a_sphere(1,5)
title('1-6 nM gradient','position',[0,0,1.3])

colormap(turbo)
set_colorbar
