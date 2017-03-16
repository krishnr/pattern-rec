% Calculates and plots all the sequential discriminants
%
% March 18, 2017
%
% Brady Kieffer - 20517665
% Krishn Ramesh - 20521942
% Ramandeep Farmaha - 20516974
% Shubam Mehta - 20483061

clear;
close all;
load('lab2_3.mat');

J = 5;
limit = 20;
step = 1;

lowx = min([min(a(:,1)), min(b(:,1))]) - 10;
lowy = min([min(a(:,2)), min(b(:,2))]) - 10;
highx = max([max(a(:,1)), max(b(:,1))]) + 10;
highy = max([max(a(:,1)), max(b(:,1))]) + 10;

[X1, Y1] = meshgrid(lowx:step:highx, lowy:step:highy);

discriminant_list = zeros(J,size(X1,1),size(X1,2));

error_list = zeros(J, limit);

set_a = a;
set_b = b;

n_ab = 1;
n_ba = 1;

for j=1:J
    j
    
    % no points in A that are misclassified as B, so remove correctly
    % classified points in B
    if (n_ab == 0)
        %TODO
    end
    
    % no points in B that are misclassified as A, so remove correctly
    % classified points in A
    if (n_ba == 0)
        %TODO
    end
    
    % matlab doesn't have do-whiles so have to initialize these to 1
    n_ab = 1;
    n_ba = 1;
    
    num_tries = 1;
    
    % repeat while there's still misclassified points AND we're under the
    % limit AND neither set is empty
    while(n_ab > 0 && n_ba > 0 && num_tries <= limit && ~isempty(set_a) && ~isempty(set_b))       
        % Set random points as the mean prototype
        r1 = randi([1 length(set_a)]);
        r2 = randi([1 length(set_b)]);
        mu_a = a(r1,:);
        mu_b = b(r2,:);
        
        % Build an MED discriminant
        discriminant = MED(mu_a,mu_b,X1,Y1);
        
        % Check for misclassified points
        n_ab = 0;
        n_ba = 0;
        for i=1:length(set_a)
            if interp2(X1,Y1,discriminant,set_a(i,1),set_a(i,2)) < 0
                n_ab = n_ab + 1;
            end
        end
        
        for i=1:length(b)
            if interp2(X1,Y1,discriminant,set_b(i,1),set_b(i,2)) > 0
                n_ba = n_ba + 1;
            end
        end
        
        error_list(j, num_tries) = n_ab + n_ba;        
        
        num_tries
        num_tries = num_tries + 1;
    end
    
    % Discriminant is perfect or 20 discriminants have been tried; save it
    discriminant_list(j,:,:) = discriminant;
end

%% Error Calculations
avg_error_rate = zeros(1,J); 
min_error_rate = zeros(1,J); 
max_error_rate = zeros(1,J); 
std_error_rate = zeros(1,J);
total = length(a)+length(b);

for j=1:J
   avg_error_rate(j) = sum(error_list(j,:))/limit/total;
   min_error_rate(j) = min(error_list(j,:))/total;
   max_error_rate(j) = max(error_list(j,:))/total;
   std_error_rate(j) = std(error_list(j,:));
end

%% Plots
subplot(4,1,1);
plot(1:J, avg_error_rate, 'o-','linewidth',2,'markersize',5,'markerfacecolor','r');
title('Average Error Rate');
subplot(4,1,2);
plot(1:J, min_error_rate, 'o-','linewidth',2,'markersize',5,'markerfacecolor','r');
title('Min Error Rate');
subplot(4,1,3);
plot(1:J, max_error_rate, 'o-','linewidth',2,'markersize',5,'markerfacecolor','r');
title('Max Error Rate');
subplot(4,1,4);
plot(1:J, std_error_rate, 'o-','linewidth',2,'markersize',5,'markerfacecolor','r');
title('Standard Deviation of Errors');