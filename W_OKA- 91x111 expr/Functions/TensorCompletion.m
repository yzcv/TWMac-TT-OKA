function [Out,Xmiss] = TensorCompletion(X,known,Omega,thl)
%% Missing data preparation
Nway = size(X); N = numel(Nway);
Xkn = X(known);      % Known elements
Omega = logical(Omega);
Out.Omega = Omega;
Xmiss = Omega.*X;    % Missing tensor to be recovered

%% TWMac-TT Algorithm
tol = 1e-5;     
maxiter = 321;      
RSl = zeros(1,length(thl));
MSl = cell(1,length(thl));
relerrSl = MSl;timeTSl = RSl;

for k=1:length(thl)
    th = thl(k);
    [~,ranktube] = SVD_MPS_Rank_Estimation(X,th);
    [MSl{k},timeTSl(k),relerrSl{k}] = TWMacTT(Xkn,known,Nway,N,ranktube,tol,maxiter);
end

% Choose the minimum RSE
[Out.RSEmin, Idx] = min(RSl);
Out.timeTS = timeTSl(Idx);
Out.muf = thl(Idx);
Out.MS = MSl{Idx};
Out.err = relerrSl{Idx};
end
