% Simulations were performed with 3000 Cdc42, 170 Bem1-GEF, 30 Far1-GEF,
% and 2500 receptors, and the initial conditions were uniformly distributed 
% molecules. Uniform pheromone was applied to the domain from 0 to 1000 
% seconds to generate relocating polarity sites. A pheromone gradient (0-1 nM) 
% was applied to the domain from 1000 to 4000 seconds for stabilization of
% the polarity sites.

% Plot Ripley's K function values.
load('FigureData/Figure5D.mat')
seeds = 10;
% Color map for the plots.
cmap = cool(seeds);
% Time in the unit of minutes.
time = (0:10:4000)/60;
figure('units','pixels','position',[300 300 500 600]); 
for j = 1:seeds
    subplot(2,2,[3,4]); hold on
    % Plot time series of K
    plot(time,K(j,:),'color',cmap(j, :),'linewidth',1)
end
% Mark the time point where uniform pheromone was switched to a pheromone
% gradient.
patch([0,0,1000/60,1000/60],[0,4,4,0],'r',...
    'edgecolor','r','facealpha',0.15,'edgealpha',0.15)
plot([1000/60,1000/60],[0,4],'k-','linewidth',4)
patch([4000/60,4000/60,1000/60,1000/60],[0,4,4,0],'c',...
    'edgecolor','c','facealpha',0.15,'edgealpha',0.15)
ylim([0,4])
xlim([0,4000/60])
xlabel('Time (min)')
ylabel('K')
set(gca,'fontsize',25)

% Mark one line of K in black and  plotted its snapshots of Cdc42-GTP
% at different time points. 
plot(time,K(1,:),'color','k','linewidth',4)
load('Coordinates/Figure5D_coordinates.mat')
L = 8.8623; % domain length
subplot(2,2,1)
plot(x_1,y_1,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('1 min','fontsize',25)

subplot(2,2,2)
plot(x_2,y_2,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('45 min','fontsize',25)
