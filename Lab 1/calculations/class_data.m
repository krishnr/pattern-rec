% Declare the data for each class
%
% Febuary 12 2017
%
% Brady Kieffer - 20517665
% Krishn Ramesh - 20521942

% Case 1
n_a = 200; 
mu_a = [5, 10];
covar_a = [8, 0; 0, 4];
[eig_vecs_a, eig_vals_a] = eig(covar_a); 

n_b = 200; 
mu_b = [10, 15];
covar_b = [8, 0; 0, 4];
[eig_vecs_b, eig_vals_b] = eig(covar_b); 

% Case 2
n_c = 100; 
mu_c = [5, 10];
covar_c = [8, 4; 4, 40];
[eig_vecs_c, eig_vals_c] = eig(covar_c);

n_d = 200; 
mu_d = [15, 10];
covar_d = [8, 0; 0, 8];
[eig_vecs_d, eig_vals_d] = eig(covar_d);

n_e = 150; 
mu_e = [10, 5];
covar_e = [10, -5; -5, 20];
[eig_vecs_e, eig_vals_e] = eig(covar_e);