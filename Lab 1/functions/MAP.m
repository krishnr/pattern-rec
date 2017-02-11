function [ dist ] = MAP( n_a, covar_a, mean_a, n_b, covar_b, mean_b, X, Y)
%MAP Calculate MAP for two classes.

Q0 = inv(covar_a) - inv(covar_b);
Q1 = 2*(mean_b * inv(covar_b) - mean_a * inv(covar_a));
Q2 = mean_a * inv(covar_a) * mean_a' - mean_b * inv(covar_b) * mean_b';
Q3 = log(n_b/n_a);
Q4 = log(det(covar_a)/det(covar_b));

if nargin < 8
    dist = zeros(length(X), 1);
    for i = 1:length(X)
        point = X(i,:);
        dist(i) = point*Q0*point' + Q1*point' + Q2 + 2*Q3 + Q4;
    end
else
    dist = zeros(size(X, 1), size(Y, 2));
    for i = 1:size(X, 1)
       for j = 1:size(Y, 2)
           point = [X(i,j), Y(i,j)];
           dist(i,j) = point*Q0*point' + Q1*point' + Q2 + 2*Q3 + Q4;
       end
    end 
end
end

