close all
clear all
clc
%mex het2.c fhet2.f90 -lgfortran


tipo = 2; %Abc 1D = 1 e Abc 2D= 2 
fonte = 2; %2=senoidal, %1 = chapeu do roger transformado
f = 80; %frequencia da onda que se propaga a velocidade cw

atraso = 1/f;
%t = 0:0.001:.8;
%atraso = 0.08;

%Definicao das variaveis

E1=2.25*10^9;    %!modulo de compressibilidade da agua (kg/m/s^2)
E2=3.90*10^10;   %!modulo de compressibilidade da rocha (kg/m/s^2) == ( 0.39x10^12 dyn/cm^2)

alfa=10;
beta=4;
parq = 10;    %numero de passos para proximo armazenamento
cw1= 4000;
cw2= 2000;
L1=cw1/f;
L2=cw2/f;
Lw=min(L1,L2);
%dx=Lw/30;
%dx = cmin/(alfa*f);
dx = 1;
dy = dx;



%Lx = 8*Lw; %dimensao fisica x 
%Ly = 8*Lw;  %dimensao fisica y
Lx = 1100; Ly = 600;
x = 0:dx:Lx;
y = 0:dy:Ly;

%x=[-200:dx:300];
nx=length(x); %numero de pontos em x
%y=[-150:dy:350];
ny=length(y); %numero de pontos em y
[X, Y] = meshgrid (x, y);

%[ans,ifonte] = min(abs(x));
%[ans,jfonte] = min(abs(y)); %(0,0) posicao da fonte
ifonte = 550; jfonte = 2;

%campo de velocidade
cw=zeros(ny,nx);
cw(:,:) = 4000;
cw(1:114,:) = 2000;
cw(115:207,174:928) = 2000;
cw(115:138,116:986) = 2000;
cw(208:264,232:870) = 3000;
cw(265:334,290:812) = 3000;
cw(335:381,348:754) = 3000;
cw(382:405,406:696) = 3000;


mate=zeros(ny,nx);
mate(:,:) = 2000;
mate(1:250,:) = E2;



dt1=1/f/60;
dt2=dx/(beta*max(cw(:)));
dt=min(dt1,dt2);
%tfinal=25/f;
tfinal=0.5;
N = floor(tfinal/dt);

%plot(t,fonte(LT,t))

het2(dx,dt,uint64(N),uint64(nx),uint64(ny),uint64(jfonte),uint64(ifonte),atraso,f,cw,uint64(parq),uint64(tipo),uint64(fonte),mate)
%for i=parq:parq:N
% p=load(strcat('resufados/p',num2str(i),'.mat'));
% contourf(X,Y,p)
% title(strcat('t=',num2str(i*dt)))
%  pause(dt)
% endfor