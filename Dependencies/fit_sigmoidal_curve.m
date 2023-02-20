% Fit a sigmoidal function representing the relationship between
% the difference in frequencies of polarized/unpolarized states
% and the abundance of Bem1-GEF.

% Inputs: 
% x: number of Bem1-GEF.
% y: Difference between K>=1.5 and K<1.5.
% c_guess_value: guess value of c

% Outputs:
% parameters: a, b, and c in the sigmoidal function.
% goodness: goodness of fit.

% Use the MATLAB "Curve Fitting Toolbox".

function [parameters,goodness] = fit_sigmoidal_curve(x,y,c_guess_value)
[x, y] = prepareCurveData(x, y);
curve_function = fittype( 'a/(1+exp(-b*(x-c)))-a/2', ...
    'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
% The guess value of a is set to be 8000; the guess value of b is set to be
% 0.02. These two guess values are based on empirical estimation.
a_guess_value = 8000;
b_guess_value = 0.02;
opts.StartPoint = [a_guess_value,b_guess_value,c_guess_value];
[parameters,goodness] = fit(x,y,curve_function,opts);
end