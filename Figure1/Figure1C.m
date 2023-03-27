% Here we plotted time evolution of K values of the simulations with 
% 3000 Cdc42 and 102 Bem1-GEF. The initial conditions are uniformly 
% distributed molecules.

load('FigureData/Figure1C.mat')
seeds = 10;
% Color map for the plots.
cmap = cool(seeds);
% Time values. Convert seconds to minutes.
time = (0:10:4000)/60;
figure('units','pixels','position',[300 300 1500 300]); 
tiledlayout(1,6,'tilespacing','loose')
nexttile; hold on
for j = 1:seeds
    % Plot time series of K.
    plot(time,K(j,:),'color',cmap(j, :),'linewidth',1)
end
ylim([0,4])
xlim([0,Inf])
xticks([16,35,45,50,60])
text(68,0,'66','fontsize',25)
xticklabels({'','','','',''})
set(gca,'TickDir','out');
xlabel('Time (min)')
ylabel('K')
axis square
set(gca,'fontsize',25)
title('Ripley''s K function values','fontsize',25,'position',[35,4.3])
set(gca,'linewidth',3)
set(gca,'TickLength',[0.05, 0.01])

% Mark one line of K in black and plot its snapshots of Cdc42-GTP
% distribution at different time points. 
plot(time,K(9,:),'color','k','linewidth',4)
% Indicate the time points for the snapshots
%plot([16,35,45,50,60],[K(9,97),K(9,211),K(9,271),K(9,301),K(9,361)],'d',...
    %'markersize',15,'markerfacecolor','w','markeredgecolor','k','linewidth',5)
plot([16,35,45,50,60],[-0.2,-0.2,-0.2,-0.2,-0.2],'k|','linewidth',4)
load('Coordinates/Figure1C_coordinates.mat')
L = 8.8623; % domain length.
nexttile
plot(x_1,y_1,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('16 min','fontsize',25)
set(gca,'linewidth',3)

nexttile
plot(x_2,y_2,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('35 min','fontsize',25)
set(gca,'linewidth',3)

nexttile
plot(x_3,y_3,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('45 min','fontsize',25)
set(gca,'linewidth',3)

nexttile
plot(x_4,y_4,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('50 min','fontsize',25)
set(gca,'linewidth',3)

nexttile
plot(x_5,y_5,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('60 min','fontsize',25)
set(gca,'linewidth',3)