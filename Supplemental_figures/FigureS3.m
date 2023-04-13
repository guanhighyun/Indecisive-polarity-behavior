% Here we plotted Ripley's K function values calculated from the simulations 
% with 3000 initially uniformly distributed cytosolic Cdc42-GDP, 80 Bem1-GEF, 30
% Far1-GEF, and 2500 receptors.
load('FigureData/FigureS3A.mat')
seeds = 10;
% Color map for the plots
cmap = cool(seeds);
% Time in the unit of minutes
time = (0:10:4000)/60;
figure('units','pixels','position',[300 300 1200 600]); 
for j = 1:seeds
    subplot(2,4,1); hold on
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
xticks([17,50,66])
set(gca,'xticklabel',[])
text(68,0,'66','fontsize',25)
title('Ripley''s K-function values','fontsize',25,'position',[35,4.4])
set(gca,'TickLength',[0.08, 0.01])

% Mark one line of K in black and plot its snapshots of Cdc42-GTP
plot(time,K(5,:),'color','k','linewidth',4)
L = 8.8623; % domain length
subplot(2,4,2)
plot(x_1,y_1,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('17 min','fontsize',25)
set(gca,'linewidth',3)

subplot(2,4,3)
plot(x_2,y_2,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('50 min','fontsize',25)
set(gca,'linewidth',3)

subplot(2,4,4)
plot(x_3,y_3,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('66 min','fontsize',25)
set(gca,'linewidth',3)

% Here we plotted Ripley's K function values calculated from the simulations 
% with 3000 initially uniformly distributed cytosolic Cdc42-GDP, 280 Bem1-GEF, 30
% Far1-GEF, and 2500 receptors.
load('FigureData/FigureS3B.mat')
seeds = 10;
% Color map for the plots
cmap = cool(seeds);
% Time in the unit of minutes
time = (0:10:4000)/60; 
for j = 1:seeds
    subplot(2,4,5); hold on
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
xticks([17,50,66])
set(gca,'xticklabel',[])
text(68,0,'66','fontsize',25)
set(gca,'TickLength',[0.08, 0.01])

% Mark one line of K in black and plot its snapshots of Cdc42-GTP
plot(time,K(5,:),'color','k','linewidth',4)
L = 8.8623; % domain length
subplot(2,4,6)
plot(x_1,y_1,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('17 min','fontsize',25)
set(gca,'linewidth',3)

subplot(2,4,7)
plot(x_2,y_2,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('50 min','fontsize',25)
set(gca,'linewidth',3)

subplot(2,4,8)
plot(x_3,y_3,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('66 min','fontsize',25)
set(gca,'linewidth',3)
