function o_local = oiLocal(X,numStates)
% INPUT
% X         -  data matrix, N is the number of realizations and M the number of
%              variables
% numStates -  cardinality of X

if nargin < 2
    numStates = numel(min(X(:)):max(X(:))); 
end

[N,M] = size(X);


pvec = probabilityVectorEstimate(X);

h = -log2(pvec);

o_local = (M-2)*h;
for j = 1:M
    p_j = probabilityVectorEstimate(X(:,j));
    p_not_j = probabilityVectorEstimate(X(:,setdiff(1:M,j)));
    
    h_j = -log2(p_j);
    h_not_j = -log2(p_not_j);
    
    
    o_local = o_local +  (  h_j - h_not_j);
              
end


% Here we change the log base from log2 to log_{numStates}
o_local = o_local/log2(numStates);

% Test: with log2 the maximum value for O-info is (n-2)*log2(numStates) for n-bit copy random var
end

