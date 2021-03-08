function [G_J, c_J] = Jacobi_factorization(A, b)
  
  N = diag (diag (A));
  P = N - A;
  inv_N = diag (N);
  len = length (inv_N);
  
  ## calculez inversa lui N
  for i = 1:len
    inv_N(i) = 1 / inv_N(i);
  endfor
  
  inv_N = diag (inv_N);
  G_J = inv_N * P;
  c_J = inv_N * b;
  
endfunction