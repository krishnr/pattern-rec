function [ prototypes, classes ] = KMeans( K, X )
%KMEANS Summary of this function goes here
%   Detailed explanation goes here

% Grab K prototypes randomly from X
prototypes = protos;
new_prototypes = zeros(size(prototypes));

while true
    % Divides the image into its ten parts
    dists = pdist2(X, prototypes);
    [~, classes] = min(dists, [], 2);

    for i=1:K
        idx  = classes == i;
        v = sum(X(idx, :));
        N = length(X(idx, :));
        new_prototypes(i, :) = v / N;
    end
    
    if new_prototypes == prototypes; break; end;
    prototypes = new_prototypes;
end
end