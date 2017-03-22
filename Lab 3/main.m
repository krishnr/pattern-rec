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

%% Adding path
addpath('./lab3');

%% Helper Commands

% opening an image
image = readim('cloth.im') ; imagesc(image) ; colormap(gray);

% accessing the features
load feat.mat;
aplot(f2);

%% MICD for f2, f8, f32
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


%% Image Classification and Segmentation


%% Unlabelled Clustering

K = 10;

% Get K random prototypes
rand = randi([1 length(f32)], 1, K);
pts = f32(:,rand);