% Plot the snapshots of 3D Cdc42-GTP distribution at different time points. 
load('Coordinates/Figure4F_coordinates.mat')
r = 2.5;
figure('units','pixels','position',[300 300 1800 600]); 
subplot(1,4,1)
plot_sphere(x_1,y_1,z_1,r,45,0);
text(-10,8.6,-4,'8 min','fontsize',25)

subplot(1,4,2)
plot_sphere(x_2,y_2,z_2,r,45,0);
text(-10,8.9,-4,'26 min','fontsize',25)

subplot(1,4,3)
plot_sphere(x_3,y_3,z_3,r,45,0);
text(-10,9.1,-4,'44 min','fontsize',25)

subplot(1,4,4)
plot_sphere(x_4,y_4,z_4,r,45,0);
text(-10,9.3,-4,'62 min','fontsize',25)