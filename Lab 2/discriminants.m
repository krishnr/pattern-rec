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

discriminant_list = zeros(J,limit,size(X1,1), size(X1,2));

num_tries = ones(J,1);

misclassified = zeros(J, limit);

set_a = a;
set_b = b;

% matlab doesn't have do-whiles so have to initialize these to 1
n_ab = ones(J,1);
n_ba = ones(J,1);

for j=1:J
    j
    
    % repeat while there's still misclassified points AND we're under the
    % limit AND neither set is empty
    while(n_ab(j) > 0 && n_ba(j) > 0 && num_tries(j) <= limit && ~isempty(set_a) && ~isempty(set_b))       
        % Set random points as the mean prototype
        r1 = randi([1 length(set_a)]);
        r2 = randi([1 length(set_b)]);
        mu_a = a(r1,:);
        mu_b = b(r2,:);
        
        % Build an MED discriminant
        discriminant = MED(mu_a,mu_b,X1,Y1);
        
        % Check for misclassified points
        n_ab(j) = 0;
        for i=1:length(set_a)
            if interp2(X1,Y1,discriminant,set_a(i,1),set_a(i,2)) > 0
                n_ab(j) = n_ab(j) + 1;
            end
        end
        
        n_ba(j) = 0;
        for i=1:length(set_b)
            if interp2(X1,Y1,discriminant,set_b(i,1),set_b(i,2)) < 0
                n_ba(j) = n_ba(j) + 1;
            end
        end
        
        % Store the total error for this try
        misclassified(j, num_tries(j)) = n_ab(j) + n_ba(j);        
        
        num_tries(j)
        num_tries(j) = num_tries(j) + 1;
        
        discriminant_list(j,num_tries(j),:,:) = discriminant;
    end
    
    % no points in A that are misclassified as B, so remove correctly
    % classified points in B
    if (n_ab(j) == 0)
        set_b = set_b(interp2(X1,Y1,discriminant,set_b(:,1),set_b(:,2)) < 0,:);
    end
    
    % no points in B that are misclassified as A, so remove correctly
    % classified points in A
    if (n_ba(j) == 0)
        set_a = set_a(interp2(X1,Y1,discriminant,set_a(:,1),set_a(:,2)) > 0,:);
    end
    
    n_ab(j)
    n_ba(j)
    length(set_a)
    length(set_b)
end

%% Error Calculations
avg_error_rate = zeros(1,J); 
min_error_rate = zeros(1,J); 
max_error_rate = zeros(1,J); 
std_error_rate = zeros(1,J);
total = length(a)+length(b);
wrong = zeros(J,limit);
test_a = zeros(1, length(a));
test_b = zeros(1, length(b));

for j=1:J
    for k = 1:num_tries(j)
        for i=1:length(a)
            discriminant = squeeze(discriminant_list(j,k,:,:));

            % Classified correctly as A
            if test_a(i) == 0 && interp2(X1,Y1,discriminant,a(i,1),a(i,2)) < 0 && n_ba(j) == 0
                test_a(i) = 1;
            end

            % Classified correctly as B
            if test_b(i) == 0 && interp2(X1,Y1,discriminant,b(i,1),b(i,2)) > 0 && n_ab(j) == 0
                test_b(i) = 1;
            end
        end

        % counts all points that were not classified or misclassified
        wrong(j,k) = length(test_a(test_a == 0)) + length(test_b(test_b==0));
    end
    
    avg_error_rate(j) = sum(wrong(j,1:num_tries(j)))/num_tries(j)/total;
    min_error_rate(j) = min(wrong(j,1:num_tries(j)))/total;
    max_error_rate(j) = max(wrong(j,1:num_tries(j)))/total;
    std_error_rate(j) = std(wrong(j,1:num_tries(j)));
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