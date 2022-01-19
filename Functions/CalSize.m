function [num_overlap] = CalSize (msize)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CalSize: 
%   - Calculate the overlapping elements (According to Eq. (17) in the paper)
% Input:   
%   - The size of a real-world image. 
% Output:  
%   - The number of overlapping elements in the division.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num_overlap = (msize+1)/2;
if msize == 3
    num_overlap = 2;
elseif num_overlap  == fix(num_overlap)
    num_overlap = num_overlap + 1;
else  
    num_overlap = ceil(num_overlap);
end
