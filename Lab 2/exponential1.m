function[ lambda_e ] = exponential1( a )
% exponential1
% Returns ML estimated lambda for exponential distribution
N = length(a);
lambda_e = 0;
for i = 1:N
    lambda_e = lambda_e + a(i);
end

lambda_e = N / lambda_e;
end