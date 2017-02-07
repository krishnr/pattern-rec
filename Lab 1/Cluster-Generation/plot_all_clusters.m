% Plot the data for each class (Case 1 and 2) separately. On these plots
% also plot the unit standard deviation contour for each class.
%
% Febuary 12 2017
%
% Brady Kieffer - 20517665

class_data; % Creates the class data
samples_a = bivariate_normal(n_a, covar_a, mu_a);
samples_b = bivariate_normal(n_b, covar_b, mu_b);

x1 = [1:1:200];

% Case 1
hold on;
scatter(samples_a(:, 1), samples_a(:, 2), 'rx');
scatter(samples_b(:, 1), samples_b(:, 2), 'bo');

plot(mu_a(1), mu_a(2), 'go');
plot(mu_b', 'gx');

title('Plot of Samples of Class A and Class B');
legend('Class A', 'Class B', 'Location', 'northeast');
hold off;