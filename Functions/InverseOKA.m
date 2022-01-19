function [M] = InverseOKA(imgsize, Nway, xx, yy)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% InverseOKA:   
%   - Inversion of Overlapping Ket Augmentation.
% Input:        
%   - The high-order tensor xx and the corresponding location index yy.
% Output:       
%   - The original lower-order tensor .
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

order = length(Nway);

M_val = zeros(imgsize(1)*imgsize(2),imgsize(3));   % record the element values
num = zeros(imgsize(1)*imgsize(2),imgsize(3));     % record the times of each element in the OKA tensor
for i1 = 1:Nway(1)
    for i2 = 1:Nway(2)
        for i3 = 1:Nway(3)
            if order == 4
                temp = yy(i1,i2,i3);
                M_val(temp,:) = M_val(temp,:)+reshape(xx(i1,i2,i3,:),[1,3]);
                num(temp,:) = num(temp,:)+1;
                continue;
            end
            
            for i4 = 1:Nway(4)
                if order == 5
                    temp = yy(i1,i2,i3,i4);
                    M_val(temp,:) = M_val(temp,:)+reshape(xx(i1,i2,i3,i4,:),[1,3]);
                    num(temp,:) = num(temp,:)+1;
                    continue;
                end
                
                for i5 = 1:Nway(5)
                    if order == 6
                        temp = yy(i1,i2,i3,i4,i5);
                        M_val(temp,:) = M_val(temp,:)+reshape(xx(i1,i2,i3,i4,i5,:),[1,3]);
                        num(temp,:) = num(temp,:)+1;
                        continue;
                    end
                    
                    for i6 = 1:Nway(6)
                        if order == 7
                            temp = yy(i1,i2,i3,i4,i5,i6);
                            M_val(temp,:) = M_val(temp,:)+reshape(xx(i1,i2,i3,i4,i5,i6,:),[1,3]);
                            num(temp,:) = num(temp,:)+1;
                            continue;
                        end
                        
                        for i7 = 1:Nway(7)        % if eighth order
                            if order == 8
                                temp = yy(i1,i2,i3,i4,i5,i6,i7);
                                M_val(temp,:) = M_val(temp,:)+reshape(xx(i1,i2,i3,i4,i5,i6,i7,:),[1,3]);
                                num(temp,:) = num(temp,:)+1;
                                continue;
                            end

                            for i8 = 1:Nway(8)     % if nighth order
                                if order == 9
                                    temp = yy(i1,i2,i3,i4,i5,i6,i7,i8);
                                    M_val(temp,:) = M_val(temp,:)+reshape(xx(i1,i2,i3,i4,i5,i6,i7,i8,:),[1,3]);
                                    num(temp,:) = num(temp,:)+1;
                                    continue;
                                end
                                
                                for i9 = 1:Nway(9)   % if tenth order
                                    if order == 10
                                        temp = yy(i1,i2,i3,i4,i5,i6,i7,i8,i9);
                                        M_val(temp,:) = M_val(temp,:)+reshape(xx(i1,i2,i3,i4,i5,i6,i7,i8,i9,:),[1,3]);
                                        num(temp,:) = num(temp,:)+1;
                                        continue;
                                    end                    
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

M_tmp = M_val./num;
M = reshape(M_tmp,imgsize);

end