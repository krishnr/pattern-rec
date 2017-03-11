function [ class ] = classify_point( p_a, p_b, p_c )
% Given the binary comparisons between 3 classes
% returns the class that a point belongs to
a = 1; b = 2; c = 3;
max_val = max([p_a p_b p_c]);
if max_val == p_a
    class = a;
elseif max_val == p_b
    class = b;
elseif max_val == p_c
    class = c;
else
    % else condition shouldn't ever be hit
    
    disp('wat..something is wrong');
    p_a
    p_b
    p_c
end

end

