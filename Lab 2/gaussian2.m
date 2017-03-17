function [ mu_e, cov_e ] = gaussian2( X )
%GAUSSIAN2 Summary of this function goes here
%   Detailed explanation goes here

mu_e = sum(X) / length(X);
cov_e = cov(X);
end