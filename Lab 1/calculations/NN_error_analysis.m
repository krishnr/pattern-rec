%% Nearest Neighbour Error Analysis

%%%%%% Class 1 %%%%%%%

% Confusion matrix
[TA, FA] = get_error(n_a, NN(1, samples_a, samples_b, test_a), @(d) d < 0);
[TB, FB] = get_error(n_b, NN(1, samples_a, samples_b, test_b), @(d) d > 0);

% P(error)
P_error_1 = (FA + FB) / (n_a + n_b);

NN_conf_matrix_ab = [
    [TA, FB];
    [FA, TB];
];
disp('Confusion matrix for A & B:');
disp(NN_conf_matrix_ab);

disp('P_error for A & B:');
disp(P_error_1);

%%%%%% Class 2 %%%%%%%
% combining the NNs to classify every point
NN_cd_sample_c = NN(1, samples_c, samples_d, test_c);
NN_de_sample_c = NN(1, samples_d, samples_e, test_c);
NN_ec_sample_c = NN(1, samples_e, samples_c, test_c);


NN_cd_sample_d = NN(1, samples_c, samples_d, test_d);
NN_de_sample_d = NN(1, samples_d, samples_e, test_d);
NN_ec_sample_d = NN(1, samples_e, samples_c, test_d);


NN_cd_sample_e = NN(1, samples_c, samples_d, test_e);
NN_de_sample_e = NN(1, samples_d, samples_e, test_e);
NN_ec_sample_e = NN(1, samples_e, samples_c, test_e);

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
   class = cp(NN_cd_sample_c(i), NN_de_sample_c(i), NN_ec_sample_c(i));
   if class == 1
       TC = TC + 1;
   elseif class == 2
       FD_C = FD_C + 1;
   elseif class == 3
       FE_C = FE_C + 1;
   end
end

for i = 1:length(samples_d)
   class = cp(NN_cd_sample_d(i), NN_de_sample_d(i), NN_ec_sample_d(i));
   if class == 1
       FC_D = FC_D + 1;
   elseif class == 2
       TD = TD + 1;
   elseif class == 3
       FE_D = FE_D + 1;
   end
end

for i = 1:length(samples_e)
   class = cp(NN_cd_sample_e(i), NN_de_sample_e(i), NN_ec_sample_e(i));
   if class == 1
       FC_E = FC_E + 1;
   elseif class == 2
       FD_E = FD_E + 1;
   elseif class == 3
       TE = TE + 1;
   end
end

NN_conf_matrix_cde = [
    [TC, FD_C, FE_C];
    [FC_D, TD, FE_D];
    [FC_E, FD_E, TE];
];

disp('Confusion matrix for C, D & E:');
disp(NN_conf_matrix_cde);

disp('P_error for C, D & E:');
disp(1 - ((TC + TE + TD) / (n_c + n_d + n_e)));
