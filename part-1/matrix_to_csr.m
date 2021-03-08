function [values, colind, rowptr] = matrix_to_csr(A)
   
  n = size(A);
  nz = 1; 
  
  for i = 1:n
    rowptr(i) = 0;
    for j = 1:n
      if (A(i,j) != 0)
        values(nz) = A(i,j);
        colind(nz) = j;
        if (rowptr(i) == 0)
          rowptr(i) = nz;
        endif
        nz = nz + 1;
      endif
    endfor
  endfor
  
  rowptr(n+1) = nz;
  
endfunction