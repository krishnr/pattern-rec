function [ dist ] = generalized_euclidean_distance( point, covar, mean )
%GENERALIZED_EUCLIDEAN_DISTANCE Compute the GED given data, covariance and
%a mean
    dist = sqrt((point - mean) * inv(covar) * transpose(point - mean));
end

