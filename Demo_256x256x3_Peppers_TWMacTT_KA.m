clear; close all; clc;
addpath('Functions/');
rand('seed',213412); 

Nway = [4 4 4 4 4 4 4 4 3];     % 9th-order dimensions for KA
N = numel(Nway);
num_row = 256; num_col = 256;
I1 = 2; J1 = 2;                 % KA parameters
SR = 0.1;                       % Sample ratio (SR), e.g. 0.1 = 10% known samples
mr = (1-SR)*100;                % Missing ratio (mr);

% Image selection 
fig='peppers';
imgfile = strcat('Test_data/',fig,'.bmp');
I = double(imread(imgfile));

% Ket Augmentation
X = CastImageAsKet(I,Nway,I1,J1);

% Generate known data
P = round(SR*prod(Nway));
Known = randsample(prod(Nway),P);
[Known,~] = sort(Known);

Omega = zeros(Nway);
Omega(Known) = 1;

thl = [0.02]; 

% Main function for tensor completion
[Tres,~] = TensorCompletion(X,Known,Omega,thl);  

%% 
oriImg = uint8(I);
recImg = uint8(CastKet2Image(Tres.MS,num_row,num_col,I1,J1));
recRSE  = RSE(double(recImg(:)),double(oriImg(:)));
recPSNR = psnr(recImg,oriImg);
recSSIM = ssim(rgb2gray(recImg),rgb2gray(oriImg));
fprintf('RSE=%f \t PSNR=%f \t SSIM=%f \n', recRSE,recPSNR, recSSIM);