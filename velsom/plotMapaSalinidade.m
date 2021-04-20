function plotMapaSalinidade(arquivo, ind)
  [profundidades, latitudes, longitudes, salinidade] = readCSV(arquivo);
  [nLon, nLat, nProf] = size(salinidade);
  
  salinidades_10m = zeros(nLon, nLat);
  
  for lon = 1:nLon
    for lat = 1:nLat
      salinidades_10m(lon, lat) = salinidade(lon, lat, ind);
    endfor
  endfor
  
  title("Salinidade à 10m");
  ylabel("Latitude");
  xlabel("Longitude");
  
  shpfile = './LINHA_DE_COSTA_IMAGEM_GEOCOVER_SIRGAS_2000.shp';
  s = shaperead(shpfile,'UseGeoCoords',true);
  LAT = (s.Lat);
  LON = (s.Lon);
  
  [lon, lat] = meshgrid(latitudes, longitudes);

  m_proj('lambert','lat',[min(min(lat)) max(max(lat))],'lon',[min(min(lon)) max(max(lon))]);
  m_line(LON(1,:),LAT(1,:),'color','k','linewidth',1.5);
  m_grid('box','fancy','linestyle','-','gridcolor','k','fontsize',12,'fontweight','bold');
  hold on;
  
  imgg2 = m_contourf(lon, lat, salinidades_10m, 70);
  colorbar
  xlabel('Longitude','fontsize',14,'fontweight','bold');
  ylabel('Latitude','fontsize',14,'fontweight','bold');
  title("Salinidade à 10m",'fontsize',14,'fontweight','bold');
  set(gca,'Fontsize',18,'fontweight','bold');
endfunction
