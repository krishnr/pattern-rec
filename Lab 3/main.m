% Main Script for Lab 3
%
% Image Classifier
%
% March 25 2017
%
% Brady Kieffer - 20517665
% Krishn Ramesh - 20521942
% Ramandeep Farmaha - 20516974
% Shubam Mehta - 20483061

%% Adding path and loading data
clear;
addpath('./lab3');
load feat.mat;

%% Helper Commands

% opening an image
% image = readim('cloth.im') ; imagesc(image) ; colormap(gray);

% accessing the features
% aplot(f2);

%% MICD for f2
mu = zeros(10,2);
S = zeros(10, 2, 2);

% getting the mean and covariance of every image
for i = 1:10
    pts = f2(1:2,16*(i-1) + 1:16*i);
    mu(i,:) = mean(pts,2);
    covar = cov(pts');
    S(i,:,1) = covar(1,:);
    S(i,:,2) = covar(2,:);
end

% defining a mesh grid
step = 0.001;
x_min = min([f2(1,:) f2t(1,:)]) - 0.01;
x_max = max([f2(1,:) f2t(1,:)]) + 0.01;
y_min = min([f2(2,:) f2t(2,:)]) - 0.01;
y_max = max([f2(2,:) f2t(2,:)]) + 0.01;

[X, Y] = meshgrid(x_min:step:x_max, y_min:step:y_max);

class2 = MICD(mu,S,X,Y);

%% Testing with f2t
confusion_matrix2 = zeros(10);
for i = 1:length(f2t)
   class = round(interp2(X,Y,class2,f2t(1,i),f2t(2,i)));
   confusion_matrix2(f2t(3,i), class) = confusion_matrix2(f2t(3,i), class) + 1;
end
%% MICD for f8
mu = zeros(10,2);
S = zeros(10, 2, 2);

% getting the mean and covariance of every image
for i = 1:10
    pts = f8(1:2,16*(i-1) + 1:16*i);
    mu(i,:) = mean(pts,2);
    covar = cov(pts');
    S(i,:,1) = covar(1,:);
    S(i,:,2) = covar(2,:);
end

% defining a mesh grid
step = 0.001;
x_min = min([f8(1,:) f8t(1,:)]) - 0.01;
x_max = max([f8(1,:) f8t(1,:)]) + 0.01;
y_min = min([f8(2,:) f8t(2,:)]) - 0.01;
y_max = max([f8(2,:) f8t(2,:)]) + 0.01;

[X, Y] = meshgrid(x_min:step:x_max, y_min:step:y_max);

class8 = MICD(mu,S,X,Y);

%% Testing with f8t
confusion_matrix8 = zeros(10);
for i = 1:length(f8t)
   class = round(interp2(X,Y,class8,f8t(1,i),f8t(2,i)));
   confusion_matrix8(f8t(3,i), class) = confusion_matrix8(f8t(3,i), class) + 1;
end
%% MICD for f32
mu = zeros(10,2);
S = zeros(10, 2, 2);

% getting the mean and covariance of every image
for i = 1:10
    pts = f32(1:2,16*(i-1) + 1:16*i);
    mu(i,:) = mean(pts,2);
    covar = cov(pts');
    S(i,:,1) = covar(1,:);
    S(i,:,2) = covar(2,:);
end

% defining a mesh grid
step = 0.001;
x_min = min([f32(1,:) f32t(1,:)]) - 0.01;
x_max = max([f32(1,:) f32t(1,:)]) + 0.01;
y_min = min([f32(2,:) f32t(2,:)]) - 0.01;
y_max = max([f32(2,:) f32t(2,:)]) + 0.01;

[X, Y] = meshgrid(x_min:step:x_max, y_min:step:y_max);

class32 = MICD(mu,S,X,Y);

%% Testing with f2t
confusion_matrix32 = zeros(10);
for i = 1:length(f32t)
   class = round(interp2(X,Y,class32,f32t(1,i),f32t(2,i)));
   confusion_matrix32(f32t(3,i), class) = confusion_matrix32(f32t(3,i), class) + 1;
end

classification_rates = [trace(confusion_matrix2)/length(f2t) trace(confusion_matrix8)/length(f8t) trace(confusion_matrix32)/length(f32t)];
%% Image Classification and Segmentation

% Use MICD classifier derived previously to classify multf8 


%% Unlabelled Clustering

% K = 10;
% 
% % Get K random prototypes
% rand = randi([1 length(f32)], 1, K);
% pts = f32(:,rand);