%% n-bit copy

N = 1000000; X = randi(5,N,1);
X = [X, X, X, X, X, X, X];
oil = oiLocal(X);
mean(oil)




%% XOR
N = 1000000; nstate = 2;
X1 = randi(nstate,N,1);X1 = X1-1; X2 =  randi(nstate,N,1); X2 = X2-1;
X = [X1, X2, xor(X1,X2)];
oil = oiLocal(X);
mean(oil)