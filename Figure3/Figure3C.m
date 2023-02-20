% Here we plotted time evolution of K values of the simulations with 
% 3000 Cdc42 and 170 Bem1-GEF. The initial conditions are uniformly 
% distributed cytosolic molecules.

load('FigureData/Figure3C.mat')
seeds = 10;
% Color map for the plots.
cmap = cool(seeds);
% Time values. Convert seconds to minutes.
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

% Mark one line of K in black and plot its snapshots of Cdc42-GTP
% distribution at different time points. 
plot(time,K(5,:),'color','k','linewidth',4)
load('Coordinates/Figure3C_coordinates.mat')
L = 8.8623; % domain length
subplot(1,4,2)
plot(x_1,y_1,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('2 min','fontsize',25)

subplot(1,4,3)
plot(x_2,y_2,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('17 min','fontsize',25)

subplot(1,4,4)
plot(x_3,y_3,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('66 min','fontsize',25)
