function [ boundary ] = get_decision_boundary( fname, xx, yy, covar_a, mu_a, covar_b, mu_b )
%GET_DECISION_BOUNDARY Summary of this function goes here
%   Detailed explanation goes here

boundary = zeros(length(xx), length(yy));

for i=1:length(xx)
    for j=1:length(yy)
        v = transpose([xx(i); yy(j)]);
        boundary(i, j) = sign(feval(fname, v, covar_b, mu_b) - feval(fname, v, covar_a, mu_a)   );
    end
end
end

