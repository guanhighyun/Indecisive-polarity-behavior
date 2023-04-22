% Modified from "simulate_uniform_density_distributions_50x.m" from the
% paper: Liu B*, Stone OJ*, Pablo M*, Herron JC, Nogueira AT, Dagliyan O, 
% Grimm JB, Lavis LD, Elston TC, Hahn KM. Cell 2021 (*equal contribution).

% Simulates negative controls for the Voronoi-based cluster segmentation.
% This is for thresholding purposes, and must be compared with the
% density distributions generated from simulated cells in the
% particle-based model.
% Part of the "pipeline.m" pipeline.

% Inputs:
% curr_coordinate: The current coordinates of Cdc42-GTP
% L: domain length

% Outputs:
% density_distrs: densities of Voronoi cells
% coordinate: updated coordinates by Voronoi tessellation.
% all_polys: information regarding shapes of the Voronoi cells

function [density_distrs, coordinate, all_polys] = simulate_uniform_density_distributions(curr_coordinate,L)
nsims=50; % Number of simulations
expdata = curr_coordinate;
% Domain boundary
window_min = 0;
window_max = L;
npolys = height(curr_coordinate);
density_distrs = cell(nsims,1);
coordinate = cell(nsims,1);
all_polys = cell(1,nsims);
for sim_rep_idx = 1:nsims
    centroids = unifrnd(window_min, window_max, [height(expdata),2]);
    polys = cell(npolys,1);
    % Calculate Voronoi cells and local densities, constrained by cell ROI; um units
    [v,c,coordinate{sim_rep_idx}] = VoronoiLimit(centroids(:,1),centroids(:,2),...
                        'bs_ext',[0,L;L,L;L,0;0,0],'figure','off');
    npolys = size(c,1);
    xyden = nan(npolys,3);
    for j=1:npolys
        warning('off','all');
        ps = polyshape(v(c{j},:));
        warning('on','all');
        [centx,centy] = centroid(ps);
       den = 1/area(ps);
       xyden(j,:) = [centx,centy,den];
       polys{j} = ps;
    end
    density_distrs{sim_rep_idx} = xyden(:,3);
    all_polys{sim_rep_idx} = polys;
end 
end