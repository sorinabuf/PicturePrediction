function [X y]=preprocess(path_to_dataset, histogram, count_bins)
  
  ## imi creez calea catre directorul cu poze cu pisici si extrag imaginile
  base1 = strcat (path_to_dataset, "/cats/");
  img1 = getImgNames (base1);
  
  ## imi creez calea catre directorul cu poze fara pisici si extrag imaginile
  base2 = strcat (path_to_dataset, "/not_cats/");
  img2 = getImgNames (base2);
  
  [nr_cat nc] = size (img1);
  [nr_notcat nc] = size (img2);
  X = zeros (nr_cat + nr_notcat, count_bins * 3);
  
  ## pentru fiecare imagine cu pisici construiesc calea relativa catre poza si 
  ## ii construiesc histograma data drept parametru
  for i = 1:nr_cat
    j = 1:nc;
    filename(j) = img1(i,j);
    file_path = strcat (base1, filename);
    if (strcmp (histogram, "RGB") == 1)
      X(i,:) = rgbHistogram (file_path, count_bins);
    else
      X(i,:) = hsvHistogram (file_path, count_bins);
    endif
  endfor
  
  ## pentru fiecare imagine fara pisici construiesc calea relativa catre poza si 
  ## ii construiesc histograma data drept parametru
  for i = 1:nr_notcat
    j = 1:nc;
    filename(j) = img2(i,j);
    file_path = strcat (base2, filename);
    if (strcmp (histogram, "RGB") == 1)
      X(i+nr_cat,:) = rgbHistogram (file_path, count_bins);
    else
      X(i+nr_cat,:) = hsvHistogram (file_path, count_bins);
    endif
  endfor
 
 ## construiesc vectorul coloana de etichete y
 y = [ones(nr_cat, 1); -ones(nr_notcat, 1)];
 
endfunction