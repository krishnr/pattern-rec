function [ z ] = bivariate_normal( n, covar, mu )
%BIVARIATE_NORMAL Generate values from a bivariate normal distribution.
%   Given a number of samples, n, a covariance matrix, covar, and mean
%   vector, mu, this function will generate samples from a bivariate
%   normal distribution. It will return a vector of n x 2 size, z.
    R = chol(covar); % Diagonalize the covariance matrix
    z = repmat(mu, n, 1) + randn(n, 2) * R;
end

