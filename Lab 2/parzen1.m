function [ p_hat ] = parzen1( a, x, N, h )
% parzen1
%   Computes parzen estimator for a 1D dataset using Gaussian window

p_hat = zeros(size(x));

for i=1:size(x,2)
    sum = 0;
    for j=1:size(a,2)
        sum = sum + normpdf(x(i), a(j), h);
    end
    p_hat(i) = 1/N * sum;
end

end

