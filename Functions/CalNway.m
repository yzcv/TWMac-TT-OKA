function [Nway, x_size, y_size, x_start, y_start] = CalNway(imgsize,overFlag,mini_patch_size)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CalNway: 
%   - Calculate the Nway parameter (Algorithm 2).
% Input: 
%   - The size of a real-world image. 
% Output: 
%   - The dimension size of the generated tensor by OKA.
%   - (x_size, y_size) and (x_start, y_start)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

imgrow = imgsize(1);
imgcol = imgsize(2);
ch_size = imgsize(3);

num4 = 1; 

if nargin == 1
    overFlag = 1;  % default is 1, namely, with overlapping
end

if nargin < 3
    mini_patch_size = 4;  % default is 4, namely the most augmented
end

imgrow = CalSize(imgrow,overFlag);
x_size(num4) = imgrow;
x_start(num4) = imgsize(1) - x_size(num4) + 1;

imgcol = CalSize(imgcol,overFlag);
y_size(num4) = imgcol;
y_start(num4) = imgsize(2) - y_size(num4) + 1;

while imgrow > mini_patch_size && imgcol > mini_patch_size
    num4 = num4+1; 
    
    imgrow = CalSize(imgrow,overFlag);
    x_size(num4) = imgrow;
    x_start(num4) = x_size(num4-1) - x_size(num4) + 1;
    
    imgcol = CalSize(imgcol,overFlag);  
    y_size(num4) = imgcol;
    y_start(num4) = y_size(num4-1) - y_size(num4) + 1;
end

Nway = 4*ones(1,num4);
Nway = [Nway,imgrow,imgcol,ch_size];

