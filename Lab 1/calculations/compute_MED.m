% Computes the GED boundary for a 2D grid
%
% Febuary 12 2017
%
% Shubam Mehta - 20483061

%% Case 1
MED1 = MED(mu_a, mu_b, X1, Y1);

%% Case 2
MED_cd = MED(mu_c, mu_d, X2, Y2);
MED_ec = MED(mu_e, mu_c, X2, Y2);
MED_de = MED(mu_d, mu_e, X2, Y2);

% All classes
MED2 = zeros(size(X2, 1), size(Y2, 2));
for i=1:size(X2, 1)
    for j=1:size(Y2, 2)
        MED2(i, j) = classify_point(MED_cd(i, j), MED_de(i, j), MED_ec(i, j));
    end
end