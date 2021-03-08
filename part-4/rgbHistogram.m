function [sol] = rgbHistogram(path_to_image, count_bins)
  ## aceeasi functie ca in partea a 3-a
  
  A = imread (path_to_image);
  
  ## extrag din matricea pixelilor valorile corespunzatoare lui r, g si b
  R = A(:,:,1);
  G = A(:,:,2);
  B = A(:,:,3);
  
  ## construiesc histogramele corespunzatoare
  edges = double([0:count_bins]) * 256 / count_bins;
  r_hist = histc (R(:), edges)';
  g_hist = histc (G(:), edges)';
  b_hist = histc (B(:), edges)';
  
  ## creez vectorul linie solutie
  sol = [r_hist(1, 1:count_bins) g_hist(1, 1:count_bins) b_hist(1, 1:count_bins)];
  
end