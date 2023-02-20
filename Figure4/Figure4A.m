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
        percentage_polarized_states(j,i) = sum(current_K>=1.5)/numel(current_K)*100;
    end
end

% Generate the figure.
figure; hold on
bar(sigma,nanmean(percentage_polarized_states),...
    'facecolor','#4DBEEE','linewidth',4,'facealpha',0.4,'edgecolor','#0072BD')
% Here we use the standard error of the mean as we are interested in 
% the mean percentage.
errorbar(sigma,nanmean(percentage_polarized_states),...
    nanstd(percentage_polarized_states)/sqrt(height(percentage_polarized_states)),...
    '.','linewidth',4,'color','#0072BD')
set(gcf,'Position',[300 300 550 450]); 
set(gca,'fontsize',25)
xlabel('Dispersion (\sigma)')
ylabel('Percentage of polarization (%)')
hold off

% Visualize the distribution of receptors with different dispersion.
L = 8.8623; % domain length
for sigma = [0.75,1.5,2.5]
    x = normrnd(L/2,sigma,[1,2500]);
    y = normrnd(L/2,sigma,[1,2500]);
    figure; plot(x,y,'k.'); axis([0,L,0,L])
    axis square; set(gca,'YTickLabel',[]); set(gca,'XTickLabel',[])
end