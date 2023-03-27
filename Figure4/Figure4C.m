% Here we plotted the relationship between K at the final time point (4000
% seconds) and number of Far1-GEF.
load('FigureData/Figure4C.mat')
figure('position',[300,300,550,600]); hold on;
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
ylabel('K at the final time point');
xlabel('Number of Far1-GEF molecules');
xlim([0 55]);
ylim([0 6]);
set(gca,'FontSize',25);
set(gca,'linewidth',3)

% Plot the start and end of the bifurcation.
plot([22,22],[0.4068,3.0224],'LineWidth',2,'LineStyle','--','Color',[0 0 0]);
plot([33,33],[0.4703,2.7373],'LineWidth',2,'LineStyle','--','Color',[0 0 0]);

% Mark a point where all K>=1.5 and show a snapshot of the Cdc42-GTP
% distribution at 4000 seconds.
plot(n_FarGEF(5),nanmean(data1(:,5)),'b.','Markersize',30);
% Mark a point where all K<1.5 and show a snapshot of the Cdc42-GTP
% distribution at 4000 seconds.
plot(n_FarGEF(16),nanmean(data2(:,16)),'b.','Markersize',30);

load('Coordinates/Figure4C_coordinates.mat')
L = 8.8623; % domain length
figure('position',[300,300,300,300]); plot(x_1,y_1,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
set(gca,'linewidth',3)
figure('position',[300,300,300,300]); plot(x_2,y_2,'b.')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
set(gca,'linewidth',3)

function data = control_data_quality(data)
for i = 1:size(data,2)
    if sum(~isnan(data(:,i))) < 5
        data(:,i) = nan;
    end
end
end
