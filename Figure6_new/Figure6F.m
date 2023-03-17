% Plot the snapshots of 3D Cdc42-GTP distribution at different time points. 
load('Coordinates/Figure6F_coordinates.mat')
r = 2.5;
figure('units','pixels','position',[300 300 1800 600]); 
subplot(1,4,1)
plot_sphere(x_1,y_1,z_1,r,90,0);
text(0,-0.5,-3.5,'1 min','fontsize',40)

subplot(1,4,2)
plot_sphere(x_2,y_2,z_2,r,90,0);
text(0,-0.5,-3.5,'30 min','fontsize',40)

subplot(1,4,3)
plot_sphere(x_3,y_3,z_3,r,90,0);
text(0,-0.5,-3.5,'60 min','fontsize',40)

subplot(1,4,4)
plot_sphere(x_4,y_4,z_4,r,90,0);
text(0,-0.5,-3.5,'70 min','fontsize',40)