function [sol] = hsvHistogram(path_to_image, count_bins)
  ## aceeasi functie ca in partea a 3-a
  
   A = imread (path_to_image);
   [nl nc n] = size (A);
   A = (double)(A) / 255;
   
   ## extrag valorile pentru r, g si b din matricea pixelilor imaginii data 
   ## ca paranetru
   i = 1:nl;
   j = 1:nc;
   k = nl * nc;
   R([1:k]) = A(i,j,1);
   G([1:k]) = A(i,j,2);
   B([1:k]) = A(i,j,3);
   A = [R; G; B];
   
   ## calculez maximul si minimul dintre valorile r, g, b pentru fiecare pixel
   ## si le salvez in vectorii CMAX SI CMIN
   CMAX([1:k]) = max(A);
   CMIN([1:k]) = min(A);
   
   ## construiesc valorile pentru v
   ## pastrez valorile h, s, v pe intervalul [0,100]
   v = CMAX * 100;
   
   ## construiesc valorile pentru s
   dif = CMAX - CMIN;
   s = zeros (1, k);
   ind = find (CMAX != 0);
   s(ind) = dif(ind) ./ CMAX(ind) * 100;
   
   ## construiesc valorile pentru h
   ind1 = find (CMAX == R);
   ind2 = find (dif != 0);
   ind = intersect (ind1, ind2);
   h(ind) = 60 * mod ((G(ind) - B(ind)) ./ dif(ind), 6);
   
   ind1 = find (CMAX == G);
   ind = intersect (ind1, ind2);
   h(ind) = 60 * ((B(ind) - R(ind)) ./ dif(ind) + 2);
   
   ind1 = find (CMAX == B);
   ind = intersect (ind1, ind2);
   h(ind) = 60 * ((R(ind) - G(ind)) ./ dif(ind) + 4);
   
   ind = find (dif == 0);
   h(ind) = 0;
   
   h = h / 360 * 100;
   
   ## construiesc histogramele corespunzatoare
   edges = double([0:count_bins]) * 101 / count_bins;
   h_hist = histc(h, edges);
   s_hist = histc(s, edges);
   v_hist = histc(v, edges);
   
   ## creez vectorul linie solutie
   sol = [h_hist(1, 1:count_bins) s_hist(1, 1:count_bins) v_hist(1, 1:count_bins)];
   
end