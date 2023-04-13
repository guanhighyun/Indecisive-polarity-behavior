function plot_sphere(X,Y,Z,r,degree1,degree2)
[x,y,z]=sphere(100);
x=x*r; y=y*r; z=z*r;
surf(x,y,z,'FaceColor',[0.95,0.95,0.95],'EdgeColor','none'); 
axis off; axis equal; grid off; box off; 
h = light;
lighting gouraud
h.Position = [0.5 0 0];
camlight; hold on; 
plot3(X,Y,Z,'b.','markersize',1)
view(degree1,degree2);
set(gca,'xticklabel',[],'yticklabel',[],'zticklabel',[]);
end