% Here we plotted the relationship between K at the final time point (4000
% seconds) and receptor residence time.
load('FigureData/Figure4B.mat')
figure('position',[300,300,800,600]); hold on;
% Separate K into K>=1.5 and K<1.5.
data1 = K;
data2 = K;
data1(data1<1.5) = nan;
data2(data2>1.5) = nan;
% Data cleaning: eliminate data points where the number of realizations are 
% below 5.
data1 = control_data_quality(data1);
data2 = control_data_quality(data2);
% Generate the plot.
shadedErrorBar(residence_time,nanmean(data1),nanstd(data1),...
    'LineProps',{'Marker','.','Markersize',30,'Linewidth',3,'Color','k'},...
    'transparent',true,'patchSaturation',0.1)
shadedErrorBar(residence_time,nanmean(data2),nanstd(data2),...
    'LineProps',{'Marker','.','Markersize',30,'Linewidth',3,'Color','k'},...
    'transparent',true,'patchSaturation',0.1)
ylabel('K at the final time point');
xlabel('Receptor residence time (min)');
xlim([0 14]);
ylim([0 6]);
set(gca,'FontSize',25);
set(gca,'linewidth',3);

% Mark the start and end of the bifurcation
plot([5.0494,5.0494],[0.7804,3.2052],'LineWidth',2,'LineStyle','--',...
    'Color',[0 0 0]);
plot([9.3775,9.3775],[0.4770,2.9020],'LineWidth',2,'LineStyle','--',...
    'Color',[0 0 0]);

% Mark a point where all K>=1.5 and show a snapshot of the Cdc42-GTP
% distribution at 4000 seconds.
plot(residence_time(18),nanmean(data1(:,18)),'b.','Markersize',30);
% Mark a point where all K<1.5 and show a snapshot of the Cdc42-GTP
% distribution at 4000 seconds.
plot(residence_time(6),nanmean(data2(:,6)),'b.','Markersize',30);
load('Coordinates/Figure4B_coordinates.mat')
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
