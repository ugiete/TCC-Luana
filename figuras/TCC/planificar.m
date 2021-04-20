function plano = planificar(matriz3D)
  [numLongitudes, numLatitudes, numProfundidades] = size(matriz3D);
  
  plano = ones(numLongitudes, numLatitudes * numProfundidades);
  
  for lin = 1:numLongitudes
    for col = 1:numLatitudes*numProfundidades
      lon = lin;
      lat = idivide(col, numProfundidades, "ceil");
      resto = mod(col, numProfundidades);
      
      if resto == 0
        prof = numProfundidades;
      else
        prof = resto;
      endif
      
      plano(lin, col) = matriz3D(lon, lat, prof);
    endfor
  endfor
endfunction
