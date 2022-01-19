function W = Weight_Element(W)
normf = W{1}(:);
for k = 2:length(W)
    normf = normf + W{k}(:);
end
for k = 1:length(W)
    [m,n] = size(W{k});
    W{k}(:) = W{k}(:)./normf;
    W{k} = reshape(W{k},[m,n]);
end
