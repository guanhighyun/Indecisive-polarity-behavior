% Detect clusters by the algorithm based on Voronoi tessellation ("pipeline.m").
% Plot the number of clusters across time (n = 5).
figure('position',[300,300,400,1500]);
load('../FigureData/FigureS6_1.mat')  % Data from core circuit model
% Sample the data using a time interval of 2 min (120 secs)
n_cluster = n_cluster(:,12:12:end);
time = 0:2:(length(n_cluster)*2-2);
plot_timeseries_count(n_cluster,[1,2,19,22,27],time);

figure('position',[300,300,400,1500]); % Data from combined circuit model
load('../FigureData/FigureS6_2.mat') 
n_cluster = n_cluster(:,1:12:end);
time = 0:2:(length(n_cluster)*2-2);
plot_timeseries_count(n_cluster,[4,10,5,6,9],time);

% Experimental data
figure('position',[300,300,900,1500]);
raw_data = readtable('../FigureData/FigureS6A_Five_experimental_samples.csv');
n_cluster = [raw_data.Cell_1';raw_data.Cell_2';raw_data.Cell_3';...
    raw_data.Cell_4';raw_data.Cell_5'];
time = (raw_data.Timepoint*2);
axes_handles = plot_timeseries_count(n_cluster,1:5,time); 
for i = 1:5
    plot(axes_handles(i,1),[0,0],[0,4],'r-','linewidth',5);
end

function axes_handles = plot_timeseries_count(n_cluster,idx,time)
tiledlayout(5,1,'tilespacing','compact')
for i = idx
    axes_handles(i,1) = nexttile; hold on;
    p = plot(time,n_cluster(i,:),'k','linewidth',3);
    set(gca,'fontsize',3); set(gca,'linewidth',1);
    xticks([]);yticks([]);ylim([0,4]); xlim([time(1),time(end)]);
end
end