% Computes the GED boundary for a 2D grid
%
% Febuary 12 2017
%
% Brady Kieffer - 20517665
% Krishn Ramesh - 20521942

%% Case 1
GED1 = zeros(size(X1, 1), size(Y1, 2));
get_dist = @(point, covar, mean) sqrt((point - mean) * inv(covar) * transpose(point - mean));

for i=1:size(X1, 1)
    for j=1:size(Y1, 2)
        v = [X1(i, j) Y1(i, j)];
        dist = get_dist(v, covar_a, mu_a) - get_dist(v, covar_b, mu_b);
        GED1(i, j) = dist;
    end
end

%% Case 2
% C vs D
GED_cd = zeros(size(X2, 1), size(Y2, 2));
for i=1:size(X2, 1)
    for j=1:size(Y2, 2)
        v = [X2(i, j) Y2(i, j)];
        dist = get_dist(v, covar_c, mu_c) - get_dist(v, covar_d, mu_d);
        GED_cd(i, j) = dist;
    end
end

% C vs E
GED_ec = zeros(size(X2, 1), size(Y2, 2));
for i=1:size(X2, 1)
    for j=1:size(Y2, 2)
        v = [X2(i, j) Y2(i, j)];
        dist = get_dist(v, covar_e, mu_e) - get_dist(v, covar_c, mu_c);
        GED_ec(i, j) = dist;
    end
end

% D vs E
GED_de = zeros(size(X2, 1), size(Y2, 2));
for i=1:size(X2, 1)
    for j=1:size(Y2, 2)
        v = [X2(i, j) Y2(i, j)];
        dist = get_dist(v, covar_d, mu_d) - get_dist(v, covar_e, mu_e);
        GED_de(i, j) = dist;
    end
end

% All
GED2 = zeros(size(X2, 1), size(Y2, 2));
cp = @classify_point;
for i=1:size(X2, 1)
    for j=1:size(Y2, 2)
        GED2(i, j) = cp(GED_cd(i, j), GED_de(i, j), GED_ec(i, j));
    end
end