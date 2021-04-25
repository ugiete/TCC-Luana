close all
clear all
clc
%mex het2.c fhet2.f90 -lgfortran


tipo = 2; %Abc 1D = 1 e Abc 2D= 2 
fonte = 2; %2=Dos Santos/Senoidal, %1 = chapeu do roger transformado
f = 80; %frequencia da onda que se propaga a velocidade cw

atraso = 1/f;
%t = 0:0.001:.8;
%atraso = 0.08;

%Definicao das variaveis

E1=2.25*10^9;    %!modulo de compressibilidade da agua (kg/m/s^2)
E2=3.90*10^10;   %!modulo de compressibilidade da rocha (kg/m/s^2) == ( 0.39x10^12 dyn/cm^2)

alfa=10;
beta=4;
parq = 100;    %numero de passos para proximo armazenamento
%cw1= 1535;
%cw2= 1480;
%L1=cw1/f;
%L2=cw2/f;
%Lw=min(L1,L2);
%dx=Lw/30;
%dx = cmin/(alfa*f);
dx = 1;
dy = dx;



%Lx = 8*Lw; %dimensao fisica x 
%Ly = 8*Lw;  %dimensao fisica y
Lx = 8898; Ly = 5001;
x = 0:dx:Lx-1;
y = 0:dy:Ly-1;

%x=[-200:dx:300];
nx=length(x); %numero de pontos em x
%y=[-150:dy:350];
ny=length(y); %numero de pontos em y
[X, Y] = meshgrid (x, y);

%[ans,ifonte] = min(abs(x));
%[ans,jfonte] = min(abs(y)); %(0,0) posicao da fonte
ifonte = 500; jfonte = 2;

%campo de velocidade
%cw=zeros(ny,nx);
cw = dlmread("../2704W_2024S_2032S.csv");


%M1
%cw(:,:)=4000;
%cw(1:250,:)=2000;

%M2
##cw(1:100,:)=2000;
##cw(101:200,:)=2500;
##cw(201:300,:)=3000;
##cw(301:400,:)=3250;
##cw(401:500,:)=3500;
##cw(501:600,:)=4000;

%M3
##cw(1:200,1:300) = 2000;
##cw(1:200,301:700) = 2250;
##cw(1:200,701:1101) = 2500;
##cw(201:400,1:300) = 2750;
##cw(201:400,301:700) = 3000;
##cw(201:400,701:1101) = 3250;
##cw(401:601,1:300) = 3500;
##cw(401:601,301:700) = 3750;
##cw(401:601,701:1101) = 4000;

%M4
##cw=zeros(ny,nx);
##cw(:,:)=4000;
##cw(1:115,:)=2000;
##cw(116:231,:)=2500;
##cw(232:324,:)=3000;
##cw(171:286,400:690)=4000;

%M5
##for i=1:nx
##  for j=1:ny
##    if(y(j)<=200 || (x(i)>=550 && y(j)<=300))
##      cw(j,i) = 2000;
##    elseif((x(i)<=450 && y(j)<=400) || (x(i)>=450 && y(j)<=400 && y(j)>=300) || (x(i)>= 750 && y(j)>=400 && y(j)<=500))
##      cw(j,i) = 3000;
##    elseif((x(i)<=650 && y(j)>=400) || y(j)>=500)
##      cw(j,i) = 4000;
##    endif
##    
##    if(y(j)>=200 && y(j)<=300 && x(i)>=450 && x(i)<=550)
##      if(x(i)-450>=y(j)-200)
##        cw(j,i)=2000;
##      else
##        cw(j,i)=3000;
##      endif
##    endif
##    
##    if(y(j)>=400 && y(j)<=500 && x(i)>=650 && x(i)<=750)
##      if(x(i)-650>=y(j)-400)
##        cw(j,i)=3000;
##      else
##        cw(j,i)=4000;
##      endif
##    endif
##    
##  endfor
##endfor

%M6
##cw(:,:) = 4000;
##cw(1:114,:) = 2000;
##cw(115:207,174:928) = 2000;
##cw(115:138,116:986) = 2000;
##cw(208:264,232:870) = 3000;
##cw(265:334,290:812) = 3000;
##cw(335:381,348:754) = 3000;
##cw(382:405,406:696) = 3000;


mate=zeros(ny,nx);
mate(:,:) = E1;
%mate(1:250,:) = E2;

%======
ds=sqrt(dx*dx+dy*dy);
Emin=min(E1/E2,E2/E1);
Cmax=max(cw(:));
%fdt=Emin;
fdt=1;
dt3=fdt*dx*dy/ds/Cmax;
%======
dt1=1/f/60;
dt2=dx/(beta*Cmax);
dt=min(dt1,dt2);
dt=min(dt,dt3);
tfinal=25/f;
%final=0.5;
N = floor(tfinal/dt);

%plot(t,fonte(LT,t))

het2(dx,dt,uint64(N),uint64(nx),uint64(ny),uint64(jfonte),uint64(ifonte),atraso,f,cw,uint64(parq),uint64(tipo),uint64(fonte),mate)
##for i=parq:parq:N
##p=load(strcat('resultados/p',num2str(i),'.mat'));
##contourf(X,Y,p)
##title(strcat('t=',num2str(i*dt)))
##pause(dt)
##endfor
