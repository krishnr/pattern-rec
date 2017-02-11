%% MAP Error Analysis

%%%%%% Class 1 %%%%%%%

% P(error) using Mahalanobis distance
d_m = @(m_a, m_b, S) sqrt((m_a-m_b)*inv(S)*(m_a-m_b)');
P_error_1 = qfunc(0.5*d_m(mu_a,mu_b,covar_a));

% Confusion matrix
[TA, FA] = get_error(n_a, MAP(n_a, covar_a, mu_a, n_b, covar_b, mu_b, samples_a), @(d) d < 0);
[TB, FB] = get_error(n_b, MAP(n_b, covar_a, mu_a, n_b, covar_b, mu_b, samples_b), @(d) d > 0);

MAP_conf_matrix_ab = [
    [TA, FB];
    [FA, TB];
];
disp('Confusion matrix for A & B:');
disp(MAP_conf_matrix_ab);

disp('P_error for A & B:');
disp(P_error_1);

%%%%%% Class 2 %%%%%%%
% combining the maps to classify every point
MAP_cd_sample_c = MAP(n_c, covar_c, mu_c, n_d, covar_d, mu_d, samples_c);
MAP_de_sample_c = MAP(n_d, covar_d, mu_d, n_e, covar_e, mu_e, samples_c);
MAP_ec_sample_c = MAP(n_e, covar_e, mu_e, n_c, covar_c, mu_c, samples_c);


MAP_cd_sample_d = MAP(n_c, covar_c, mu_c, n_d, covar_d, mu_d, samples_d);
MAP_de_sample_d = MAP(n_d, covar_d, mu_d, n_e, covar_e, mu_e, samples_d);
MAP_ec_sample_d = MAP(n_e, covar_e, mu_e, n_c, covar_c, mu_c, samples_d);


MAP_cd_sample_e = MAP(n_c, covar_c, mu_c, n_d, covar_d, mu_d, samples_e);
MAP_de_sample_e = MAP(n_d, covar_d, mu_d, n_e, covar_e, mu_e, samples_e);
MAP_ec_sample_e = MAP(n_e, covar_e, mu_e, n_c, covar_c, mu_c, samples_e);

cp = @classify_point;

TC = 0;
TD = 0;
TE = 0;

FD_C = 0;
FE_C = 0;

FC_D = 0;
FE_D = 0;

FC_E = 0;
FD_E = 0;

% Confusion matrix of the form:
%       Predicted:    C       D     E
% Actual:         C [ TC   FD_C  FE_C ]
%                 D [ FC_D   TD  FE_D ]
%                 E [ FC_E FD_E    TE ]

for i = 1:length(samples_c)
   class = cp(MAP_cd_sample_c(i), MAP_de_sample_c(i), MAP_ec_sample_c(i));
   if class == 1
       TC = TC + 1;
   elseif class == 2
       FD_C = FD_C + 1;
   elseif class == 3
       FE_C = FE_C + 1;
   end
end

for i = 1:length(samples_d)
   class = cp(MAP_cd_sample_d(i), MAP_de_sample_d(i), MAP_ec_sample_d(i));
   if class == 1
       FC_D = FC_D + 1;
   elseif class == 2
       TD = TD + 1;
   elseif class == 3
       FE_D = FE_D + 1;
   end
end

for i = 1:length(samples_e)
   class = cp(MAP_cd_sample_e(i), MAP_de_sample_e(i), MAP_ec_sample_e(i));
   if class == 1
       FC_E = FC_E + 1;
   elseif class == 2
       FD_E = FD_E + 1;
   elseif class == 3
       TE = TE + 1;
   end
end

MAP_conf_matrix_cde = [
    [TC, FD_C, FE_C];
    [FC_D, TD, FE_D];
    [FC_E, FD_E, TE];
];

disp('Confusion matrix for C, D & E:');
disp(MAP_conf_matrix_cde);

disp('Percent Correct for C, D & E:');
disp((TC + TE + TD) / (n_c + n_d + n_e) * 100.0);

