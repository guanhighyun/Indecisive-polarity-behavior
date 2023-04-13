clear; figure;
K_pre = 56; r_pre = 1.1; r_sphere = 2.5; N = 1000; 
Kcsr=2*pi*r_sphere^2*(1-cos(r_pre/r_sphere));
Kr_pre = Kcsr + K_pre;
n_pair = Kr_pre/(4*pi*r_sphere^2/(N*(N-1)));
syms x
eqn = x*(x-1) - n_pair == 0;
S = solve(eqn);
n = double(ceil(S(S>=0)));

kappa = 25; L = 8.8623; r = 0.5:0.1:L/2;
position = randvonMisesFisherm(3,n,kappa,[1,0,0]);
[az,el,~] = cart2sph(position(1,:),position(2,:),position(3,:));
[x,y,z] = sph2cart(az,el,r_sphere);

position = randvonMisesFisherm(3,N-n,0.01,[1,0,0]);
[az,el,~] = cart2sph(position(1,:),position(2,:),position(3,:));
[x_uni,y_uni,z_uni] = sph2cart(az,el,r_sphere);
x = [x,x_uni];
y = [y,y_uni];
z = [z,z_uni];
[az,el,~] = cart2sph(x,y,z);

K = max(compute_Kr_3D(az,el,r,r_sphere));
plot_sphere(x,y,z,r_sphere,90,0)

