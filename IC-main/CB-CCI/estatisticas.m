clear all
close all
clc

di=datenum(1993,01,01);
df=datenum(2013,12,31);
path_in=['D:\novoscb23\'];
path_out=['D:\estatisticascb\'];

cd D:\estatisticascb
fid = fopen('estatisticas_cb23.dat','wt');

aux=1;
xx=0;


for y=1993:2013
    for m=1:12
           
        f=[path_in, 'cb23_' sprintf('%04g',y) sprintf('%02g',m) '.dat'];
        d=load(f);
        Q=d(:,4);
        dp=std(Q);
        md=mean(Q);
        
        D(aux,1) = dp;
        D(aux,2) = md;
        aux = aux+1;
        
        
        fprintf(fid,'%04g %02g %6.3f %6.3f\n',y,m,md,dp);
    end
end

fclose(fid);