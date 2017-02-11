function [ T, F ] = get_error( n_s, dist, compare_func )
%MAP_ERROR Compute the error of the MAP classifier between two classes.
% Returns the true predictions and the incorrect ones

T = 0;
for i=1:length(dist)
    point = dist(i);
    if compare_func(point)
        T = T + 1;
    end
end
F = n_s - T;