function [xx,yy] = OKA(M,Nway,x_size,y_size,x_start,y_start)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OKA:
%   - Overlapping Ket Augmentation (Algorithm 3).
% Input:
%   - M:    The third-order image.
%   - Nway: The disired dimension size.
%   - (x_size, y_size):     The sub-block size of each division.
%   - (x_start, y_start):   The sub-block starting position.
% Output:
%   - The generated high-order tensor xx and
%   - the corresponding location index yy
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

imgsize = size(M);
ch_size = imgsize(3);
order = length(Nway);
flag = 3;

dm = 1:imgsize(1)*imgsize(2);
dmzreshape = reshape(dm,imgsize(1),imgsize(2));

%% First Structured Block Addressing [(3rd order) -> (4th order)]
nway = [4,x_size(1),y_size(1),ch_size];
x = zeros(nway);
nwayy = [4,x_size(1),y_size(1)];
y = zeros(nwayy);

for i3 = 1:4
    [i,j] = index_ij(i3,x_start,y_start);
    x(i3,:,:,:) = M(i:i+x_size-1,j:j+y_size-1,:);
    dd=dmzreshape(i:i+x_size-1,j:j+y_size-1);
    y(i3,:) = dd(:);
end
flag = flag + 1;
if flag == order
    xx = x;
    yy = y;
    return;
end

%% Second Structured Block Addressing [(4th order) -> (5th order)]
nway2 = [4,4,x_size(2),y_size(2),ch_size];
x2 = zeros(nway2);
nwayy2 = [4,4,x_size(2),y_size(2)];
y2 = zeros(nwayy2);

for i3 = 1:4
    for i4 = 1:4
        [i,j] = index_ij(i4,x_start(2),y_start(2));
        x2(i3,i4,:,:,:) = x(i3,i:i+x_size(2)-1,j:j+y_size(2)-1,:);
        dd=y(i3,i:i+x_size(2)-1,j:j+y_size(2)-1);
        y2(i3,i4,:,:) = dd(1,:,:);
    end
end
flag = flag + 1;
if flag == order
    xx = x2;
    yy = y2;
    return;
end

%% Third Structured Block Addressing [(5th order) -> (6th order)]
nway3 = [4,4,4,x_size(3),y_size(3),ch_size];
x3 = zeros(nway3);
nwayy3 = [4,4,4,x_size(3),y_size(3)];
y3 = zeros(nwayy3);

for i3 = 1:4
    for i4 = 1:4
        for i5 = 1:4
            [i,j] = index_ij(i5,x_start(3),y_start(3));
            x3(i3,i4,i5,:,:,:) = x2(i3,i4,i:i+x_size(3)-1,j:j+y_size(3)-1,:);
            dd=y2(i3,i4,i:i+x_size(3)-1,j:j+y_size(3)-1);
            y3(i3,i4,i5,:,:) = dd(1,1,:,:);
        end
    end
end
flag = flag + 1;
if flag == order
    xx = x3;
    yy = y3;
    return;
end

%% Fourth Structured Block Addressing [(6th order) -> (7th order)]
nway4 = [4,4,4,4,x_size(4),y_size(4),ch_size];
x4 = zeros(nway4);
nwayy4 = [4,4,4,4,x_size(4),y_size(4)];
y4 = zeros(nwayy4);

for i3 = 1:4
    for i4 = 1:4
        for i5 = 1:4
            for i6 = 1:4
                [i,j] = index_ij(i6,x_start(4),y_start(4));
                x4(i3,i4,i5,i6,:,:,:) = x3(i3,i4,i5,i:i+x_size(4)-1,j:j+y_size(4)-1,:);
                dd=y3(i3,i4,i5,i:i+x_size(4)-1,j:j+y_size(4)-1);
                y4(i3,i4,i5,i6,:,:) = dd(1,1,1,:,:);
            end
        end
    end
end
flag = flag + 1;
if flag == order
    xx = x4;
    yy = y4;
    return;
end

%% Fifth Structured Block Addressing [(7th order) -> (8th order)]
nway5 = [4,4,4,4,4,x_size(5),y_size(5),ch_size];
x5 = zeros(nway5);
nwayy5 = [4,4,4,4,4,x_size(5),y_size(5)];
y5 = zeros(nwayy5);

for i3 = 1:4
    for i4 = 1:4
        for i5 = 1:4
            for i6 = 1:4
                for i7 = 1:4
                    [i,j] = index_ij(i7,x_start(5),y_start(5));
                    x5(i3,i4,i5,i6,i7,:,:,:) = x4(i3,i4,i5,i6,i:i+x_size(5)-1,j:j+y_size(5)-1,:);
                    dd=y4(i3,i4,i5,i6,i:i+x_size(5)-1,j:j+y_size(5)-1);
                    y5(i3,i4,i5,i6,i7,:,:) = dd(1,1,1,1,:,:);
                end
            end
        end
    end
end
flag = flag + 1;
if flag == order
    xx = x5;
    yy = y5;
    return;
end

%% Sixth Structured Block Addressing [(8th order) -> (9th order)]
nway6 = [4,4,4,4,4,4,x_size(6),y_size(6),ch_size];
x6 = zeros(nway6);
nwayy6 = [4,4,4,4,4,4,x_size(6),y_size(6)];
y6 = zeros(nwayy6);

for i3 = 1:4
    for i4 = 1:4
        for i5 = 1:4
            for i6 = 1:4
                for i7 = 1:4
                    for i8 = 1:4
                        [i,j] = index_ij(i8,x_start(6),y_start(6));
                        x6(i3,i4,i5,i6,i7,i8,:,:,:) = x5(i3,i4,i5,i6,i7,i:i+x_size(6)-1,j:j+y_size(6)-1,:);
                        dd=y5(i3,i4,i5,i6,i7,i:i+x_size(6)-1,j:j+y_size(6)-1);
                        y6(i3,i4,i5,i6,i7,i8,:,:) = dd(1,1,1,1,1,:,:);
                    end
                end
            end
        end
    end
end

flag = flag + 1;
if flag == order
    xx = x6;
    yy = y6;
    return;
end

%% Seventh Structured Block Addressing [(9th order) -> (10th order)]
nway7 = [4,4,4,4,4,4,4,x_size(7),y_size(7),ch_size];
x7 = zeros(nway7);
nwayy7 = [4,4,4,4,4,4,4,x_size(7),y_size(7)];
y7 = zeros(nwayy7);

for i3 = 1:4
    for i4 = 1:4
        for i5 = 1:4
            for i6 = 1:4
                for i7 = 1:4
                    for i8 = 1:4
                        for i9 = 1:4
                            [i,j] = index_ij(i9,x_start(7),y_start(7));
                            x7(i3,i4,i5,i6,i7,i8,i9,:,:,:) = x6(i3,i4,i5,i6,i7,i8,i:i+x_size(7)-1,j:j+y_size(7)-1,:);
                            dd=y6(i3,i4,i5,i6,i7,i8,i:i+x_size(7)-1,j:j+y_size(7)-1);
                            y7(i3,i4,i5,i6,i7,i8,i9,:,:) = dd(1,1,1,1,1,1,:,:);
                        end
                    end
                end
            end
        end
    end
end

flag = flag + 1;
if flag == order
    xx = x7;
    yy = y7;
    return;
end

%% Eighth Structured Block Addressing [(10th order) -> (11th order)]
nway8 = [4,4,4,4,4,4,4,4,x_size(8),y_size(8),ch_size];
x8 = zeros(nway8);
nwayy8 = [4,4,4,4,4,4,4,4,x_size(8),y_size(8)];
y8 = zeros(nwayy8);

for i3 = 1:4
    for i4 = 1:4
        for i5 = 1:4
            for i6 = 1:4
                for i7 = 1:4
                    for i8 = 1:4
                        for i9 = 1:4
                            for i10 = 1:4
                                [i,j] = index_ij(i10,x_start(8),y_start(8));
                                x8(i3,i4,i5,i6,i7,i8,i9,i10,:,:,:) = x7(i3,i4,i5,i6,i7,i8,i9,i:i+x_size(8)-1,j:j+y_size(8)-1,:);
                                dd=y7(i3,i4,i5,i6,i7,i8,i9,i:i+x_size(8)-1,j:j+y_size(8)-1);
                                y8(i3,i4,i5,i6,i7,i8,i9,i10,:,:) = dd(1,1,1,1,1,1,1,:,:);
                            end
                        end
                    end
                end
            end
        end
    end
end

flag = flag + 1;
if flag == order
    xx = x8;
    yy = y8;
    return;
end

%% nighth Structured Block Addressing [(11th order) -> (12th order)]
nway9 = [4,4,4,4,4,4,4,4,4,x_size(9),y_size(9),ch_size];   % [4 4 4 4 4 4 4 4 4 2 2 3]
x9 = zeros(nway9);
nwayy9 = [4,4,4,4,4,4,4,4,4,x_size(9),y_size(9)];
y9 = zeros(nwayy9);

for i3 = 1:4
    for i4 = 1:4
        for i5 = 1:4
            for i6 = 1:4
                for i7 = 1:4
                    for i8 = 1:4
                        for i9 = 1:4
                            for i10 = 1:4
                                for i11 = 1:4
                                    [i,j] = index_ij(i11,x_start(9),y_start(9));
                                    x9(i3,i4,i5,i6,i7,i8,i9,i10,i11,:,:,:) = x8(i3,i4,i5,i6,i7,i8,i9,i10,i:i+x_size(9)-1,j:j+y_size(9)-1,:);
                                    dd=y8(i3,i4,i5,i6,i7,i8,i9,i10,i:i+x_size(9)-1,j:j+y_size(9)-1);
                                    y9(i3,i4,i5,i6,i7,i8,i9,i10,i11,:,:) = dd(1,1,1,1,1,1,1,1,:,:);
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

flag = flag + 1;
if flag == order
    xx = x9;
    yy = y9;
    return;
end

end


%% index_ij: index the location
function [i,j] = index_ij(i3,x_start,y_start)
    i0 = 1;j0 = 1;
    switch i3
        case 1
            i = i0;
            j = j0;
        case 2
            i = x_start;
            j = j0;
        case 3
            i = i0;
            j = y_start;
        case 4
            i = x_start;
            j = y_start;
    end
end