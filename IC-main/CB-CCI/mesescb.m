clear all
close all
clc


path_in=['D:\estatisticascb\'];

cd D:\estatisticascb\ 

fid = fopen('meses_cb23.dat','wt');

a = load('estatisticas_cb23.dat');


for i=1:12
    mj=a(i:12:end,3);
    m=mean(mj);
    dp=std(mj);
    
    fprintf(fid,'%02g %6.3f %6.3f\n', i, m, dp);
end

fclose(fid);