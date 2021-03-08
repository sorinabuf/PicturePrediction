function [Q, R] = Householder(A)
  
  [m n] = size (A);
  Q = eye (m);
  min = min ([(m-1) n]);
  for i = 1:min
    sigma = sign (A(i,i)) * norm (A(i:m,i));
    v_ii = A(i,i) + sigma;
    v = [zeros(i-1,1); v_ii; A(i+1:m,i)];
    c = 2 / (v' * v);
    H_i = eye(m) - c * v * v';
    A = H_i * A;
    Q = Q * H_i';
  endfor
  R = A;
  
endfunction