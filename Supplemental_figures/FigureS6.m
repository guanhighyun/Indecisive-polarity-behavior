% We plotted K values of the simulations with 3000 Cdc42, 170 Bem1-GEF, 30
% Far1-GEF, 2500 receptors, and saturated pheromone concentration.
% The initial condition was uniformly distributed molecules.
load('FigureData/FigureS6.mat')
seeds = 10;
% Color map for the plots
cmap = cool(seeds);
% Time in the unit of minutes
time = (0:10:4000)/60;
figure('units','pixels','position',[300 300 1200 300]); 
for j = 1:seeds
    subplot(1,4,1); hold on
    % Plot time series of K
    plot(time,K(j,:),'color',cmap(j, :),'linewidth',1)
end
ylim([0,4])
xlim([0,Inf])
xlabel('Time (min)')
ylabel('K')
axis square
set(gca,'fontsize',25)
set(gca,'linewidth',3)
set(gca,'TickDir','out');
xticks([6,32,64])
set(gca,'xticklabel',[])
text(68,0,'66','fontsize',25)
title('Ripley''s K function values','fontsize',25,'position',[35,4.4])
set(gca,'TickLength',[0.08, 0.01])


% Mark one plot in black and plot the snapshots of Cdc42-GTP
plot(time,K(1,:),'color','k','linewidth',4)
L = 8.8623; % domain length
subplot(1,4,2)
plot(x_1,y_1,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('6 min','fontsize',25)
set(gca,'linewidth',3)

subplot(1,4,3)
plot(x_2,y_2,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('32 min','fontsize',25)
set(gca,'linewidth',3)

subplot(1,4,4)
plot(x_3,y_3,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('64 min','fontsize',25)
set(gca,'linewidth',3)
