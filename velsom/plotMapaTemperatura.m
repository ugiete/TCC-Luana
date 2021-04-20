function plotMapaTemperatura(arquivo, ind)
  [profundidades, latitudes, longitudes, temperatura] = readCSV(arquivo);
  [nLon, nLat, nProf] = size(temperatura);
  
  temperaturas_10m = zeros(nLat, nLon);
  
  for lon = 1:nLon
    for lat = 1:nLat
      temperaturas_10m(lat, lon) = temperatura(lon, lat, ind);
    endfor
  endfor

  if ind == 6
    title("Temperatura à 10m");
  else
    title("Temperatura à 1000m");
  endif
   
  ylabel("Latitude");
  xlabel("Longitude");
  contourf(longitudes, latitudes, temperaturas_10m);
endfunction