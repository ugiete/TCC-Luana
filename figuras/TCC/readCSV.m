function [profundidades, latitudes, longitudes, matriz3D] = readCSV(arquivo)
  csv = csvread(arquivo);
  [linhas, colunas] = size(csv);
  
  prof_cheia = csv(1, :);
  lat_cheia = csv(2, :);
  lon_cheia = csv(3, :);
  
  profundidades = [];
  
  ant = prof_cheia(1) - 1;
  cont = 0;
  ind = 1;
  
  while ind <= colunas
    atual = prof_cheia(ind);
    
    if atual > ant
      cont++;
      profundidades(cont) = atual;
      ant = atual;
      ind++;
    else
      break
    endif
  endwhile
  
  nProfundidades = cont;
  
  latitudes = [];
  
  ant = lat_cheia(1) - 1;
  cont = 0;
  ind = 1;
  
  while ind <= colunas
    atual = lat_cheia(ind);
    
    if atual > ant && atual < 0.0
      cont++;
      latitudes(cont) = atual;
      ant = atual;
      ind++;
    else
      break
    endif
  endwhile
  
  nLatitudes = cont;
  
  longitudes = [];
  
  ant = lon_cheia(1) - 1;
  cont = 0;
  ind = 1;
  
  while ind <= colunas
    atual = lon_cheia(ind);
    
    if atual > ant && atual < 0.0
      cont++;
      longitudes(cont) = atual;
      ant = atual;
      ind++;
    else
      break
    endif
  endwhile
  
  nLongitudes = cont;
  
  matriz2D = csv(4:linhas, :);
  [linhas, colunas] = size(matriz2D);
  
  matriz3D = zeros(nLongitudes, nLatitudes, nProfundidades);
  
  for l = 1:linhas
    for c = 1:colunas
      lon = l;
      lat = idivide(c, nProfundidades, "ceil");
      resto = mod(c, nProfundidades);
      
      if resto == 0
        prof = nProfundidades;
      else
        prof = resto;
      endif
      
      matriz3D(lon, lat, prof) = matriz2D(l, c);
    endfor
  endfor
endfunction
