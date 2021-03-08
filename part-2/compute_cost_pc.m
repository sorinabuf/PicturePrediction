function [cost] = compute_cost_pc(points, centroids)
  cost = 0;
  [nr dim] = size (points);
  [NC dim] = size (centroids);
  
  ## calculez distanta minima de la fiecare punct la centroizi
  for i = 1:nr
    min = -1;
    for j = 1:NC 
      d = 0;
      for k = 1:dim
        d = d + (centroids(j,k) - points(i,k)) ^ 2;
      endfor
      d = sqrt (d);
      if (min < 0 || min > d)
        min = d;
      endif
    endfor
    cost = cost + min;
  endfor
    
endfunction