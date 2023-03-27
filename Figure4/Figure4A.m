% Plot the percentage of polarized states in the last 2000 seconds of each
% simulation. The percentage = (number of K values >=1.5)/(all K values 
% from 2000 seconds to 4000 seconds). 

% Load the x and y values of the figure.
% Sigma is the dispersion level of receptor clusters. It is the standard
% deviation of the Gaussian source of receptors.
% We have 30 simulations for each value of sigma.
% K stores the Ripley's K values from 2000 to 4000 seconds of each simulation.
load('FigureData/Figure4A.mat')

% Calculate the percentage of K >= 1.5 over all K from 2000 to 4000 seconds.
percentage_polarized_states = nan(numel(random_seeds),numel(sigma));
for i = 1:numel(sigma)
    for j = random_seeds
        current_K = K{j,i};
        percentage_polarized_states(j,i) = sum(current_K>=1.5)/sum(~isnan(current_K));
    end
end

figure('position',[300 300 700 700]);
% Create a list of number of Far1-GEF clusters for the swarmchart and boxchart.
index = repelem(sigma,1,numel(random_seeds));
% Make the list of categorical variables for nicer plots.
index = categorical(index);
% Reshape the data for nicer plots.
data = reshape(percentage_polarized_states,1,numel(percentage_polarized_states));
% Generate the plot.
subplot(3,3,1:6)
swarmchart(index,data,100,'k','filled'); hold on;
%boxchart(index,data,'boxfacecolor','b','BoxFaceColorMode','manual',...
%'markercolor','none','linewidth',3.5);
text(3.4,-0.4,'Dispersion (\sigma)','fontsize',25)
ylabel('Fraction of time in polarized states')
set(gca,'linewidth',3)
xticklabels(sigma);
set(gca,'TickDir','out');
set(gca,'fontsize',25)
hold off

% Visualize the distribution of receptors with different dispersion.
L = 8.8623; % domain length
for m = sigma
    x = normrnd(L/2,m,[1,2500]);
    y = normrnd(L/2,m,[1,2500]);
    axes('Position',[m*0.39-0.15 0.25 .08 .08])
    scatter(x,y,1,'k','markerfacecolor','k','markeredgecolor','none'); axis([0,L,0,L])
    axis square; set(gca,'YTickLabel',[]); set(gca,'XTickLabel',[]); box on; set(gca,'linewidth',1)
end