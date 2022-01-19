clear; clc; close all;
addpath('Functions/');

imgsize = [111,91,3];
I = uint8(rand(imgsize)*255);

[Nway, x_size, y_size, x_start, y_start] = CalNway(imgsize);
[xx,yy] = OKA(I,Nway,x_size,y_size,x_start,y_start);
[M] = InverseOKA(imgsize, Nway, xx, yy);
right = isequal(M,I);
disp(right)