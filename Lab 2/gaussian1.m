function [ mu_e, sigma_e ] = gaussian1( X )
%GAUSSIAN1 Summary of this function goes here
%   Detailed explanation goes here
N = length(X);

mu_e = sum(X) / N;

var_e = sum((X - mu_e).^2) / N;

sigma_e = sqrt(var_e);
end