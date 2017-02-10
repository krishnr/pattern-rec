% Computes the GED boundary for a 2D grid
%
% Febuary 12 2017
%
% Krishn Ramesh - 20521942

%% Case 1

% Generating the params of the MAP decision boundary
Q0 = inv(covar_a) - inv(covar_b);
Q1 = 2*(mu_b*inv(covar_b) - mu_a*inv(covar_a));
Q2 = mu_a*inv(covar_a)*mu_a' - mu_b*inv(covar_b)*mu_b';
Q3 = log(n_b/n_a);
Q4 = log(det(covar_a)/det(covar_b));

MAP1 = zeros(size(Y1));

for i = 1:length(X1)
   for j = 1:length(X1)
       point = [X1(i,j),Y1(i,j)];
       MAP_val = point*Q0*point' + Q1*point' + Q2 + 2*Q3 + Q4;
       MAP1(i,j) = MAP_val;
   end
end

%% Case 2

% Strategy is to first determine C vs D
% then D vs E
% then C vs E

% C vs D
Q0 = inv(covar_c) - inv(covar_d);
Q1 = 2*(mu_d*inv(covar_d) - mu_c*inv(covar_c));
Q2 = mu_c*inv(covar_c)*mu_c' - mu_d*inv(covar_d)*mu_d';
Q3 = log(n_d/n_c);
Q4 = log(det(covar_c)/det(covar_d));

MAP_cd = zeros(size(X2,1), size(X2,2));

for i = 1:size(X2,1)
   for j = 1:size(X2,2)
       point = [X2(i,j),Y2(i,j)];
       MAP_val = point*Q0*point' + Q1*point' + Q2 + 2*Q3 + Q4;
       MAP_cd(i,j) = MAP_val;
   end
end

% D vs E
Q0 = inv(covar_d) - inv(covar_e);
Q1 = 2*(mu_e*inv(covar_e) - mu_d*inv(covar_d));
Q2 = mu_d*inv(covar_d)*mu_d' - mu_e*inv(covar_e)*mu_e';
Q3 = log(n_e/n_d);
Q4 = log(det(covar_d)/det(covar_e));

MAP_de = zeros(size(X2,1), size(X2,2));

for i = 1:size(X2,1)
   for j = 1:size(X2,2)
       point = [X2(i,j),Y2(i,j)];
       MAP_val = point*Q0*point' + Q1*point' + Q2 + 2*Q3 + Q4;
       MAP_de(i,j) = MAP_val;
   end
end

% E vs C
Q0 = inv(covar_e) - inv(covar_c);
Q1 = 2*(mu_c*inv(covar_c) - mu_e*inv(covar_e));
Q2 = mu_e*inv(covar_e)*mu_e' - mu_c*inv(covar_c)*mu_c';
Q3 = log(n_c/n_e);
Q4 = log(det(covar_e)/det(covar_c));

MAP_ec = zeros(size(X2,1), size(X2,2));

for i = 1:size(X2,1)
   for j = 1:size(X2,2)
       point = [X2(i,j),Y2(i,j)];
       MAP_val = point*Q0*point' + Q1*point' + Q2 + 2*Q3 + Q4;
       MAP_ec(i,j) = MAP_val;
   end
end


% combining the maps to classify every point

MAP2 = zeros(size(X2,1), size(X2,2));
cp = @classify_point;
for i = 1:size(X2,1)
   for j = 1:size(X2,2)
       class = cp(MAP_cd(i,j), MAP_de(i,j), MAP_ec(i,j));
       MAP2(i,j) = class;
   end
end