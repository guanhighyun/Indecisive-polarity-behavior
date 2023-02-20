% We plotted K values of the simulations with 3000 Cdc42 and 170 Bem1-GEF.
% The initial condition is pre-polarized active receptors 
% and all other molecules are uniformly distributed.

load('FigureData/Figure3E.mat')
seeds = 10;
% Color map for the plots.
cmap = cool(seeds);
% Time in the unit of minutes.
time = (0:10:4000)/60;
figure('units','pixels','position',[300 300 900 300]); 
for j = 1:seeds
    subplot(1,3,1); hold on
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
load('Coordinates/Figure3E_coordinates.mat')
L = 8.8623; % domain length
subplot(1,3,2)
plot(x_1,y_1,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('0 min','fontsize',25)

subplot(1,3,3)
plot(x_2,y_2,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('67 min','fontsize',25)
