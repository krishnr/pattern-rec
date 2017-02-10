% Computes the GED boundary for a 2D grid
%
% Febuary 12 2017
%
% Brady Kieffer - 20517665
% Krishn Ramesh - 20521942

[xx, yy] = meshgrid(-5.0:20, 0.0:25);

ged_boundary = zeros(size(xx));
get_dist = @(point, covar, mean) sqrt((point - mean) * inv(covar) * transpose(point - mean));

for i=1:length(xx)
    for j=1:length(xx)
        v = transpose([xx(i, j); yy(i, j)]);
        dist = get_dist(v, covar_a, mu_a) - get_dist(v, covar_b, mu_b);
        ged_boundary(i, j) = sign(dist);
    end
end