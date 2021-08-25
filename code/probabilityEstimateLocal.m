function pdistr = probabilityEstimateLocal(data,numStates) 
% INPUT: 
% data must contains only positive integers

if nargin < 2
    numStates = numel(min(data(:)):max(data(:)));
end

[nobs, nvar]=size(data);


% Count the number of values in each possible (multidimensional) state
pdistr = accumarray(data,1,repmat(numStates,1,nvar),@sum);

% Normalize to a probability
pdistr = pdistr/nobs;
