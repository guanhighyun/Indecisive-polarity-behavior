clear; load('../FigureData/FigureS6_1.mat');
[freq_0_core,freq_1_core] = calculate_dwell_time(n_cluster);
load('../FigureData/FigureS6_2.mat');
[freq_0_combined,freq_1_combined] = calculate_dwell_time(n_cluster);
plot_frequency(freq_0_core,freq_0_combined);
plot_frequency(freq_1_core,freq_1_combined);


function plot_frequency(freq_core,freq_combined)
figure('position',[300 300 900 600])
newcolors = [0   0.9 1
             0.8 1.0 0];
colororder(newcolors);
edges = [0:10:100];
h0 = histcounts(freq_core,edges,'Normalization', 'probability');
h1 = histcounts(freq_combined,edges,'Normalization', 'probability');
h0 = [h0, sum(freq_core >= 100)/numel(freq_core)];
h1 = [h1, sum(freq_combined >= 100)/numel(freq_combined)]; hold on;
bar(edges,[h0; h1]',1,'linewidth',2);
xticks(edges);
xticklabels({0:10:90,"100+"});
set(gca,'linewidth',3); box off; set(gca,'tickdir','out');
xlim([0,max(edges)+10]);
ylim([0,0.9]);
set(gca,'fontsize',25);
end

function [freq_0,freq_1]=calculate_dwell_time(n_cluster)
n_cluster_original = [n_cluster,nan(height(n_cluster),1)];
n_cluster = reshape(n_cluster_original',[numel(n_cluster_original),1]);
[frequency,count] = runlength(n_cluster,numel(n_cluster));
frequency = (frequency-1)*10;
freq_0 = frequency(count==0);
freq_1 = frequency(count==1);
end

