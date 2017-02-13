% Computes the nearest neighbour boundary for a 2D grid
%
% February 12, 2017
% 
% Ramandeep Farmaha - 20516974

%% Case 1
% A vs B
KNN1 = NN(5, samples_a, samples_b, X1, Y1);

%% Case 2
KNN_cd = NN(5, samples_c, samples_d, X2, Y2);
KNN_de = NN(5, samples_d, samples_e, X2, Y2);
KNN_ec = NN(5, samples_e, samples_c, X2, Y2);

% All classes
KNN2 = zeros(size(X2, 1), size(Y2, 2));
for i=1:size(X2, 1)
    for j=1:size(Y2, 2)
        KNN2(i, j) = classify_point(KNN_cd(i, j), KNN_de(i, j), KNN_ec(i, j));
    end
end