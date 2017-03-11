% Calculates and plots all the 2D estimators
%
% March 18, 2017
%
% Brady Kieffer - 20517665
% Krishn Ramesh - 20521942
% Ramandeep Farmaha - 20516974
% Shubam Mehta - 20483061

clear;
close all;
load('lab2_2.mat');

%% Parametric Estimation


%% Non-Parametric Estimation

% Making a Gaussian window with variance of 400
k = 100;
mu = [k/2 k/2];
cov = [400 0; 0 400];
step = 1;

[X1,X2] = meshgrid(1:step:k);
win = mvnpdf([X1(:) X2(:)], mu, cov);
win = reshape(win,length(X2),length(X1));

lowx = min([min(al(:,1)), min(bl(:,1)), min(cl(:,1))]) - 5;
lowy = min([min(al(:,2)), min(bl(:,2)), min(cl(:,2))]) - 5;
highx = max([max(al(:,1)), max(bl(:,1)), max(cl(:,1))]) + 5;
highy = max([max(al(:,2)), max(bl(:,2)), max(cl(:,2))]) + 5;

% Defining the area of interest
res = [step lowx lowy highx  highy];

% Calculating distributions
[p_a, x_a, y_a] = parzen2(al,res, win);
[p_b, x_b, y_b] = parzen2(bl,res, win);
[p_c, x_c, y_c] = parzen2(cl,res, win);

figure(1);
hold on;
scatter(al(:,1),al(:,2));
contour(x_a,y_a,p_a);
scatter(bl(:,1),bl(:,2));
contour(x_b,y_b,p_b);
scatter(cl(:,1),cl(:,2));
contour(x_c,y_c,p_c);
hold off;

[X2,Y2] = meshgrid(x_a, y_a);
ML = zeros(size(X2));
for i = 1:size(X2,1)
   for j = 1:size(Y2,2)
       class = classify_point(p_a(i,j), p_b(i,j), p_c(i,j));
       ML(i,j) = class;
   end
end

figure(2);
hold on;

% Defining a color map for the regions
% red = class A
% blue = class B
% dark grey = class C
map = [
    1, 0.5, 0.5
    0.5,0.5,1
    0.6,0.6,0.6];
colormap(map);

% Plotting MAP decision boundary in black
contourf(X2, Y2, ML, 'Color', 'black');

class_c = scatter(al(:, 1), al(:, 2), 'rx');
class_d = scatter(bl(:, 1), bl(:, 2), 'bo');
class_e = scatter(cl(:, 1), cl(:, 2), 'k+');

hold off;

%% Testing
