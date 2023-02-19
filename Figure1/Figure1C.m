% Here we plotted K values of the simulations with 3000 Cdc42 and 102 Bem1-GEF
% whose initial condition is uniformly distributed molecules.
load('FigureData/Figure1C.mat')
seeds = 10;
% Color map for the plots.
cmap = cool(seeds);
% Time in the unit of minutes.
time = (0:10:4000)/60;
figure('units','pixels','position',[300 300 900 300]); 
tiledlayout(1,4,'tilespacing','compact')
nexttile; hold on
for j = 1:seeds
    % Plot time series of K.
    plot(time,K(j,:),'color',cmap(j, :),'linewidth',1)
end
ylim([0,4])
xlim([0,Inf])
xlabel('Time (min)')
ylabel('K')
axis square
set(gca,'fontsize',25)

% Mark one line of K in black and plot its snapshots of Cdc42-GTP
% at different time points. 
plot(time,K(1,:),'color','k','linewidth',4)
load('Coordinates/Figure1C_coordinates.mat')
L = 8.8623; % domain length.
nexttile
plot(x_1,y_1,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('1 min','fontsize',25)

nexttile
plot(x_2,y_2,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('36 min','fontsize',25)

nexttile
plot(x_3,y_3,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('65 min','fontsize',25)
