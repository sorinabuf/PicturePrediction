function [x] = Jacobi_sparse(G_values, G_colind, G_rowptr, c, tol)
  
  n = length (G_rowptr) - 1;
  x0 = zeros (n, 1);
  prev_x = x0;
  OK = 1;
  
  while OK
    x = csr_multiplication (G_values, G_colind, G_rowptr, prev_x) + c;
    err = norm (x - prev_x);
    if (err < tol)
      OK = 0;
    endif
    prev_x = x;
  endwhile
  
endfunction