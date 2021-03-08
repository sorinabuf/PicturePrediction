function [w] = learn(X, y, lr, epochs)
  
  [nl nc] = size (X);
  batch_size = 64;
  X(:,nc+1) = ones(nl, 1);
  col = 1:nc;
  lin = 1:nl;
  M = mean (X(:,col));
  S = std (X(:,col));
  M = repmat (M, nl, 1);
  S = repmat (S, nl, 1);
  
  ## scalez matricea X
  X([lin],[col]) = (X([lin],[col]) - M) ./ S;
  w = zeros(nc+1, 1);
  
  ## fac o aproximare aleatorie a lui w
  r = [-0.1 0.1];
  w = rand(nc+1,1) * range(r) + min(r);
  
  ## aplic algoritmul Gradient Descent
  for epoch = 1:epochs
    rnd = randperm(nl);
    newX = X(rnd(1:batch_size), :);
    newY = y(rnd(1:batch_size));
    for i = 1:nc+1
      sigma = sum((newX(1:batch_size, :) * w - newY(1:batch_size)) .* newX(1:batch_size, i));
      w(i) = w(i) - lr / nl .* sigma;
    endfor 
  endfor
  
endfunction
