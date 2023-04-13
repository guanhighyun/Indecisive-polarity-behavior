% Simulations were performed with 3000 Cdc42, 170 Bem1-GEF, 30 Far1-GEF,
% and 2500 receptors, and the initial conditions were uniformly distributed 
% molecules. Uniform pheromone was applied to the domain from 0 to 300 
% seconds to generate relocating polarity sites. A pheromone gradient (1-6 nM) 
% was applied to the domain after 300 seconds for stabilization of
% the polarity sites.

% Plot Ripley's K function values.
load('FigureData/Figure5D.mat')
seeds = 10;
% Color map for the plots.
cmap = cool(seeds);
% Time in the unit of minutes.
time = (0:10:8000)/60;
figure('units','pixels','position',[300 300 800 700]); 
for j = 1:seeds
    subplot(6,6,19:36); hold on
    % Plot time series of K
    plot(time,K(j,:),'color',cmap(j, :),'linewidth',1)
end
% Mark the time point where uniform pheromone was switched to a pheromone
% gradient.
patch([0,0,300/60,300/60],[0,4,4,0],'r',...
    'edgecolor','r','facealpha',0.15,'edgealpha',0.15)
plot([300/60,300/60],[0,4],'k-','linewidth',4)
patch([8000/60,8000/60,300/60,300/60],[0,4,4,0],'c',...
    'edgecolor','c','facealpha',0.15,'edgealpha',0.15)
ylim([0,4])
xlim([0,90])
xlabel('Time (min)')
ylabel('K')
set(gca,'fontsize',25)
set(gca,'linewidth',3)
text(0,4.3,'Uniform (1 nM)','fontsize',25,'color','#A52A2A')
text(29,4.3,'Gradient (1-6 nM)','fontsize',25,'color','#0072BD')
title('Ripley''s K function values','fontsize',25,'position',[45,4.7])

% Mark one line of K in black and  plotted its snapshots of Cdc42-GTP
% at different time points. 
plot(time,K(1,:),'color','k','linewidth',4)
load('Coordinates/Figure5D_coordinates.mat')
L = 8.8623; % domain length
subplot(6,6,[1,2,7,8])
plot(x_1,y_1,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('1 min','fontsize',25)
set(gca,'linewidth',3)

subplot(6,6,[3,4,9,10])
plot(x_2,y_2,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('40 min','fontsize',25)
set(gca,'linewidth',3)

subplot(6,6,[5,6,11,12])
plot(x_3,y_3,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('60 min','fontsize',25)
set(gca,'linewidth',3)
