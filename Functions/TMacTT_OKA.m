function [M,timeTC,relerr] = TMacTT_OKA(data,known,Nway,N,ranktube,tol,maxiter)
lambda = weightTC(Nway);
M = initialization_M(Nway,known,data);
[X0,Y0] = initialMatrix(N,Nway,ranktube);
opts.X0 = X0; opts.Y0 = Y0;opts.lambda = lambda;opts.maxit = maxiter;opts.M0 =M;
% Start Time measure
t0=tic;
[M,relerr] = GlobalTMP(data,known,Nway,opts,tol);
% Stop Time measure
timeTC = toc(t0);
end
%%
function [X0,Y0,Wp] = initialMatrix(N,Nway,ranktube)
X0 = cell(1,N-1);Y0 = cell(1,N-1);
dimL = zeros(1,N-1);
dimR = zeros(1,N-1);
IL = 1;
for k = 1:N-1
    dimL(k) = IL*Nway(k);
    dimR(k) = prod(Nway)/dimL(k);
    X0{k} = randn(dimL(k),ranktube(k));
    Y0{k} = randn(ranktube(k),dimR(k));
    % Uniform distribution on the unit sphere
    X0{k} = bsxfun(@rdivide,X0{k},sqrt(sum(X0{k}.^2,1)));
    Y0{k} = bsxfun(@rdivide,Y0{k},sqrt(sum(Y0{k}.^2,2)));
    
    IL = dimL(k);
end
end
%%
function [M,relerr] = GlobalTMP(data,known,Nway,opts,tol)
X = opts.X0; Y = opts.Y0; lambda = opts.lambda;
N = length(Nway);
if isfield(opts,'M0')
    M = opts.M0;
    M = reshape(M,Nway);
else
    M = zeros(Nway);
    M(known) = data;
end
normM = norm(data(:),'fro');

k = 1;
relerr = [];

maxit = opts.maxit;
relerr(1) = 1;

fprintf('Iter  : \t  Relative Error \n');

while relerr(k) > tol
    
    k = k+1;
    Mlast = M;
    % update (X,Y)
    for n = 1:N-1
        Mn = reshape(M,[size(X{n},1) size(Y{n},2)]);
        X{n} = Mn*Y{n}';
        Xsq{n} = X{n}'*X{n};
        Y{n} = pinv(Xsq{n})*X{n}'*Mn;
    end
    % update M
    Mn = X{1}*Y{1};
    M = lambda(1)*Mn;
    M = reshape(M,Nway);
    for n = 2:N-1
        Mn = X{n}*Y{n};
        Mn = reshape(Mn,Nway);
        M = M+lambda(n)*Mn;
    end

    M(known) = data;

    % Calculate relative error
    relerr(k) = abs(norm(M(:)-Mlast(:)) / normM);
    fprintf('Iter %d: \t  %f\n',k-1,relerr(k));

    % check stopping criterion
    if k > maxit
        break
    end
end
end