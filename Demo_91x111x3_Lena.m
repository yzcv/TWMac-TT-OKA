clear; close all; clc;
addpath('Functions/');
rand('seed',213412); 

SR = 0.2;                       % Sample ratio (SR), e.g. 0.1 = 10% known samples
mr = (1-SR)*100;                % Missing ratio (mr)

fig='lena';                     % Image selection
imgfile = strcat('Test_data/',fig,'.bmp');
I = imread(imgfile);
I_crop = imcrop(I,[100,100,110,90]); % The Lena image of size [91,111,3]
% I_crop = double(I_crop)/255;         % Normalize to interval [0,1]
imgsize=size(I_crop);

% Calculate the parameters in Algorithm 2
[Nway, x_size, y_size, x_start, y_start] = CalNway(imgsize); 
N = numel(Nway);

% Generate the augmented tensor using OKA
[X,yy]= OKA(I_crop,Nway,x_size,y_size,x_start,y_start);   

P = round(SR*prod(imgsize));
Known0 = randsample(prod(imgsize),P);
[Known0,~] = sort(Known0);           % Randomly sample the known elements
orig_img = zeros(imgsize);
orig_img(Known0) = I_crop(Known0);  

xOmega = zeros(imgsize);             % Indication matrix
xOmega(Known0) = 1;
[Omega,zid] = OKA(xOmega,Nway,x_size,y_size,x_start,y_start);
[Known,~,~] = find(Omega(:));
 
thl = [0.013];                       % An important prameter to be adjusted

[Tres,~] = TensorCompletion(X,Known,Omega,thl);  
X_out = InverseOKA(imgsize,Nway,Tres.MS,yy);
recImg = uint8(X_out);
imshow(recImg)

%% Metrics calculation
oriImg = uint8(I_crop);
recRSE  = RSE(double(recImg(:)),double(oriImg(:)));
recPSNR = psnr(recImg,oriImg);
recSSIM = ssim(rgb2gray(recImg),rgb2gray(oriImg));
fprintf('RSE=%f \t PSNR=%f \t SSIM=%f \n', recRSE,recPSNR, recSSIM);