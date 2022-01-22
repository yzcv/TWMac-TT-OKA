clear; close all; clc;
addpath('Functions/');
rand('seed',213412); 

SR = 0.1;                       % Sample ratio (SR), e.g. 0.1 = 10% known samples
mr = (1-SR)*100;                % Missing ratio (mr)

fig='lena';                     % Image selection
imgfile = strcat('Test_data/',fig,'.bmp');
I = double(imread(imgfile));
imgsize=size(I);

% Calculate the parameters in Algorithm 2
[Nway, x_size, y_size, x_start, y_start] = CalNway(imgsize); 
N = numel(Nway);

% Generate the augmented tensor using OKA
[X,yy]= OKA(I,Nway,x_size,y_size,x_start,y_start);   

P = round(SR*prod(imgsize));
Known0 = randsample(prod(imgsize),P);
[Known0,~] = sort(Known0);           % Randomly sample the known elements
orig_img = zeros(imgsize);
orig_img(Known0) = I(Known0);  

xOmega = zeros(imgsize);             % Indication matrix
xOmega(Known0) = 1;
[Omega,zid] = OKA(xOmega,Nway,x_size,y_size,x_start,y_start);
[Known,~,~] = find(Omega(:));

% An important prameter to be adjusted
thl = [0.015];                      
MaxIter = 321;

[Tres,~] = TensorCompletion(X,Known,Omega,thl,MaxIter);  
X_out = InverseOKA(imgsize,Nway,Tres.MS,yy);
recImg = uint8(X_out);
imshow(recImg)

%% Metrics calculation
oriImg = uint8(I);
recRSE  = RSE(double(recImg(:)),double(oriImg(:)));
recPSNR = psnr(recImg,oriImg);
recSSIM = ssim(rgb2gray(recImg),rgb2gray(oriImg));
fprintf('RSE=%f \t PSNR=%f \t SSIM=%f \n', recRSE,recPSNR, recSSIM);
