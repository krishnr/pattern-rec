% Main Script for Lab 1
%
% Plots all the classes and classifiers 
%
% Febuary 12 2017
%
% Brady Kieffer - 20517665
% Krishn Ramesh - 20521942

%% Creates the samples for each class

clear;

% Set the random state for consistency
rng(420);

class_data;

samples_a = bivariate_normal(n_a, covar_a, mu_a);
samples_b = bivariate_normal(n_b, covar_b, mu_b);

samples_c = bivariate_normal(n_c, covar_c, mu_c);
samples_d = bivariate_normal(n_d, covar_d, mu_d);
samples_e = bivariate_normal(n_e, covar_e, mu_e);

%% Computing the classifiers
x = -5:20;
y = 0:25;
[X1,Y1] = meshgrid(x,y);

x = -5:25;
y = -30:50;
[X2,Y2] = meshgrid(x,y);

MAP;
GED;

%% Case 1
close all;

figure(1);
hold on;

% Plotting a scatter plot of both classes
samples_a_scatter = scatter(samples_a(:, 1), samples_a(:, 2), 'rx');
samples_b_scatter = scatter(samples_b(:, 1), samples_b(:, 2), 'bo');

% Plotting the means in green
plot(mu_a(1), mu_a(2), 'gx');
plot(mu_b(1), mu_b(2), 'go');

% Plotting the unit std dev ellipse for each class
theta_a = atan(eig_vecs_a(2,2)/eig_vecs_a(2,1));
plot_ellipse(mu_a(1),mu_a(2), theta_a,covar_a(1,1),covar_a(2,2), 'r');

theta_b = atan(eig_vecs_b(2,2)/eig_vecs_b(2,1));
plot_ellipse(mu_b(1),mu_b(2), theta_b,covar_b(1,1),covar_b(2,2), 'b');

% Plotting the MAP decision boundary
contour(X1,Y1,MAP1,[0,0], 'Color', 'black', 'LineWidth', 3);

% Plotting the GED descision boundary
contour(X1,Y1,GED1,[0,0], 'Color', 'cyan', 'LineWidth', 3);

hold off;

title('Plot of Samples of Class A and Class B');
legend('Class A', 'Class B', 'Location', 'northeast');

%% Case 2
figure(2);
hold on;

map = [1, 0.5, 0.5
    0.5,0.5,1
    0.6,0.6,0.6];
colormap(map);
contourf(X2,Y2,MAP2);


% Plotting a scatter plot of all 3 classes
class_c = scatter(samples_c(:, 1), samples_c(:, 2), 'rx');
class_d = scatter(samples_d(:, 1), samples_d(:, 2), 'bo');
class_e = scatter(samples_e(:, 1), samples_e(:, 2), 'k+');

% Plotting the means in green
plot(mu_c(1), mu_c(2), 'gx');
plot(mu_d(1), mu_d(2), 'go');
plot(mu_e(1), mu_e(2), 'g+');

% Plotting the unit std dev ellipses of all classes
theta_c = atan(eig_vecs_c(1,2)/eig_vecs_c(1,1));
plot_ellipse(mu_c(1),mu_c(2), theta_c,covar_c(1,1),covar_c(2,2), 'r');

theta_d = atan(eig_vecs_d(1,2)/eig_vecs_d(1,1));
plot_ellipse(mu_d(1),mu_d(2), theta_d,covar_d(1,1),covar_d(2,2), 'b');

theta_e = atan(eig_vecs_e(1,2)/eig_vecs_e(1,1));
plot_ellipse(mu_e(1),mu_e(2), theta_e,covar_e(1,1),covar_e(2,2), 'k');

% contour(X2,Y2,MAP_cd,[0,0], 'Color', 'black', 'LineWidth', 3);
% contour(X2,Y2,MAP_de,[0,0], 'Color', 'blue', 'LineWidth', 3);
% contour(X2,Y2,MAP_ec,[0,0], 'Color', 'red', 'LineWidth', 3);

title('Classification of Samples of Class C, Class D & Class E');
legend([class_c,class_d,class_e], {'Class C', 'Class D', 'Class E'}, 'Location', 'northeast');
hold off;