% Modified from "compare_voronoicell_size_distributions_sim50x.m" from the
% paper: Liu B*, Stone OJ*, Pablo M*, Herron JC, Nogueira AT, Dagliyan O, 
% Grimm JB, Lavis LD, Elston TC, Hahn KM. Cell 2021 (*equal contribution).

% Determines threshold densities for cluster segmentation.
% Part of the "pipeline.m" pipeline.

% Inputs:
% density_distr: density distributions of Voronoi cells generated from
% simulated cells in the particle-based model.
% uniform_density_distr: density distributions of Voronoi cells generated
% from negative control simulations.

% Output:
% cutoff: the area a Voronoi cell must reach this threshold to be
% considered as part of a cluster.

function cutoff = compare_voronoicell_size_distributions(density_distrs, uniform_density_distrs)
% Get the areas of Voronoi cells in 0.01 um^2
% Area of Voronoi cells in simulated cells in the particle-based model.
exp_areas = 100*convert_density_to_areas(density_distrs);

% Area of Voronoi cells in simulated cells in the negative control.
nsimreps = 50;
sim_areas = cellfun(@convert_density_to_areas,uniform_density_distrs,'uniformoutput',false);
sim_areas = cellfun(@times100,sim_areas,'uniformoutput',false);

binwidth = 1; % 0.01 um^2

% Area cutoff
cutoff = get_cutoff_50x(exp_areas,sim_areas,binwidth, nsimreps);

% Convert area cutoff to density cutoff
cutoff = convert_areas_to_density(cutoff/100); 
end

function cutoff = get_cutoff_50x(expdata,simdata50x,binwidth,nsimreps)
% Find the intesection of the probability distributions between the
% simulated mean from the negative control and the particle-based model. 
% Apply smoothing prior to intersection checking; empirically chose 5pt Gaussian smooth.
[exp_distr,exp_edges]=histcounts(expdata,'binwidth',binwidth);
sim_distr=cell(nsimreps,1);
sim_edges=cell(nsimreps,1);

% Figure out the appropriate bin limits across the whole sim data
maxbin = min(cellfun(@max,simdata50x));
minbin = min(cellfun(@min,simdata50x));

for i=1:nsimreps
    [sim_distr{i},sim_edges]=histcounts(simdata50x{i},'binwidth',binwidth,'binlimits',[minbin maxbin]);
end
mean_sim_distr = mean(cell2mat(sim_distr));
exp_cents = get_bin_centers(exp_edges);
sim_cents = get_bin_centers(sim_edges);
exp_distr = smoothdata(exp_distr,'gaussian',5);
mean_sim_distr = smoothdata(mean_sim_distr,'gaussian',5);
[x_ints,~,~,~] = intersections(exp_cents,exp_distr,sim_cents,mean_sim_distr);
cutoff = x_ints(1);
end

function centers = get_bin_centers(binedges)
centers = mean([binedges(1:end-1);binedges(2:end)]);
end

function areas = convert_density_to_areas(density)
areas=1./density;
end
function density = convert_areas_to_density(area)
density=1./area;
end

function new_value = times100(value)
new_value = value*100;
end
