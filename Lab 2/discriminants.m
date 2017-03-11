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

J = 1;
step = 1;

lowx = min([min(a(:,1)), min(b(:,1))]) - 10;
lowy = min([min(a(:,2)), min(b(:,2))]) - 10;
highx = max([max(a(:,1)), max(b(:,1))]) + 10;
highy = max([max(a(:,1)), max(b(:,1))]) + 10;

[X1, Y1] = meshgrid(lowx:step:highx, lowy:step:highy);

discriminant_list = zeros(J,size(X1,1),size(X1,2));

for j=1:J
    n_ab = 1;
    n_ba = 1;
    while(n_ab > 0 && n_ba > 0)       
        % Set random points as the mean prototype
        r = randi([1 length(a)],1,2);
        mu_a = a(r(1),:);
        mu_b = b(r(2),:);
        
        % Build an MED discriminant
        discriminant = MED(mu_a,mu_b,X1,Y1);
        
        % Check for misclassified points
        n_ab = 0;
        n_ba = 0;
        for i=1:length(a)
            if interp2(X1,Y1,discriminant,a(i,1),a(i,2)) < 0
                n_ab = n_ab + 1;
            end
        end
        
        for i=1:length(b)
            if interp2(X1,Y1,discriminant,a(i,1),a(i,2)) > 0
                n_ba = n_ba + 1;
            end
        end
    end
    
    % Discriminant is perfect, save it
    discriminant_list(j,:,:) = discriminant;
end