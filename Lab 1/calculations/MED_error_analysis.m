%% MAP Error Analysis

%%%%%% Class 1 %%%%%%%

% Confusion matrix
[TA, FA] = get_error(n_a, MED(mu_a, mu_b, samples_a), @(d) d < 0);
[TB, FB] = get_error(n_b, MED(mu_a, mu_b, samples_b), @(d) d > 0);

MED_conf_matrix_ab = [
    [TA, FB];
    [FA, TB];
];
disp('Confusion matrix for A & B:');
disp(MED_conf_matrix_ab);

P_error_1 = (FA + FB)/(n_a + n_b);

disp('P_error for A & B:');
disp(P_error_1);

%%%%%% Class 2 %%%%%%%
% combining the maps to classify every point
MED_cd_sample_c = MED(mu_c, mu_d, samples_c);
MED_de_sample_c = MED(mu_d, mu_e, samples_c);
MED_ec_sample_c = MED(mu_e, mu_c, samples_c);


MED_cd_sample_d = MED(mu_c, mu_d, samples_d);
MED_de_sample_d = MED(mu_d, mu_e, samples_d);
MED_ec_sample_d = MED(mu_e, mu_c, samples_d);


MED_cd_sample_e = MED(mu_c, mu_d, samples_e);
MED_de_sample_e = MED(mu_d, mu_e, samples_e);
MED_ec_sample_e = MED(mu_e, mu_c, samples_e);

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
   class = cp(MED_cd_sample_c(i), MED_de_sample_c(i), MED_ec_sample_c(i));
   if class == 1
       TC = TC + 1;
   elseif class == 2
       FD_C = FD_C + 1;
   elseif class == 3
       FE_C = FE_C + 1;
   end
end

for i = 1:length(samples_d)
   class = cp(MED_cd_sample_d(i), MED_de_sample_d(i), MED_ec_sample_d(i));
   if class == 1
       FC_D = FC_D + 1;
   elseif class == 2
       TD = TD + 1;
   elseif class == 3
       FE_D = FE_D + 1;
   end
end

for i = 1:length(samples_e)
   class = cp(MED_cd_sample_e(i), MED_de_sample_e(i), MED_ec_sample_e(i));
   if class == 1
       FC_E = FC_E + 1;
   elseif class == 2
       FD_E = FD_E + 1;
   elseif class == 3
       TE = TE + 1;
   end
end

MED_conf_matrix_cde = [
    [TC, FD_C, FE_C];
    [FC_D, TD, FE_D];
    [FC_E, FD_E, TE];
];

disp('Confusion matrix for C, D & E:');
disp(MED_conf_matrix_cde);

correct_2 = (TC + TE + TD) / (n_c + n_d + n_e);
P_error_2 = 1 - correct_2;

disp('P(error) for C, D & E:');
disp(P_error_2);