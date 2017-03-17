function [ dist ] = ML(mu_a, cov_a, mu_b, cov_b, X, Y )
%ML Summary of this function goes here
%   Detailed explanation goes here
dist = zeros(size(X, 1), size(Y, 2));
inv_cov_a = inv(cov_a);
inv_cov_b = inv(cov_b);

for i = 1:size(X, 1)
    for j = 1:size(Y, 2)
    point = [X(i,j), Y(i,j)];
    dist_a = (point - mu_a) * inv_cov_a * transpose(point - mu_a);
    dist_b = (point - mu_b) * inv_cov_b * transpose(point - mu_b);
    dist(i,j) = dist_b - dist_a;
    end
end
end