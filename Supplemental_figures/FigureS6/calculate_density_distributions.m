% Modified from "generate_density_distributions.m" from the
% paper: Liu B*, Stone OJ*, Pablo M*, Herron JC, Nogueira AT, Dagliyan O, 
% Grimm JB, Lavis LD, Elston TC, Hahn KM. Cell 2021 (*equal contribution).

% Calculate densities of voronoi cells in the current frame.
% Part of the "pipeline.m" pipeline

% Inputs: 
% L: domain length
% curr_coordinate: Coordinates of Cdc42-GTP at the current time point

% Outputs:
% density_distr: Densities of Voronoi cells
% updated_coordinate: Updated coordinates of Cdc42-GTP after subjected to Voronoi tessellation
% polys: shape information of Voronoi cells

function [density_distrs,updated_coordinate,polys] = calculate_density_distributions(curr_coordinate,L)
% Calculate Voronoi cells and local densities, constrained by cell ROI; um units. 
[v,c,updated_coordinate] = VoronoiLimit(curr_coordinate(:,1),curr_coordinate(:,2),...
                        'bs_ext',[0,L;L,L;L,0;0,0],'figure','off');
npolys = height(curr_coordinate);
polys = cell(npolys,1);
xyden = nan(npolys,3);
% Calculate the density (1/area) of each Voronoi cell
for j=1:npolys
    ps = polyshape(v(c{j},:));
    [centx,centy] = centroid(ps);
    den = 1/area(ps);
    xyden(j,:) = [centx,centy,den];
    polys{j,:} = ps;
end
density_distrs = xyden(:,3);
end
