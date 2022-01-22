function [Out,Xmiss] = TensorCompletion(X,Known,Omega,thl,MaxIter)
%% Missing data preparation
Nway = size(X); N = numel(Nway);
Xkn = X(Known);      % Known elements
Omega = logical(Omega);
Out.Omega = Omega;
Xmiss = Omega.*X;    % Missing tensor to be recovered

%% TWMac-TT Algorithm
tol = 1e-4;
if nargin == 5
    maxiter = MaxIter;
else
    maxiter = 1000;    
end
RSl = zeros(1,length(thl));
MSl = cell(1,length(thl));
relerrSl = MSl;timeTSl = RSl;

for k=1:length(thl)
    th = thl(k);
    [~,ranktube] = SVD_MPS_Rank_Estimation(X,th);
    [MSl{k},timeTSl(k),relerrSl{k}] = TWMacTT(Xkn,Known,Nway,N,ranktube,tol,maxiter);
    RSl(k)= RSE(MSl{k}(:),X(:));
end

% Choose the minimum RSE
[Out.RSEmin, Idx] = min(RSl);
Out.timeTS = timeTSl(Idx);
Out.muf = thl(Idx);
Out.MS = MSl{Idx};
Out.err = relerrSl{Idx};
end
