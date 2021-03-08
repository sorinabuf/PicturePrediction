function [percentage] = evaluate(path_to_testset, w, histogram, count_bins)
  
  ## fata de partea a 3-a aici am ales sa modific functia evaluate si sa ma 
  ## folosesc de functia preprocess pentru a putea scala usor matricea X
  
  w = w';
  nr = 0;
  
  ## construiesc matricea de caracteristici si vectorul de etichete pe noul set
  ## de poze
  [X y] = preprocess (path_to_testset, histogram, count_bins);
  [nl nc] = size (X);
  X(:,nc+1) = ones(nl, 1);
  col = 1:nc;
  lin = 1:nl;
  M = mean (X(:,col));
  S = std (X(:,col));
  M = repmat (M, nl, 1);
  S = repmat (S, nl, 1);
  ## scalez matricea X
  X([lin],[col]) = (X([lin],[col]) - M) ./ S;
  w = repmat (w, nl, 1);
  A = w .* X;
  A = A';
  z = sum (A);
  
  ## daca y==1 inseamna ca poza este una cu pisici
  ## daca z>=0 inseamna ca poza este identificata ca fiind una cu pisici
  ## aflu numarul pozelor cu pisici identificate corespunzator
  ind1 = find (z >= 0);
  ind2 = find (y == 1);
  ind = intersect (ind1, ind2);
  nr = nr + length (ind);
  
  ## daca y==-1 inseamna ca poza este una fara pisici
  ## daca z<0 inseamna ca poza este identificata ca fiind una fara pisici
  ## aflu numarul pozelor fara pisici identificate corespunzator 
  ind1 = find (z < 0);
  ind2 = find (y == -1);
  ind = intersect (ind1, ind2);
  nr = nr + length (ind);
  
  ## calculez procentajul ca fiind nr de imagini corect identificate supra
  ## nr total de imagini
  
  percentage = nr / nl;
  
end