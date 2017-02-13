function [ class ] = classify_point( cd, de, ec )
% Given the binary comparisons between 3 classes
% returns the class that a point belongs to
c = 1; d = 2; e = 3;
if cd >= 0 && de <= 0
    class = d;
elseif cd <= 0 && ec >= 0
    class = c;
elseif de >= 0 && ec <= 0
    class = e;
else
    % else condition shouldn't ever be hit
    
    disp('wat..something is wrong');
    cd
    de
    ec
end

end

