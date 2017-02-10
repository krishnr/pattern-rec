% Computes the GED boundary for a 2D grid
%
% Febuary 12 2017
%
% Brady Kieffer - 20517665
% Krishn Ramesh - 20521942

GED1 = zeros(size(X1));
get_dist = @(point, covar, mean) sqrt((point - mean) * inv(covar) * transpose(point - mean));

for i=1:length(X1)
    for j=1:length(X1)
        v = [X1(i, j) Y1(i, j)];
        dist = get_dist(v, covar_a, mu_a) - get_dist(v, covar_b, mu_b);
        GED1(i, j) = dist;
    end
end