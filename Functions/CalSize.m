function [sub_size] = CalSize (msize)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CalSize: 
%   - Calculate the sub-block size (According to Eq. (17) in the paper)
% Input:   
%   - The size of a real-world image. 
% Output:  
%   - The sub-block size after overlapping.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sub_size = (msize+1)/2;
if msize == 3
    sub_size = 2;
elseif  sub_size == fix(sub_size)
    sub_size = sub_size + 1;
else  
    sub_size = ceil(sub_size);
end
