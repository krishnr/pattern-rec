function [ dist ] = MED( mean_a, mean_b, X, Y )
% Calculate MED for two classes
% negative value means class a, positive value means class b

if nargin < 4
    dist = zeros(length(X), 1);
    get_dist = @(point, mean) sqrt((point-mean) * (point-mean)');

    for i=1:length(X)
        point = X(i, :);
        dist(i) = get_dist(point, mean_a) - get_dist(point, mean_b);
    end
else
    dist = zeros(size(X, 1), size(Y, 2));
    get_dist = @(point, mean) (point-mean) * (point-mean)';

    for i=1:size(X, 1)
        for j=1:size(Y, 2)
            point = [X(i, j) Y(i, j)];
            dist(i, j) = get_dist(point, mean_a) - get_dist(point, mean_b);
        end
    end
    
end
end