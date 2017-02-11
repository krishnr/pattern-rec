%% GED


%% MED


%% kNN


%% MAP

%%%%%% Class 1 %%%%%%%

% Mahalanobis distance
d_m = @(m_a, m_b, S) sqrt((m_a-m_b)*inv(S)*(m_a-m_b)');
P_error_1 = qfunc(0.5*d_m(mu_a,mu_b,covar_a))

% Confusion matrix

Q0 = inv(covar_a) - inv(covar_b);
Q1 = 2*(mu_b*inv(covar_b) - mu_a*inv(covar_a));
Q2 = mu_a*inv(covar_a)*mu_a' - mu_b*inv(covar_b)*mu_b';
Q3 = log(n_b/n_a);
Q4 = log(det(covar_a)/det(covar_b));

A_correct = 0;
B_correct = 0;

for i = 1:length(samples_a)
    point = samples_a(i,:);
    MAP_val = point*Q0*point' + Q1*point' + Q2 + 2*Q3 + Q4;
    if MAP_val < 0
        A_correct = A_correct + 1;
    end
end

for i = 1:length(samples_b)
    point = samples_b(i,:);
    MAP_val = point*Q0*point' + Q1*point' + Q2 + 2*Q3 + Q4;
    if MAP_val > 0
        B_correct = B_correct + 1;
    end
end

A_correct
A_incorrect = length(samples_a) - A_correct
B_correct
B_incorrect = length(samples_b) - B_correct


%%%%%% Class 2 %%%%%%%


% Confusion Matrix
% C vs D
Q0 = inv(covar_c) - inv(covar_d);
Q1 = 2*(mu_d*inv(covar_d) - mu_c*inv(covar_c));
Q2 = mu_c*inv(covar_c)*mu_c' - mu_d*inv(covar_d)*mu_d';
Q3 = log(n_d/n_c);
Q4 = log(det(covar_c)/det(covar_d));

MAP_cd_sample_c = zeros(size(samples_c,1), size(samples_c,2));

for i = 1:length(samples_c)
   point = samples_c(i,:);
   MAP_val = point*Q0*point' + Q1*point' + Q2 + 2*Q3 + Q4;
   MAP_cd_sample_c(i) = MAP_val;
end

MAP_cd_sample_d = zeros(size(samples_d,1), size(samples_d,2));

for i = 1:length(samples_d)
   point = samples_d(i,:);
   MAP_val = point*Q0*point' + Q1*point' + Q2 + 2*Q3 + Q4;
   MAP_cd_sample_d(i) = MAP_val;
end

MAP_cd_sample_e = zeros(size(samples_e,1), size(samples_e,2));

for i = 1:length(samples_e)
   point = samples_e(i,:);
   MAP_val = point*Q0*point' + Q1*point' + Q2 + 2*Q3 + Q4;
   MAP_cd_sample_e(i) = MAP_val;
end

% D vs E
Q0 = inv(covar_d) - inv(covar_e);
Q1 = 2*(mu_e*inv(covar_e) - mu_d*inv(covar_d));
Q2 = mu_d*inv(covar_d)*mu_d' - mu_e*inv(covar_e)*mu_e';
Q3 = log(n_e/n_d);
Q4 = log(det(covar_d)/det(covar_e));

MAP_de_sample_c = zeros(size(samples_c,1), size(samples_c,2));

for i = 1:length(samples_c)
   point = samples_c(i,:);
   MAP_val = point*Q0*point' + Q1*point' + Q2 + 2*Q3 + Q4;
   MAP_de_sample_c(i) = MAP_val;
end

MAP_de_sample_d = zeros(size(samples_d,1), size(samples_d,2));

for i = 1:length(samples_d)
   point = samples_d(i,:);
   MAP_val = point*Q0*point' + Q1*point' + Q2 + 2*Q3 + Q4;
   MAP_de_sample_d(i) = MAP_val;
end

MAP_de_sample_e = zeros(size(samples_e,1), size(samples_e,2));

for i = 1:length(samples_e)
   point = samples_e(i,:);
   MAP_val = point*Q0*point' + Q1*point' + Q2 + 2*Q3 + Q4;
   MAP_de_sample_e(i) = MAP_val;
end

% E vs C
Q0 = inv(covar_e) - inv(covar_c);
Q1 = 2*(mu_c*inv(covar_c) - mu_e*inv(covar_e));
Q2 = mu_e*inv(covar_e)*mu_e' - mu_c*inv(covar_c)*mu_c';
Q3 = log(n_c/n_e);
Q4 = log(det(covar_e)/det(covar_c));

MAP_ec_sample_c = zeros(size(samples_c,1), size(samples_c,2));

for i = 1:length(samples_c)
   point = samples_c(i,:);
   MAP_val = point*Q0*point' + Q1*point' + Q2 + 2*Q3 + Q4;
   MAP_ec_sample_c(i) = MAP_val;
end

MAP_ec_sample_d = zeros(size(samples_d,1), size(samples_d,2));

for i = 1:length(samples_d)
   point = samples_d(i,:);
   MAP_val = point*Q0*point' + Q1*point' + Q2 + 2*Q3 + Q4;
   MAP_ec_sample_d(i) = MAP_val;
end

MAP_ec_sample_e = zeros(size(samples_e,1), size(samples_e,2));

for i = 1:length(samples_e)
   point = samples_e(i,:);
   MAP_val = point*Q0*point' + Q1*point' + Q2 + 2*Q3 + Q4;
   MAP_ec_sample_e(i) = MAP_val;
end


% combining the maps to classify every point
C_correct = 0;
D_correct = 0;
E_correct = 0;

cp = @classify_point;
for i = 1:length(samples_c)
   class = cp(MAP_cd_sample_c(i), MAP_de_sample_c(i), MAP_ec_sample_c(i));
   if class == 1
       C_correct = C_correct + 1;
   end
end

for i = 1:length(samples_d)
   class = cp(MAP_cd_sample_d(i), MAP_de_sample_d(i), MAP_ec_sample_d(i));
   if class == 2
       D_correct = D_correct + 1;
   end
end

for i = 1:length(samples_e)
   class = cp(MAP_cd_sample_e(i), MAP_de_sample_e(i), MAP_ec_sample_e(i));
   if class == 3
       E_correct = E_correct + 1;
   end
end

C_correct
C_incorrect = length(samples_c) - C_correct
D_correct
D_incorrect = length(samples_d) - D_correct
E_correct
E_incorrect = length(samples_e) - E_correct