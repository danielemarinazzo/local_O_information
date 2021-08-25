function pvec = probabilityVectorEstimate(data) 
% INPUT: 
% data must contains only positive integers

% OUTPUT
% each element of pvec is the probability of the relative state
% observe that pvec is NOT normalized, but unique(pvec) yes!!!

if nargin < 2
    numStates = numel(min(data(:)):max(data(:)));
end

[nobs, nvar] = size(data);


% Unique Values By Row, Retaining Original Order
[Mu,ia,ic] = unique(data, 'rows', 'stable'); 

% Here I use accumarray, 1 in second input counts unique values in ic
counts = accumarray(ic, 1);      

% We need to tranform counts to probability
counts = counts/sum(counts);         
pvec = counts(ic);




