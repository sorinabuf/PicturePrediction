function [w] = learn(X, y)
  
  [nl nc] = size (X);
  X(:,nc+1) = ones(nl,1);
  [Q R] = Householder (X);
  Q = Q';
  w = SST (R,Q*y);
  
endfunction
