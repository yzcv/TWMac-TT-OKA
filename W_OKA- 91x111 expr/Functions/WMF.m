function [U,V,W] = WMF(A,th,iter,chi,known)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% WMF:
%   - Weighted Matrix Factorization.
% Input:
%   - A:     	Incomplete matrix.
%   - th:       The threshold.
%   - iter:     The maximum iteration.
%   - known:    The location indication.
% Output:
%   - U:        The estimated U.
%   - V:        The estimated V.
%   - W:        The estimated W.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
r=chi;

rowA = size(A,1);
colA = size(A,2);

U = rand(rowA,r);
V = rand(colA,r);


err_r = abs(U*V'-A);
err_r = err_r / max(err_r(:));
W = sqrt(exp(-25*err_r));

merr0=Inf;
err = W.*abs(U*V'-A);
merr = sum(err(:))/(rowA*colA);

m = 1;
while m<iter && abs(merr-merr0)>th
    % Update U
    for k = 1:rowA
        T = V'*diag(sparse(W(k,:)));
        U(k,:)= (pinv(T*V)*T*A(k,:)')';
    end
    % Update V
    for k = 1:colA
        T = U'*diag(sparse(W(:,k)));
        V(k,:) = (pinv(T*U)*T*A(:,k))';
    end
    err_r = abs(U*V'-A);
    err_r = err_r / max(err_r(:));
    W = sqrt(exp(-25*err_r));
    W(known) = 1;
    merr0=merr;
    err = W.*abs(U*V'-A);
    merr = sum(err(:))/(rowA*colA);
    m = m+1;
end
V=V';
end



