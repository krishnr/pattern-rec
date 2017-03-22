function [ dist ] = MICD(mean_a, covar_a, mean_b, covar_b, X, Y )
% Calculate MICD distances for each point in a meshgrid.
% Positive means class B, negative means class A
    dist = zeros(size(X, 1), size(Y, 2));
    get_dist = @(point, covar, mean) (point - mean) * (covar\(point - mean)');
    
    for i=1:size(X, 1)
        for j=1:size(Y, 2)
            v = [X(i, j) Y(i, j)];
            dist(i, j) = get_dist(v, covar_a, mean_a) - get_dist(v, covar_b, mean_b);
        end
    end
end