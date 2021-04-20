function plotSalinidade(arquivo)
  [profundidades, latitudes, longitudes, salinidade] = readCSV(arquivo);
  [nLon, nLat, nProf] = size(salinidade);
  
  for lon = 140:nLon
    for lat = 1:nLat
      salinidades = salinidade(lon, lat, :);
      
      plot(salinidades, profundidades);
      set (gca (), "ydir", "reverse")
      set(gca, "xaxislocation", "top")
      break
    endfor
    break
  endfor
endfunction
