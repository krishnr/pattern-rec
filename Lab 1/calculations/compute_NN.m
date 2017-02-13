% Computes the nearest neighbour boundary for a 2D grid
%
% February 12, 2017
% 
% Ramandeep Farmaha - 20516974

%% Case 1
% A vs B
NN1 = NN(1, samples_a, samples_b, X1, Y1);

%% Case 2
NN_cd = NN(1, samples_c, samples_d, X2, Y2);
NN_de = NN(1, samples_d, samples_e, X2, Y2);
NN_ec = NN(1, samples_e, samples_c, X2, Y2);

% All classes
NN2 = zeros(size(X2, 1), size(Y2, 2));
for i=1:size(X2, 1)
    for j=1:size(Y2, 2)
        NN2(i, j) = classify_point(NN_cd(i, j), NN_de(i, j), NN_ec(i, j));
    end
end