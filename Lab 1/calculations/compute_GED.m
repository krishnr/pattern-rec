% Computes the GED boundary for a 2D grid
%
% Febuary 12 2017
%
% Brady Kieffer - 20517665
% Krishn Ramesh - 20521942

%% Case 1
GED1 = GED(covar_a, mu_a, covar_b, mu_b, X1, Y1);

%% Case 2
GED_cd = GED(covar_c, mu_c, covar_d, mu_d, X2, Y2);
GED_ec = GED(covar_e, mu_e, covar_c, mu_c, X2, Y2);
GED_de = GED(covar_d, mu_d, covar_e, mu_e, X2, Y2);

% All classes
GED2 = zeros(size(X2, 1), size(Y2, 2));
for i=1:size(X2, 1)
    for j=1:size(Y2, 2)
        GED2(i, j) = classify_point(GED_cd(i, j), GED_de(i, j), GED_ec(i, j));
    end
end