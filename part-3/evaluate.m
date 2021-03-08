function [percentage] = evaluate(path_to_testset, w, histogram, count_bins)
  
  w = w';
  
  ## imi creez calea catre directorul cu poze cu pisici si extrag imaginile
  path_to_testset1 = strcat (path_to_testset, "/cats/");
  nr_cat1 = 0;
  imgs1 = getImgNames (path_to_testset1);
  [nr1 nc1] = size (imgs1);
  
  ## pentru fiecare imagine cu pisici construiesc calea relativa catre poza si 
  ## ii construiesc histograma data drept parametru
  for i = 1:nr1
    j = 1:nc1;
    filename(j) = imgs1(i,j);
    file_path1 = strcat (path_to_testset1, filename);
    if (strcmp (histogram, "RGB") == 1)
      x = rgbHistogram (file_path1, count_bins);
    else
      x = hsvHistogram (file_path1, count_bins);
    endif
    x(count_bins*3+1) = 1;
    x = x';
    y = w * x;
    ## daca y>=0 inseamna ca poza este una cu pisici, deci identificarea este 
    ## corecta si maresc numarul de imagini cu pisici identificate corect
    if (y >= 0)
      nr_cat1++;
    endif
  endfor
  
  ## imi creez calea catre directorul cu poze fara pisici si extrag imaginile 
  path_to_testset2 = strcat (path_to_testset, "/not_cats/");
  nr_cat2 = 0;
  imgs2 = getImgNames (path_to_testset2);
  [nr2 nc2] = size (imgs2);
  
  ## pentru fiecare imagine fara pisici construiesc calea relativa catre poza si
  ## ii construiesc histograma data drept parametru
  for i = 1:nr2
    j = 1:nc2;
    filename(j) = imgs2(i,j);
    file_path2 = strcat (path_to_testset2, filename);
    if (strcmp (histogram, "RGB") == 1)
      x = rgbHistogram (file_path2, count_bins);
    else
      x = hsvHistogram (file_path2, count_bins);
    endif
    x(count_bins*3+1) = 1;
    x = x';
    y = w * x;
    ## daca y<0 inseamna ca poza este una fara pisici, deci identificarea este 
    ## corecta si maresc numarul de imagini fara pisici identificate corect
    if (y < 0)
      nr_cat2++;
    endif
  endfor
  
  ## calculez procentajul ca fiind nr de imagini corect identificate supra
  ## nr total de imagini
  percentage = (double)(nr_cat1 + nr_cat2)/(nr1 + nr2);
  
endfunction