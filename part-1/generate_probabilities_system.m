function [A, b] = generate_probabilities_system(rows)
  
  nr = rows * (rows + 1) / 2;
  b = zeros (nr, 1);
  A = zeros (nr, nr);
  
  ## completez vectorul b
  for i = 1:rows
    b(nr-i+1) = 1;
  endfor
  
  ## prima linie din A
  A(1,1) = 4;
  A(1,2) = -1;
  A(1,3) = -1;
  
  ## probabilitatile colturilor de jos
  linia = nr - rows + 1;
  A(linia,linia) = 4;
  A(linia,linia+1) = -1;
  A(linia,linia-rows+1) = -1;
  A(nr,nr) = 4;
  A(nr,nr-1) = -1;
  A(nr,nr-rows) = -1;
  
  ## probabilitatile de pe marginile laterale ale triunghiului
  prev = 0;
  for i = 1:rows-2
    A(1+i+prev,1+i+prev) = 5;
    A(1+i+prev,2+i+prev) = -1;
    A(1+i+prev,3+2*i+prev) = -1;
    A(1+i+prev,1+prev) = -1;
    A(1+i+prev,2+2*i+prev) = -1;    
    A(1+2*i+prev,1+2*i+prev) = 5;
    A(1+2*i+prev,2*i+prev) = -1; 
    A(1+2*i+prev,i+prev) = -1;
    A(1+2*i+prev,2+3*i+prev) = -1;
    A(1+2*i+prev,3+3*i+prev)=-1;
    prev = prev + i;
  endfor
  
  ## probabilitatile de pe ultimul rand
  for i = (nr-rows+2):(nr-1)
    A(i,i) = 5;
    A(i,i-1) = -1;
    A(i,i+1) = -1;
    A(i,i-rows) = -1;
    A(i,i-rows+1) = -1;
  endfor
  
  ## restul probabilitatilor
  prev = 5;
  for i = 3:rows-1
    for j = 0:i-3
      A(prev+j,prev+j) = 6;
      A(prev+j,prev+j+1) = -1;
      A(prev+j,prev+j-1) = -1;
      A(prev+j,prev+j-i) = -1;
      A(prev+j,prev+j-i+1) = -1;
      A(prev+j,prev+j+i) = -1;
      A(prev+j,prev+j+i+1) = -1;
    endfor
    prev = prev + i;
  endfor
  
endfunction