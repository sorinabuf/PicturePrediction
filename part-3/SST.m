function [x] = SST(A, b)
  
  [m n] = size (A);
  x = zeros(n, 1);
  i = n;
  
  while (i > 0)
    j = i+1:n;
    sum = A(i,j) * x(j);
    x(i) = (b(i) - sum) / A(i,i);
    i--;
  endwhile
  
endfunction
    