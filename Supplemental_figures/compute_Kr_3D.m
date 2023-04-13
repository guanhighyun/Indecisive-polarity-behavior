% Code from Michael Pablo, PhD.

function K_adjusted = compute_Kr_3D(az,el,r_vec,R)
% Suggested use:
% [az,el,~]=cart2sph(x,y,z);
% r_vec = 0:0.01:0.6; R = 2.5;
% [K,Kcsr,r_eval]=compute_Kr(az,el,0,r_vec,R);
% plot(r_eval,K(1:end-1)-Kcsr(1:end-1));
%
% INPUTS 
% az, el : azimuth and elevation coordinate vectors of particles, in radians
% rvec   : discretization of great circle distances to examine
% R      : radius of sphere
% OUTPUTS
% K      : measured Ripley-K on sphere, from the input data.
% Kcsr   : analytic expected "completely spatially random".
% r_eval : great circle distances upon which K and Kcsr are evaluated.

% Method:
% 1) Compute distance matrix Dmat with elements dij = R*dsigmaij,
%    where dsigma is the central angle between pairs of particles.
%    --> Use the Vincenty formula to solve dsigmaij given azim
%         see 1975, Vincenty T. "Direct and Inverse Solutions of Geodesics
%         on the Ellipsoid with Application of Nested Equations."
%         Survey Review. Directorate of Overseas Surveys. 23(176):88-93
% 2) Calculate the Ripley K-function on a sphere, according to:
%    K = 4*pi*R^2/(n*(n-1)) * SUM
%       where SUM is
%           n    n
%          sum  sum  I( dij < r )
%          i=1 j=/=i
%       with I as the indicator function. n is the number of particles.
%    --> see 2014 Robeson SM, Li A, Huang C. "Point-pattern analysis on the
%        sphere" Spatial Statistics. 10, 76-86.
%
%  3) Note that the CSR Ripley K(r) is 2*pi*R^2*(1-cos(r/R)).
%    --> See 2014 Robeson et al.
npts=numel(az);
assert(npts==numel(el));
Dmat = zeros(npts,npts);
% Note that we only need to calculate upper triangular block
for i=1:npts
    for j=i:npts
        if j==i
            Dmat(i,j) = 0;
        else
            Dmat(i,j) = great_circle_distance(az(i),el(i),az(j),el(j),R);
        end
    end
end
Dmat = (Dmat+Dmat'); % Transpose and sum to get full matrix
counts = zeros(size(r_vec));
for i=1:(numel(r_vec))
    counts(i) = sum(sum(Dmat<=r_vec(i) & Dmat ~= 0));
end
K = 4*pi*R^2/(npts*(npts-1)) * counts;
Kcsr=2*pi*R^2*(1-cos(r_vec/R));
K_adjusted = K - Kcsr;
end

function d = great_circle_distance(az1,el1,az2,el2,r)
% lambda = long (az)
% phi = lat (el)

% Use Vincenty formula for great circle distances, for accuracy.
sigma = atan2( sqrt( (cos(el2).*sin(abs(az1-az2))).^2 +...
                    (cos(el1).*sin(el2)-sin(el1).*cos(el2).*cos(abs(az1-az2))).^2)  ,...
            (sin(el1).*sin(el2)+cos(el1).*cos(el2).*cos(abs(az1-az2))));
d=sigma*r;
end