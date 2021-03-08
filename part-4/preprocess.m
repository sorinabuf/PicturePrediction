function [X y]=preprocess(path_to_dataset, histogram, count_bins)
  
  ## aceeasi functie ca in partea a 3-a
  ## singura diferenta este ca aici am ales sa verific tipul histogramei inainte
  ## de parcurgerea imaginilor pentru a stii direct ce functie trebuie sa aplic 
  ## si sa mai renunt la if-uri
  
  base1 = strcat (path_to_dataset, "cats/");
  img1 = getImgNames (base1);
  base2 = strcat (path_to_dataset, "not_cats/");
  img2 = getImgNames (base2);
  [nr_cat nc1] = size (img1);
  [nr_notcat nc2] = size (img2);
  X = zeros (nr_cat + nr_notcat, count_bins * 3);
  
  if (strcmp (histogram, "RGB") == 1)
    for i = 1:nr_cat
      j = 1:nc1;
      filename(j) = img1 (i,j);
      file_path = strcat (base1, filename);
      X(i,:) = rgbHistogram (file_path, count_bins);
    endfor
    for i = 1:nr_notcat
      j = 1:nc2;
      filename(j) = img2(i,j);
      file_path = strcat (base2, filename);
      X(i+nr_cat,:) = rgbHistogram (file_path, count_bins);
    endfor
  else
    for i = 1:nr_cat
      j = 1:nc1;
      filename(j) = img1(i,j);
      file_path = strcat (base1, filename);
      X(i,:) = hsvHistogram (file_path, count_bins);
    endfor
    for i = 1:nr_notcat
      j = 1:nc2;
      filename(j) = img2(i,j);
      file_path = strcat (base2, filename);
      X(i+nr_cat,:) = hsvHistogram (file_path, count_bins);
    endfor
  endif
  
  y = [ones(nr_cat, 1); -ones(nr_notcat, 1)];
  
endfunction