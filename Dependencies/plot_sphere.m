% Inputs:
% X, Y, Z: coordinates of the molecules.
% degree1, degree2:  sets the azimuth and elevation angles of the camera's 
% line of sight for the current axes.

function plot_sphere(X,Y,Z,r,degree1,degree2)
[x,y,z]=sphere;
x=x*r; y=y*r; z=z*r;
surf(x,y,z,'FaceColor',[0.7 0.7 0.7],'EdgeColor','none'); 
axis off; axis equal; grid off; box off; 
lighting gouraud
camlight; hold on; 
plot3(X,Y,Z,'.','color',[0,0.813,1],'markersize',5)
view(degree1,degree2);
set(gca,'xticklabel',[],'yticklabel',[],'zticklabel',[]);
end