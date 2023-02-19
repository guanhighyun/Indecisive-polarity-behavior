% Adapted from "Hfn_smoldyn_clustQuant.m" from the paper:
% Ramirez SA, Pablo M, Burk S, Lew DJ, Elston TC (2021). 
% PLoS Comput Biol 17(7): e1008525.

% Inputs:
% x: azimuth and elevation coordinate vectors of particles, in radians
% y: discretization of great circle distances to examine
% L: domain length
% r: a particular interparticle distance for the calculation of Ripley's K

% Output:
% H: The values of Ripley's K function at different search radius r

function [H] = compute_Kr(x,y,r,L)
% ========================================================================
% Mike Pablo - Aug 23, 2016.
% Uses a rescaled version of a well-known clustering metric.
% The H-function is a modification of the established Ripley's K-function.
% It is defined using the cumulative distribution of inter-particle
% distances, 
%          / r
%  K(r) =  |    P(r')dr'
%          / 0
%
% where P(r)dr is the probability of finding a particle lying between r and
% r + dr.
%
% Then, H(r) is defined as
%           ___________
%          |  L^2
% H(r) =  \| ____ K(r)   - r
%          |  pi
%
% where the -r represents the contribution from a complete spatial random 
% distribution. Therefore, non-zero H(r) represents deviation from complete
% spatial randomness at the particular inter-particle distance r.
%
% See Wehrens M, Rein ten Wolde P, and Mugler A. J Chem Phys 2014, 141,
% 205102-1 for more details.
% ========================================================================
npts = numel(x); % Number of particles in the domain 
counts = zeros(1,numel(r)); % store the number of pairs of molecules which  
% are within the distance r.

% Calculate and store the distances between each pair of molecules
Dmat = zeros(npts,npts); 
for i=1:npts
    for j=i:npts
        % Note that we only need to calculate upper triangular block
        % because the upper and lower block are repeated values.
        if j==i
            Dmat(i,j) = 0;
        else
            Dmat(i,j) = vecnorm([x(i),y(i)]-[x(j),y(j)]);
        end
    end
end
Dmat = (Dmat+Dmat');

% Calculate how many pairs of molecules are within a variety of distances r
for k = 1:numel(r)
    counts(k) = sum(sum(Dmat<=r(k) & Dmat ~= 0));
end
% Calculate the value of Ripley's K function at different r
H = sqrt(L^2/pi/(npts*(npts-1)) * counts) -r;
end


