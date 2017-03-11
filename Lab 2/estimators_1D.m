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


%% Exponential


%% Uniform


%% Non-parametric estimation
% Parzen method with Gaussian windows having std deviation 0.1 and 0.4

N = size(a, 2);

y = zeros(size(a));

min_val = min(a(1,:))-1;
max_val = max(a(1,:))+1;

x = min_val:0.01:max_val;
norm = normpdf(x,mu_a,sd_a);

p_hat1 = parzen1(a,x,N,0.1);
p_hat2 = parzen1(a,x,N,0.4);

figure(1);
hold on;
scatter(a,y);
plot(x,norm);
plot(x,p_hat1);
plot(x,p_hat2);
hold off;

%% Set B
N = size(b, 2);

y = zeros(size(b));

min_val = 0;
max_val = max(b(1,:))+1;

x = min_val:0.01:max_val;
exp = exppdf(x,1/lambda_b);

p_hat1 = parzen1(b,x,N,0.1);
p_hat2 = parzen1(b,x,N,0.4);

figure(2);
hold on;
scatter(b,y);
plot(x,exp);
plot(x,p_hat1);
plot(x,p_hat2);
hold off;




