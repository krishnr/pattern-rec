function [ a, b ] = uniform( data )
% uniform
% Returns ML estimated a,b values for uniform distribution
    a = min(data);
    b = max(data);
end

