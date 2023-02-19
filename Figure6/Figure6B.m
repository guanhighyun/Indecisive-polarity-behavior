% Simulations were performed with 3000 Cdc42, 170 Bem1-GEF, 30 Far1-GEF,
% and 2500 receptors, and the initial conditions were uniformly distributed 
% molecules. Uniform pheromone was applied to the domain from 0 to 1000 
% seconds to generate relocating polarity sites. A pheromone gradient was 
% applied to the domain from 1000 to 4000 seconds for stabilization of
% the polarity sites.

% Plot Ripley's K function values.
load('FigureData/Figure6B.mat')
seeds = 10;
% Color map for the plots.
cmap = cool(seeds);
% Time in the unit of minutes.
time = (0:10:8000)/60;
figure('units','pixels','position',[300 300 1200 300]); 
for j = 1:seeds
    subplot(1,4,1); hold on
    % Plot time series of K
    plot(time,K(j,:),'color',cmap(j, :),'linewidth',1)
end
ylim([0,4])
xlim([0,8000/60])
xlabel('Time (min)')
ylabel('K')
set(gca,'fontsize',25)

% Mark one line of K in black and  plotted its snapshots of Cdc42-GTP
% at different time points. 
plot(time,K(10,:),'color','k','linewidth',4)
load('Coordinates/Figure6B_coordinates.mat')
L = 8.8623; % domain length
subplot(1,4,2)
plot(x_1,y_1,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('29 min','fontsize',25)

subplot(1,4,3)
plot(x_2,y_2,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('45 min','fontsize',25)

subplot(1,4,4)
plot(x_3,y_3,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('64 min','fontsize',25)
