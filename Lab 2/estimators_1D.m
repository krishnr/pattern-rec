% Calculates and plots all the 1D estimators
%
% March 18, 2017
%
% Brady Kieffer - 20517665
% Krishn Ramesh - 20521942
% Ramandeep Farmaha - 20516974
% Shubam Mehta - 20483061

clear;
close all;
load('lab2_1.mat');

mu_a = 5;
sd_a = 1;

lambda_b = 1;

%% Gaussian
% Set A
y = zeros(size(a));

min_val = 0;
max_val = max(a(1,:))+1;

x = min_val:0.01:max_val;
[mu_est, sigma_est] = gaussian1(a);

norm = normpdf(x,mu_a,sd_a);
norm_est = normpdf(x,mu_est, sigma_est);
figure(5);
hold on;
scatter(a,y);
plot(x,norm);
plot(x,norm_est);
title('Gaussian Estimate of Gaussian Distribution');
strmu = ['\mu_{est}=', num2str(mu_est)];
strsd = ['\sigma_{est}=', num2str(sigma_est)];
text(9.0, 0.35, strmu, 'HorizontalAlignment', 'center');
text(9.0, 0.32, strsd, 'HorizontalAlignment', 'center');
grid on;
hold off;

% Set B
y = zeros(size(b));

min_val = 0;
max_val = max(b(1,:))+1;

x = min_val:0.01:max_val;
exp = exppdf(x,1/lambda_b);

[mu_est, sigma_est] = gaussian1(b);
norm_est = normpdf(x,mu_est, sigma_est);

figure(6);
hold on;
scatter(b,y);
plot(x,exp);
plot(x,norm_est);
title('Gaussian Estimate of Exponential Distribution');
strmu = ['\mu_{est}=', num2str(mu_est)];
strsd = ['\sigma_{est}=', num2str(sigma_est)];
text(5.0, 0.90, strmu, 'HorizontalAlignment', 'center');
text(5.0, 0.85, strsd, 'HorizontalAlignment', 'center');
grid on;
hold off;

%% Parametric Estimation - Exponential
% Set A

y = zeros(size(a));

min_val = 0;
max_val = max(a(1,:))+1;

x = min_val:0.01:max_val;
norm = normpdf(x,mu_a,sd_a);

lambda_est = exponential1(a);
exp_est = exppdf(x, 1/lambda_est);

figure(1);
hold on;
scatter(a,y);
plot(x,norm);
plot(x,exp_est);
hold off;

% Set B
y = zeros(size(b));

min_val = 0;
max_val = max(b(1,:))+1;

x = min_val:0.01:max_val;
exp = exppdf(x,1/lambda_b);

lambda_est = exponential1(b);
exp_est = exppdf(x, 1/lambda_est);

figure(2);
hold on;
scatter(b,y);
plot(x,exp);
plot(x,exp_est);
hold off;

%% Uniform
% Set A

y = zeros(size(a));

min_val = 0;
max_val = max(a(1,:))+1;

x = min_val:0.01:max_val;
norm = normpdf(x,mu_a,sd_a);

[a_est_a, b_est_a] = uniform(a);
uniform_a = unifpdf(x, a_est_a, b_est_a);

figure(3);
hold on;
scatter(a,y);
plot(x,norm);
plot(x,uniform_a);
hold off;

% Set B
y = zeros(size(b));

min_val = 0;
max_val = max(b(1,:))+1;

x = min_val:0.01:max_val;
exp = exppdf(x,1/lambda_b);

[a_est_b, b_est_b] = uniform(b);
uniform_b = unifpdf(x, a_est_b, b_est_b);

figure(4);
hold on;
scatter(b,y);
plot(x,exp);
plot(x,uniform_b);
hold off;


%% Non-parametric estimation
% Parzen method with Gaussian windows having std deviation 0.1 and 0.4
% Set A

N = length(a);

y = zeros(size(a));

min_val = min(a(1,:))-1;
max_val = max(a(1,:))+1;

x = min_val:0.01:max_val;
norm = normpdf(x,mu_a,sd_a);

p_hat1 = parzen1(a,x,N,0.1);
p_hat2 = parzen1(a,x,N,0.4);

figure(5);
hold on;
scatter(a,y);
plot(x,norm);
plot(x,p_hat1);
plot(x,p_hat2);
hold off;

% Set B
N = length(b);

y = zeros(size(b));

min_val = 0;
max_val = max(b(1,:))+1;

x = min_val:0.01:max_val;
exp = exppdf(x,1/lambda_b);

p_hat1 = parzen1(b,x,N,0.1);
p_hat2 = parzen1(b,x,N,0.4);

figure(6);
hold on;
scatter(b,y);
plot(x,exp);
plot(x,p_hat1);
plot(x,p_hat2);
hold off;




