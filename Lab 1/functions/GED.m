function [ dist ] = GED( covar_a, mean_a, covar_b, mean_b, X, Y )
%GED Calculatte GED for two classes.
if nargin < 6
    dist = zeros(length(X), 1);
    get_dist = @(point, covar, mean) sqrt((point - mean) * inv(covar) * transpose(point - mean));

    for i=1:length(X)
        v = X(i, :);
        dist(i) = get_dist(v, covar_a, mean_a) - get_dist(v, covar_b, mean_b);
    end
else
    dist = zeros(size(X, 1), size(Y, 2));
    get_dist = @(point, covar, mean) sqrt((point - mean) * inv(covar) * transpose(point - mean));

    for i=1:size(X, 1)
        for j=1:size(Y, 2)
            v = [X(i, j) Y(i, j)];
            dist(i, j) = get_dist(v, covar_a, mean_a) - get_dist(v, covar_b, mean_b);
        end
    end
end
end