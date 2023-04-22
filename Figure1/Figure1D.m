% Plot snapshots of Cdc42-GTP distributions.

figure('units','pixels','position',[300 300 1200 300]); 
load('Coordinates/Figure1D_coordinates.mat')
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