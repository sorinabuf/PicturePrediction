function [centroids] = clustering_pc(points, NC)
  
  [nr dim] = size (points);
  centroids = zeros (NC, dim);
  
  ## creez vectorul initial de centroizi pe baza celor NC clustere
  for i = 1:NC
    nr_points = fix ((nr - i) / NC);
    for j = 0:nr_points
      pos = i + j * NC;
      for k = 1:dim
        centroids(i,k) = centroids(i,k) + points(pos,k);
      endfor
    endfor
    for k = 1:dim
      centroids(i,k) = centroids(i,k) / (nr_points + 1);
    endfor
  endfor
  
  ## cat timp pozitia centroizilor inca se modifica ma folosesc de o matrice 
  ## auxiliara in care pastrez suma coordonatelor punctelor corespunzatoare
  ## noilor centroizi, cat si nr punctelor din fiecare lista nou formata        
  while 1
    aux = zeros (NC, dim + 1);
    for i = 1:nr
      min = -1;
      centr = 0;
      for j = 1:NC 
        d = 0;
        for k = 1:dim
          d = d + (centroids(j,k) - points(i,k)) ^ 2;
        endfor
        d = sqrt (d);
        if (min < 0 || min > d)
          min = d;
          centr = j;
        endif
      endfor
      for k = 1:dim
        aux(centr,k) = aux(centr,k) + points(i,k);
      endfor
      aux(centr,dim+1) = aux(centr,dim+1) + 1;
    endfor
  ## construiesc noii centroizi si verific daca s-au modificat
    OK = 1;
    for i = 1:NC
      for j = 1:dim
        if (aux(i,dim+1) != 0)
          aux(i,j) = aux(i,j) / aux(i,dim+1);
        endif
        if (aux(i,j) != centroids(i,j))
          centroids(i,j) = aux(i,j);
          OK = 0;
        endif
      endfor
    endfor
    if OK == 1 
      return;
    endif
  endwhile
  
endfunction
