% Here we plotted Ripley's K function values calculated from the simulations 
% with 3000 initially uniformly distributed Cdc42 and 70 Bem1-GEF.
load('FigureData/FigureS2A.mat')
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

% Mark one line of K in black and plot its snapshots of Cdc42-GTP
plot(time,K(1,:),'color','k','linewidth',4)
L = 8.8623; % domain length
subplot(2,4,2)
plot(x_1,y_1,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('1 min','fontsize',25)

subplot(2,4,3)
plot(x_2,y_2,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('36 min','fontsize',25)

subplot(2,4,4)
plot(x_3,y_3,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('65 min','fontsize',25)

% Here we plotted Ripley's K function values calculated from the simulations 
% with 3000 initially uniformly distributed Cdc42 and 120 Bem1-GEF.
load('FigureData/FigureS2B.mat')
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

% Mark one line of K in black and plot its snapshots of Cdc42-GTP
plot(time,K(9,:),'color','k','linewidth',4)
L = 8.8623; % domain length
subplot(2,4,6)
plot(x_1,y_1,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('1 min','fontsize',25)

subplot(2,4,7)
plot(x_2,y_2,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('36 min','fontsize',25)

subplot(2,4,8)
plot(x_3,y_3,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('65 min','fontsize',25)
