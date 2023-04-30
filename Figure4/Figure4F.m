% Plot the snapshots of 3D Cdc42-GTP distribution at different time points. 
load('Coordinates/Figure4F_coordinates.mat')
r = 2.5;
figure('units','pixels','position',[300 300 1800 600]); 
subplot(1,5,1)
plot_sphere(x_1,y_1,z_1,r,90,0);
text(0,-0.5,-3.5,'8 min','fontsize',30)

subplot(1,5,2)
plot_sphere(x_2,y_2,z_2,r,90,0);
text(0,-0.5,-3.5,'26 min','fontsize',30)

subplot(1,5,3)
plot_sphere(x_3,y_3,z_3,r,90,0);
text(0,-0.5,-3.5,'35 min','fontsize',30)

subplot(1,5,4)
plot_sphere(x_4,y_4,z_4,r,90,0);
text(0,-0.5,-3.5,'44 min','fontsize',30)

subplot(1,5,5)
plot_sphere(x_5,y_5,z_5,r,90,0);
text(0,-0.5,-3.5,'62 min','fontsize',30)

% Plot a 3D sphere as the simulated cell to generate snapshots of molecular
% distribution on the sphere.

% Inputs:
% X, Y, Z: coordinates of the molecules.
% degree1, degree2:  sets the azimuth and elevation angles of the camera's 
% line of sight for the current axes.

function plot_sphere(X,Y,Z,r,degree1,degree2)
[x,y,z]=sphere(100);
x=x*r; y=y*r; z=z*r;
surf(x,y,z,'FaceColor',[0.95,0.95,0.95],'EdgeColor','none'); 
axis off; axis equal; grid off; box off; 
h = light;
lighting gouraud
h.Position = [0.5 0 0];
camlight; hold on; 
plot3(X,Y,Z,'b.','markersize',10)
view(degree1,degree2);
set(gca,'xticklabel',[],'yticklabel',[],'zticklabel',[]);
end