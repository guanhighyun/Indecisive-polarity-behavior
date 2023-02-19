% Simulations were performed with 3000 uniformly distributed Cdc42-GTP, 
% 170 Bem1-GEF and 2500 receptors. Receptor residence time ~= 5.8 min (k = 0.002/s).
% Number of Far1-GEF were varied.

% Here we plotted the relationship between K at the final time point (4000
% seconds) and number of Far1-GEF.
load('FigureData/Figure4C.mat')
figure('position',[300,300,550,400]); hold on;
% Separate K into K>=1.5 and K<1.5.
data1 = K;
data2 = K;
data1(data1<1.5) = nan;
data2(data2>1.5) = nan;
% Data cleaning: eliminate data points where the number of realizations are 
% below 5.
data1 = control_data_quality(data1);
data2 = control_data_quality(data2);
% Generate the plot
shadedErrorBar(n_FarGEF,nanmean(data1),nanstd(data1),...
    'LineProps',{'Marker','.','Markersize',30,'Linewidth',3,'Color','k'},...
    'transparent',true,'patchSaturation',0.1)
shadedErrorBar(n_FarGEF,nanmean(data2),nanstd(data2),...
    'LineProps',{'Marker','.','Markersize',30,'Linewidth',3,'Color','k'},...
    'transparent',true,'patchSaturation',0.1)
ylabel('K at 4000 seconds');
xlabel('Number of FarGEF');
xlim([0 55]);
ylim([0 4]);
set(gca,'FontSize',25);

% Plot the start and end of the bifurcation
plot([22,22],[0.4068,3.0224],'LineWidth',2,'LineStyle','--','Color',[0 0 0]);
plot([33,33],[0.4703,2.7373],'LineWidth',2,'LineStyle','--','Color',[0 0 0]);

% Mark a point where all K>1.5 and show a snapshot of the Cdc42-GTP
% distribution at 4000 seconds.
plot(n_FarGEF(5),nanmean(data1(:,5)),'b.','Markersize',30);
% Mark a point where all K<=1.5 and show a snapshot of the Cdc42-GTP
% distribution at 4000 seconds.
plot(n_FarGEF(16),nanmean(data2(:,16)),'b.','Markersize',30);

load('Coordinates/Figure4C_coordinates.mat')
L = 8.8623; % domain length
figure; plot(x_1,y_1,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
figure; plot(x_2,y_2,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;

function data = control_data_quality(data)
for i = 1:size(data,2)
    if sum(~isnan(data(:,i))) < 5
        data(:,i) = nan;
    end
end
end
