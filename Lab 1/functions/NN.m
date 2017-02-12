function[ dist ] = NN( k, samples_a, samples_b, X, Y )
%NN Calculate the K Nearest Neighbours for two classes

if nargin < 5
    dist = zeros(length(X), 1);
    get_dist = @(point, samples) [samples, sqrt(sum(bsxfun(@minus, samples, point).^2,2))];
    
    for i=1:length(X)
        point = X(i, :);
        a_distances = get_dist(point, samples_a);
          closest_a = closest_mean_dist(a_distances, k, point);
          b_distances = get_dist(point, samples_b);
          closest_b = closest_mean_dist(b_distances, k, point);
          dist(i) = closest_a - closest_b;
    end
    
else
    dist = zeros(size(X, 1), size(Y, 2));
    get_dist = @(point, samples) [samples, sqrt(sum(bsxfun(@minus, samples, point).^2,2))];

    for i = 1:size(X, 1)
       for j = 1:size(Y, 2)
           point = [X(i,j), Y(i,j)];
           a_distances = get_dist(point, samples_a);
           closest_a = closest_mean_dist(a_distances, k, point);
           b_distances = get_dist(point, samples_b);
           closest_b = closest_mean_dist(b_distances, k, point);
           dist(i, j) = closest_a - closest_b;
       end
    end
end
end


function[ closest ] = closest_mean_dist(distances, k, point)
B = sortrows(distances, 3);
B = B(1:k,:);
B(:,3) = [];
closest_mean = mean(B, 1);
closest = sqrt((point - closest_mean) * (point-closest_mean)');
end

