function [ class ] = MICD(mu, S, X, Y )
% Calculate MICD distances for each point in a meshgrid.
% Positive means class B, negative means class A
    class = zeros(size(X, 1), size(Y, 2));
    get_dist = @(point, covar, mean) (point - mean) * (covar\(point - mean)');
    
    for i=1:size(X, 1)
        for j=1:size(Y, 2)
            v = [X(i, j) Y(i, j)];
            [~, class(i, j)] = min([ ...
                get_dist(v, squeeze(S(1,:,:)), mu(1,:)), ...
                get_dist(v, squeeze(S(2,:,:)), mu(2,:)), ...
                get_dist(v, squeeze(S(3,:,:)), mu(3,:)), ...
                get_dist(v, squeeze(S(4,:,:)), mu(4,:)), ...
                get_dist(v, squeeze(S(5,:,:)), mu(5,:)), ...
                get_dist(v, squeeze(S(6,:,:)), mu(6,:)), ...
                get_dist(v, squeeze(S(7,:,:)), mu(7,:)), ...
                get_dist(v, squeeze(S(8,:,:)), mu(8,:)), ...
                get_dist(v, squeeze(S(9,:,:)), mu(9,:)), ...
                get_dist(v, squeeze(S(10,:,:)), mu(10,:)) ...
            ]);
        end
    end
end