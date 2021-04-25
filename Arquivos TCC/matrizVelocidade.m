function velocidades = matrizVelocidade(matrizSalinidade, matrizTemperatura, profundidades)
  [nLon, nLat, nProf] = size(matrizSalinidade);
  %nProf = size(profundidades);
  
  velocidades = zeros(nLon, nLat, nProf);
  
  for lon = 1:nLon
    for lat = 1:nLat
      for prof = 1:nProf
        temperatura = matrizTemperatura(lon, lat, prof);
        salinidade = matrizSalinidade(lon, lat, prof);
        profundidade = profundidades(prof);
        velocidades(lon, lat, prof) = calcVelocidade(temperatura, salinidade, profundidade);
      endfor
    endfor
  endfor
  
endfunction
