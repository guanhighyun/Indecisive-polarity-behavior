% Compare clusters with different values of K.

load('FigureData/FigureS1A.mat')
L = 8.8623; % domain length
r = 0.5:0.1:L/2; % search radius for calculation of the K value. See Methods.
figure('position',[300,300,1200,400]);
tiledlayout(2,6,'Padding', 'none', 'TileSpacing', 'compact');
plot_nexttile_2D(x_1,y_1,r,L)
plot_nexttile_2D(x_2,y_2,r,L)
plot_nexttile_2D(x_3,y_3,r,L)
plot_nexttile_2D(x_4,y_4,r,L)
plot_nexttile_2D(x_5,y_5,r,L)
plot_nexttile_2D(x_6,y_6,r,L)

load('FigureData/FigureS1B.mat')
R = 2.5; % domain length
r = 0.5:0.1:8.8623/2; % search radius for calculation of the K value. See Methods.
plot_nexttile_3D(x_1,y_1,z_1,r,R,90)
plot_nexttile_3D(x_2,y_2,z_2,r,R,90)
plot_nexttile_3D(x_3,y_3,z_3,r,R,90)
plot_nexttile_3D(x_4,y_4,z_4,r,R,90)
plot_nexttile_3D(x_5,y_5,z_5,r,R,90)
plot_nexttile_3D(x_6,y_6,z_6,r,R,90)

function plot_nexttile_2D(x,y,r,L)
nexttile;
% Compute the maximum K value of the current molecular distribution
H = max(compute_Kr(x,y,r,L));
plot(x,y,'b.');  
title(sprintf('%.1f',H),'fontsize',25)
axis([-L/2,L/2,-L/2,L/2]); axis square; set(gca,'xtick',[]); set(gca,'ytick',[]); 
set(gca,'linewidth',3)
end

function plot_nexttile_3D(x,y,z,r,r_sphere,view_degree)
nexttile
[az,el,~] = cart2sph(x,y,z);
% Compute the maximum K value of the current molecular distribution
K = max(compute_Kr_3D(az,el,r,r_sphere));
plot_sphere(x,y,z,r_sphere,view_degree,0)
title(sprintf('%.1f',K),'fontsize',25)
end