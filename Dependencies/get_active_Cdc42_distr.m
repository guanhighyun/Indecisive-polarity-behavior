% Adapted from "calculate_activeCOM_steps.m" from the paper: 
% Ramirez SA, Pablo M, Burk S, Lew DJ, Elston TC (2021). 
% PLoS Comput Biol 17(7): e1008525.

% Inputs: 
% positions: coordinates of all molecules
% nframes: total number of time points in the simulation

% Output:
% active_cdc42: The coordinates of Cdc42-GTP and Bem1-GEF-Cdc42-GTP at each
% time point.
function active_cdc42 = get_active_Cdc42_distr(positions,nframes)
% Record coordinates of Cdc42-GTP at each time point
active_cdc42 = cell(1,nframes); 
for i=1:nframes
    if ~isempty(positions.Cdc42T{i}) && ~isempty(positions.BemGEF42{i})
        all_active_x = [positions.Cdc42T{i}(:,1);positions.BemGEF42{i}(:,1)];
        all_active_y = [positions.Cdc42T{i}(:,2);positions.BemGEF42{i}(:,2)];
    elseif isempty(positions.Cdc42T{i}) && ~isempty(positions.BemGEF42{i})
        all_active_x = positions.BemGEF42{i}(:,1);
        all_active_y = positions.BemGEF42{i}(:,2);
    elseif ~isempty(positions.Cdc42T{i}) && isempty(positions.BemGEF42{i})
        all_active_x = positions.Cdc42T{i}(:,1);
        all_active_y = positions.Cdc42T{i}(:,2);
    else
        all_active_x = nan;
        all_active_y = nan;
    end
    tmp = [all_active_x,all_active_y];
    active_cdc42{i} = tmp;
end
end