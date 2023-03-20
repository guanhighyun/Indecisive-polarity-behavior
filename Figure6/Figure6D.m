% Simulations were performed with 3000 Cdc42, 170 Bem1-GEF, 30 Far1-GEF,
% and 2500 receptors, and the initial conditions were uniformly distributed 
% molecules. 1 nM uniform pheromone was applied from 0-5 min; a 0-1 nM 
% pheromone gradient was applied starting from 5 min.

% Plot Ripley's K function values.
load('FigureData/Figure6D.mat')
seeds = 10;
% Color map for the plots.
cmap = cool(seeds);
% Time in the unit of minutes.
time = (0:10:7000)/60;
figure('units','pixels','position',[300 300 500 650]); 
for j = 1:seeds
    subplot(2,2,[3,4]); hold on
    % Plot time series of K
    plot(time,K(j,:),'color',cmap(j, :),'linewidth',1)
end
% Mark the time point where uniform pheromone was switched to a pheromone
% gradient.
patch([0,0,300/60,300/60],[0,4,4,0],'r',...
    'edgecolor','r','facealpha',0.15,'edgealpha',0.15)
plot([300/60,300/60],[0,4],'k-','linewidth',4)
patch([7000/60,7000/60,300/60,300/60],[0,4,4,0],'c',...
    'edgecolor','c','facealpha',0.15,'edgealpha',0.15)
ylim([0,4])
xlim([0,90])
xlabel('Time (min)')
ylabel('K')
set(gca,'fontsize',25)

% Mark one line of K in black and  plotted its snapshots of Cdc42-GTP
% at different time points. 
plot(time,K(2,:),'color','k','linewidth',4)
load('Coordinates/Figure6D_coordinates.mat')
L = 8.8623; % domain length
subplot(2,2,1)
plot(x_1,y_1,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('1 min','fontsize',25)

subplot(2,2,2)
plot(x_2,y_2,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('30 min','fontsize',25)
