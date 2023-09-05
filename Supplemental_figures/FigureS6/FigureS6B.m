file = '../FigureData/FigureS6_1.mat';
load(file);
n_cluster = n_cluster(:,12:12:end);
plot_stacked_bargraph(n_cluster);

file = '../FigureData/FigureS6_2.mat';
load(file);
n_cluster = n_cluster(:,12:12:end);
plot_stacked_bargraph(n_cluster);

file = '../FigureData/FigureS6B_Experimental_cluster_count.csv';
raw_data = readtable(file);
raw_data = raw_data.Polarity_Patch_Number_2;
n_cluster_experiment = reshape(raw_data,[61,235])';
plot_stacked_bargraph(n_cluster_experiment);

function plot_stacked_bargraph(n_cluster)
[data1,N1] = plot_percentage(n_cluster,0,1);
[data2,N2] = plot_percentage(n_cluster,1,2);
[data3,N3] = plot_percentage(n_cluster,2,Inf);
total_N = sum(sum(~isnan(n_cluster)));
P1 = N1/total_N*100; P2 = N2/(total_N)*100; P3 = N3/(total_N)*100; 
data = [P1*data1/100;P2*data2/100;P3*data3/100];
figure('position',[300 300 500 400])
newcolors = [0.25 0.80 0.54
             1.00 0.54 0.00
             0.47 0.25 0.80];
colororder(newcolors);
bar([0,1,2],data,'stacked','linewidth',1);
xticklabels({'0','1','2+'});
set(gca,'linewidth',3); box off; 
set(gca,'tickDir','Out'); set(gca,'fontsize',25);
ylim([0,100])
end

function [data,N] = plot_percentage(n_cluster,lowerbound,upperbound)
[row,col] = find((n_cluster < upperbound) & (n_cluster >= lowerbound));
N = numel(row);
next_n_cluster = nan(1,N);
max_time_point = size(n_cluster,2);
for i = 1:N
    if col(i)+1 <= max_time_point
        next_n_cluster(i) = n_cluster(row(i),col(i)+1);
    end
end
N_total = sum(~isnan(next_n_cluster));
percentage_0 = sum(next_n_cluster==0)/N_total*100;
percentage_1 = sum(next_n_cluster==1)/N_total*100;
percentage_2plus = sum(next_n_cluster>=2)/N_total*100;
data = [percentage_2plus,percentage_1,percentage_0];
end