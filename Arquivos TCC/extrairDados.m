function [latitudes, longitudes, salinidades, temperaturas] = extrairDados(arquivo)  
  % Explorar dados
  %ncdisp(arquivo)
  
  latitudes = ncread(arquivo, 'lat');
  longitudes = ncread(arquivo, 'lon');
  
  salinidades = ncread(arquivo, 'salinity');
  temperaturas = ncread(arquivo, 'water_temp');
endfunction
