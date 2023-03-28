% Inputs: 
% magnitude of pheromone gradient
% baseline: concentration of background uniform pheromone

function Gaussian_on_a_sphere(baseline,magnitude)
x0 = 0; y0 = -1; z0 = 0;
sig = 0.5;
f = spherefun(@(x,y,z) baseline + magnitude*exp(-((x-x0).^2+(y-y0).^2+(z-z0).^2)/sig^2));
plot(f); axis off;
view(0,0)
end