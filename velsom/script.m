clear all
close all
clc

[profundidades, lat, lon, temperaturas] = readCSV("./tcc/br_temperatura_20121231.csv");
[_, _, _, salinidades] = readCSV("./tcc/br_salinidade_20121231.csv");

profundidades

velocidades = matrizVelocidade(salinidades, temperaturas, profundidades);

vel = figure(1)
plot(velocidades(184, 2, :), profundidades) %213 troca pela indice da longitude e 22 pelo indice da latitude
axis 'ij'
title({"Perfil de velocidade do som na costa do Brasil", "29.92S, 36.40W - 31/12/2012"}, 'fontweight', 'bold') %troca pela longitude e pela latitude
xlabel("Velocidade do som (m/s)")
ylabel("Profundidade (m)")
set(gca, 'ytick', 0:500:5000)
saveas(vel, "./figuras/br_perfil_vel_1.png")

sali = figure(2)
plot(salinidades(184, 2, :), profundidades) %213 troca pela indice da longitude e 22 pelo indice da latitude
axis 'ij'
title({"Perfil de salinidade na costa do Brasil", "29.92S, 36.40W - 31/12/2012"}, 'fontweight', 'bold') %troca pela longitude e pela latitude
xlabel("Salinidade (psu)")
ylabel("Profundidade (m)")
set(gca, 'ytick', 0:500:5000)
saveas(sali, "./figuras/br_perfil_sali_1.png")

temp = figure(3)
plot(temperaturas(184, 2, :), profundidades) %213 troca pela indice da longitude e 22 pelo indice da latitude
axis 'ij'
title({"Perfil de temperatura na costa do Brasil", "29.92S, 36.40W - 31/12/2012"}, 'fontweight', 'bold') %troca pela longitude e pela latitude
xlabel("Temperatura (ºC)")
ylabel("Profundidade (m)")
set(gca, 'ytick', 0:500:5000)
saveas(temp, "./figuras/br_perfil_temp_1.png")