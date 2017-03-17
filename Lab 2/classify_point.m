function [ class ] = classify_point( ab, ac, bc )
%CLASSIFY_POINT Summary of this function goes here
%   Detailed explanation goes here
a = 1; b = 2; c = 3;
if ab >= 0 && bc <= 0
    class = b;
elseif ab <= 0 && ac >= 0
    class = a;
elseif ac >= 0 && ab <= 0
    class = c;
else
    % else condition shouldn't ever be hit
    disp('wat..something is wrong');
    disp(ab);
    disp(ac);
    disp(bc);
end
end

