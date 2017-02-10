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
