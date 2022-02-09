function [sub_size] = CalSize (msize,overFlag)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CalSize: 
%   - Calculate the sub-block size (Eq. (17) in the paper).
% Input:   
%   - The size of a real-world image. 
% Output:  
%   - The sub-block size after overlapping.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin == 1
    overFlag = 1;
end

if logical(overFlag) == 1   % overlap 2 or 3 element case
    sub_size = (msize+1)/2;
    if msize == 3
        sub_size= 2;
    elseif sub_size == fix(sub_size)
        sub_size= sub_size+ 1;
    else
        sub_size= ceil(sub_size);
    end
    
elseif logical(overFlag) == 0  % no overlap case
    sub_size = (msize)/2;
end

end    
    
   
