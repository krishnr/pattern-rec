% MAP Classifier
%
% Febuary 12 2017
%
% Krishn Ramesh - 20521942

%% Case 1

% Generating the params of the MAP decision boundary
Q0 = inv(covar_a) - inv(covar_b);
Q1 = 2*(mu_b*inv(covar_b) - mu_a*inv(covar_a));
Q2 = mu_a*inv(covar_a)*mu_a' - mu_b*inv(covar_b)*mu_b';
Q3 = log(n_a/n_b);
Q4 = log(det(covar_a)/det(covar_b));

%% Generating a 2D grid and classifying all the points using MAP boundary
x = -5:20;
y = 0:25;
[X1,Y1] = meshgrid(x,y);
MAP1 = zeros(size(Y1));

for i = 1:length(X1)
   for j = 1:length(X1)
       point = [X1(i,j),Y1(i,j)];
       MAP_val = point*Q0*point' + Q1*point' + Q2 + 2*Q3 + Q4;
       MAP1(i,j) = sign(MAP_val);
   end
end