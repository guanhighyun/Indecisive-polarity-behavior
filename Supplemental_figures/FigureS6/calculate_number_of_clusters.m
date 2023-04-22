% Modified from "generate_voronoiSegmented_clusters.m" from the
% paper: Liu B*, Stone OJ*, Pablo M*, Herron JC, Nogueira AT, Dagliyan O, 
% Grimm JB, Lavis LD, Elston TC, Hahn KM. Cell 2021 (*equal contribution).

% Find how many clusters are in the current frame.
% Part of the "pipeline.m" pipeline

% Inputs: 
% curr_coordinate: the voordinates of Cdc42-GTP at the current time point.
% cutoff: the area a Voronoi cell must reach this threshold to be 
% considered as part of a cluster.
% area threshold: the threshold area of a group of Voronoi cells to be 
% considered as a cluster.
% cluster_density_threshold: the threshold Cdc42-GTP number density of a 
% group of Voronoi cells to be considered as a cluster.
% * A group of Voronoi cells must pass both the threshold of area and the 
% threshold of Cdc42-GTP number density to be considered as a cluster.
% L: domain length

% Output:
% number: number of clusters detected.

function [number] = calculate_number_of_clusters(curr_coordinate, cutoff, ...
    area_threshold, cluster_density_threshold, L)
x = curr_coordinate(:,1);
y = curr_coordinate(:,2);

% To detect clusters across the periodic boundary, we have to 
% 1. Create an extended domain by replicating the original domain 8 times.
% 2. Apply the Voronoi tessellation on the extended domain.
% 3. Specify the desired area on the Voronoi diagram using the boundary of 
% the orignal domain.
x = [x;x;x+L;x+L;x+L;x;x-L;x-L;x-L];
y = [y;y+L;y+L;y;y-L;y-L;y-L;y;y+L];
[v,c,updated_coordinate] = VoronoiLimit(x,y,...
                        'bs_ext',[0,L;L,L;L,0;0,0],'figure','off');
npolys = height(updated_coordinate);
poly_dens = zeros(npolys,1);
all_polys = cell(npolys,1);

% Get the shape information and density of each Voronoi cell.
for j=1:npolys
    ps = polyshape(v(c{j},:));
    all_polys{j} = ps;
    poly_dens(j) = 1/area(ps);
end

periodic_polys = all_polys;
% Remove the Voronoi cells whose densities are below the threshold 
remove_index = find(poly_dens<cutoff);
adjacency_mat = false(npolys,npolys);
for j=1:npolys
    for k=j:npolys
        if (any(remove_index==j)) || (any(remove_index==k))
            adjacency_mat(j,k) = false;
            adjacency_mat(k,j) = false;
        else
            v1 = periodic_polys{j}.Vertices;
            v2 = periodic_polys{k}.Vertices;
            % Apply the periodic boundary condition to vertices of the cells
            v1 = modify_vertices(L,v1);
            v2 = modify_vertices(L,v2);
            if share_vertex(v1,v2)
                adjacency_mat(j,k) = true;
                adjacency_mat(k,j) = true;
            end
        end
    end
end
% Find potential clusters
polygraph = graph(adjacency_mat);
clusters=conncomp(polygraph); 
cluster_list = unique(clusters);
nclus = numel(cluster_list);
segmented_clusters = cell(nclus,1);
index = cell(nclus,1);
for j=1:nclus
    curr_clus = cluster_list(j);
    curr_poly_in_clus = find(curr_clus==clusters);
    number_in_cluster = numel(curr_poly_in_clus);
    if number_in_cluster >= 3
        curr_seg_clus = union(all_polys{curr_poly_in_clus(1)},...
                                  all_polys{curr_poly_in_clus(2)});
        for k=3:numel(curr_poly_in_clus)
            curr_seg_clus = union(curr_seg_clus,...
                                  all_polys{curr_poly_in_clus(k)});
        end
        cluster_area = area(polyshape(curr_seg_clus.Vertices));
        cluster_density = number_in_cluster/cluster_area;
        % Apply the area threshold and Cdc42-GTP number density threshold
        if (cluster_density >= cluster_density_threshold) && (cluster_area >= area_threshold)
            % Identify indices of clusters which pass the thresholds
            index{j} = curr_poly_in_clus;
            segmented_clusters{j} = curr_seg_clus; 
        end
    end
end
% Count the number of identified clusters
index = index(~cellfun(@isempty,index));
number = numel(index);
end

function dotouch = share_vertex(v1,v2)
nv1 = size(v1,1);
dotouch=false;
for i=1:nv1
    if any(v1(i,:)==v2)
        dotouch = true;
        break;
    end
end
end

function v = modify_vertices(L,v)
    v_x = v(:,1);
    v_y = v(:,2);
    if sum(v_x(:)==L) >= 1
        v_x(v_x==L) = 0;
    end
    if sum(v_y(:)==L) >= 1
        v_y(v_y==L) = 0;
    end
    v = [v_x,v_y];
end
