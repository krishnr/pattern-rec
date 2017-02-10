function [ class ] = classify_point( cd, de, ec )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

c = 1; d = 2; e = 3;

if cd > 0 && de < 0
    class = d;
elseif cd < 0 && ec > 0
    class = c;
elseif de > 0 && ec < 0
    class = e;
else
    disp('wat')
end

end

