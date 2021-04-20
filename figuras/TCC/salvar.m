function salvar()
  profundidades = [0, 2, 4, 6, 8, 10, 12, 15, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80, 90, 100, 125, 150, 200, 250, 300, 350, 400, 500, 600, 700, 800, 900, 1000, 1250, 1500, 2000, 2500, 3000, 4000, 5000];
  limites = [-3, -30, -25, -51];
  datas = [20121231, 20121231];

  readHycom(limites, datas);
  [latitudes, longitudes, salinidade3D, temperatura3D] = extrairDados("./tcc/br_data_20121231.nc");
  
  salinidade2D = planificar(salinidade3D);
  temperatura2D = planificar(temperatura3D);
  
  % O arquivo CSV segue o formato:
  %   Lista de Profundidadades
  %   Lista de Latitudes
  %   Lista de Longitudes
  %   Matriz n x m, onde:
  %       n = Numero de longitudes
  %       m = Numero de profundidades * Numero de latitudes
  %
  %   A cada y colunas representa uma nova latitude, onde:
  %       y = Numero de profundidades
  
  dlmwrite("./tcc/es_salinidade_20121231.csv", profundidades);
  dlmwrite("./tcc/br_salinidade_20121231.csv", latitudes', "-append");
  dlmwrite("./tcc/br_salinidade_20121231.csv", longitudes', "-append");
  dlmwrite("./tcc/br_salinidade_20121231.csv", salinidade2D, "-append");
  
  dlmwrite("./tcc/br_temperatura_20121231.csv", profundidades);
  dlmwrite("./tcc/br_temperatura_20121231.csv", latitudes', "-append");
  dlmwrite("./tcc/br_temperatura_20121231.csv", longitudes', "-append");
  dlmwrite("./tcc/br_temperatura_20121231.csv", temperatura2D, "-append");
endfunction
