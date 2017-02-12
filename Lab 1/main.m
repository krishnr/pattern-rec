% Main Script for Lab 1
%
% Plots all the classes and classifiers 
%
% Febuary 12 2017
%
% Brady Kieffer - 20517665
% Krishn Ramesh - 20521942
% Ramandeep Farmaha - 20516974

%% Remove any variables and close all plots
clear;
close all;

% Set the random state for consistency
rng(420);

%% Add folders to the path so we can access functions
addpath('./functions', './calculations');

%% Creates the samples for each class
class_data;

samples_a = bivariate_normal(n_a, covar_a, mu_a);
samples_b = bivariate_normal(n_b, covar_b, mu_b);

samples_c = bivariate_normal(n_c, covar_c, mu_c);
samples_d = bivariate_normal(n_d, covar_d, mu_d);
samples_e = bivariate_normal(n_e, covar_e, mu_e);

%% Computing the classifiers
step = 0.5; % The lower this is the smoother the contours.
x = -5:step:20;
y = 0:step:25;
[X1, Y1] = meshgrid(x,y);

x = -5:step:25;
y = -30:step:50;
[X2, Y2] = meshgrid(x,y);

compute_MAP;
compute_GED;
compute_NN;
compute_KNN;

LINE_WIDTH = 2;

%% Case 1       
figure(1);
hold on;

map = [
    1, 0.5, 0.5
    0.5, 0.5, 1];
colormap(map);


% Plotting the MAP decision boundary
contourf(X1,Y1,MAP1, [-100, 0]);
% Plotting the MAP decision boundary
contour(X1,Y1,MAP1, [0, 0], 'Color', 'black', 'LineWidth', LINE_WIDTH);

% Plotting the GED descision boundary
contour(X1,Y1,GED1, [0, 0], 'Color', 'cyan', 'LineWidth', LINE_WIDTH);

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
hold off;

title('Plot of Samples of Class A and Class B');
legend([samples_a_scatter, samples_b_scatter], {'Class A', 'Class B'}, 'Location', 'northeast');

%% Case 1 Nearest Neighbour Plots      
figure(2);
hold on;

map = [
    1, 0.5, 0.5
    0.5, 0.5, 1];
colormap(map);


% Plotting the Nearest Neighbour boundaries
contour(X1,Y1,NN1, [0, 0], 'Color', 'black', 'LineWidth', LINE_WIDTH);
contour(X1,Y1,KNN1, [0, 0], 'Color', 'magenta', 'LineWidth', LINE_WIDTH);

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
hold off;

title('Plot of Samples of Class A and Class B with Nearest Neighbour Boundaries');
legend([samples_a_scatter, samples_b_scatter], {'Class A', 'Class B'}, 'Location', 'northeast');

%% Case 2
figure(3);
hold on;

% Defining a color map for the regions
% red = class C
% blue = class D
% dark grey = class E
map = [
    1, 0.5, 0.5
    0.5,0.5,1
    0.6,0.6,0.6];
colormap(map);

% Plotting MAP decision boundary in black
contourf(X2, Y2, MAP2, 'Color', 'black');

% Plotting GED decision boundary in cyan
contour(X2, Y2, GED2, 'Color', 'cyan');

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

title('Classification of Samples of Class C, Class D & Class E');
legend([class_c,class_d,class_e], {'Class C', 'Class D', 'Class E'}, 'Location', 'northeast');
hold off;

%% Case 2 Nearest Neighbour Plots
figure(4);
hold on;

% Defining a color map for the regions
% red = class C
% blue = class D
% dark grey = class E
map = [
    1, 0.5, 0.5
    0.5,0.5,1
    0.6,0.6,0.6];
colormap(map);

% Plotting MAP decision boundary in black
contourf(X2, Y2, NN2, 'Color', 'black');

% Plotting GED decision boundary in cyan
contour(X2, Y2, KNN2, 'Color', 'magenta');

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

title('Classification of Samples of Class C, Class D & Class E');
legend([class_c,class_d,class_e], {'Class C', 'Class D', 'Class E'}, 'Location', 'northeast');
hold off;

%% Error analysis
disp('GED Error analysis:');
GED_error_analysis;
disp('MAP Error analysis:');
MAP_error_analysis;

% Reset the random state for test data
rng(69);
test_a = bivariate_normal(n_a, covar_a, mu_a);
test_b = bivariate_normal(n_b, covar_b, mu_b);

test_c = bivariate_normal(n_c, covar_c, mu_c);
test_d = bivariate_normal(n_d, covar_d, mu_d);
test_e = bivariate_normal(n_e, covar_e, mu_e);

disp('NN Error analysis:');
NN_error_analysis;

disp('KNN Error analysis:');
KNN_error_analysis;
%% Remove values from the path
rmpath('./functions', './calculations');
