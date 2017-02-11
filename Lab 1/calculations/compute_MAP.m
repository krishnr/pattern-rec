% Computes the GED boundary for a 2D grid
%
% Febuary 12 2017
%
% Krishn Ramesh - 20521942

%% Case 1
MAP1 = MAP(n_a, covar_a, mu_a, n_b, covar_b, mu_b, X1, Y1);

%% Case 2

% Strategy is to first determine C vs D
% then D vs E
% then C vs E

MAP_cd = MAP(n_c, covar_c, mu_c, n_d, covar_d, mu_d, X2, Y2);
MAP_de = MAP(n_d, covar_d, mu_d, n_e, covar_e, mu_e, X2, Y2);
MAP_ec = MAP(n_e, covar_e, mu_e, n_c, covar_c, mu_c, X2, Y2);

% combining the maps to classify every point
MAP2 = zeros(size(X2,1), size(Y2,2));
for i = 1:size(X2,1)
   for j = 1:size(Y2,2)
       class = classify_point(MAP_cd(i,j), MAP_de(i,j), MAP_ec(i,j));
       MAP2(i,j) = class;
   end
end