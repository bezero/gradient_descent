function [w,y_opt,E,niter] = grad_descent_fit(f_type, data)
% [w,y_opt,E,niter] = grad_descent_fit(f_type, data) is a function that returns parameters 'w' for the selected
% function type to fit the given data. It uses gradient descent method to
% learn. The first column in the data file must represent input (X) and the second 
% column (Y) must represent the corresponding output
% 
% f_ype
%
% 1 - 2nd order polynomial
% 2 - 3rd order polynomial
% 3 - 2nd order Fourier series
% 4 - 4th order Fourier series
%
% Output Arguments
%
% w        parameters of the resultant function
% y_out    output generated from the resultant function
% E        error in each itteration
% niter    total number of itterations 

% read input data used for learning

[x,y]=textread(data);

% learling coefficint
nu = 0.01;

% termination tolerance
del = 1e-3;

% maximum iterations
max_iter = 1000;

switch f_type
    case 1 % 2nd order polynomial
        % setting initial point
        w =rand(3,1);
        % function to fit data
        f = @(x,w) [x.^2 x ones(size(x))]*w;
        % gradiant function
        grad = @(x,y,w) (2*sum([(f(x,w)-y).*x.^2 (f(x,w)-y).*x (f(x,w)-y)])/length(x))';
    case 2 % 3rd order polynomial
        w = rand(4,1);
        f = @(x,w) [x.^3 x.^2 x ones(size(x))]*w;
        grad = @(x,y,w) (2*sum([(f(x,w)-y).*x.^3 (f(x,w)-y).*x.^2 (f(x,w)-y).*x (f(x,w)-y)])/length(x))';
    case 3 % 2nd order Fourier series
        w = rand(4,1);
        f = @(x,w) [sin(2*pi.*x + w(3)) sin(4*pi.*x + w(4))]*w(1:2);
        grad = @(x,y,w) (2*sum([(f(x,w)-y).*sin(2*pi.*x + w(3))  (f(x,w)-y).*sin(4*pi.*x + w(4)) ...
            w(1).*(f(x,w)-y).*cos(2*pi.*x + w(3))  w(2).*(f(x,w)-y).*cos(4*pi.*x + w(4))])/length(x))';
    case 4 % 4th order Fourier series
        w = rand(8,1);
        f = @(x,w) [sin(2*pi.*x + w(5)) sin(4*pi.*x + w(6)) sin(6*pi.*x + w(7)) sin(8*pi.*x + w(8))]*w(1:4);
        
        grad = @(x,y,w) (2*sum([(f(x,w)-y).*sin(2*pi.*x + w(5))  (f(x,w)-y).*sin(4*pi.*x + w(6)) ...
            (f(x,w)-y).*sin(6*pi.*x + w(7))  (f(x,w)-y).*sin(8*pi.*x + w(8)) ...
            w(1).*(f(x,w)-y).*cos(2*pi.*x + w(5))  w(2).*(f(x,w)-y).*cos(4*pi.*x + w(6)) ...
            w(3).*(f(x,w)-y).*cos(6*pi.*x + w(7))  w(4).*(f(x,w)-y).*cos(8*pi.*x + w(8))])/length(x))';
    otherwise
        error('invalid function type')
end

% error function
f_err = @(x,y,w) sum((f(x,w) - y).^2);

% calculate error
E = f_err(x,y,w);

% gradient descent algorithm:
for ii=1:max_iter
    % calculate gradiant
    del_w = grad(x,y,w);
    % update coefficients
    w_new = w - nu*del_w;
    
    % check step
    if ~isfinite(w_new)
        display(['Number of iterations: ' num2str(ii)])
        error('x is inf or NaN')
    end
   
    % calculate error
    E = [E f_err(x,y,w)];
    
    dx = norm(w_new-w);
    w = w_new;
    if (dx <= del)
        display(['Number of iterations: ' num2str(ii)])
        fprintf('break \n')
        break;
    end
end
y_opt = f(x,w);
niter = ii;
end
