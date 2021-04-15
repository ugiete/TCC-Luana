clear all
close all
clc


path_in=['D:\dadoshycom\'];
path_out=['D:\cbnovo\'];
ncfile = [path_in,'hycom_reanalysis_19930101' '.nc'];
lat=nc_varget(ncfile,'lat');
lon=nc_varget(ncfile,'lon');


di=datenum(1993,01,01);
df=datenum(1993,12,31);
% lat=nc_varget('hycom_reanalysis_20081020.nc','lat');
% lon=nc_varget('hycom_reanalysis_20081020.nc','lon');
[lon,lat]=meshgrid(lon,lat);


%fid = fopen('cbtransporte.dat','wt');

aux=1;

for t=di:df
    dd=datevec(t);
    f=[path_in,'hycom_reanalysis_' sprintf('%04g',dd(1)) sprintf('%02g',dd(2)) sprintf('%02g',dd(3)) '.nc'];
    
%     file = ['cb_' sprintf('%04g',dd(1)) sprintf('%02g',dd(2)) '.dat'];
%     
%     if ~exist(file,'file')
%       %  fclose(fid); f
%            
%         fid = fopen(file,'wt');
%     end
    
    
    v=nc_varget(f,'water_v',[0 0 0 0],[1 28 163 213]);
    u=nc_varget(f,'water_u',[0 0 0 0],[1 28 163 213]);
    
    
    
    
    c = 113;
    i1=1;
    j1=1;
    
    latmin=85;
    latmax=65;
    lonmin=104;
    lonmax=124;
    
    
    vl=latmin-latmax;
    vll=lonmin-lonmax;
    
    %encontrando os valores da seção
    for i=latmin:-1:latmax
        for j=lonmin:lonmax
            if j==c
                U(:,i1) = u(1,:,i,j);
                V(:,i1) = v(1,:,i,j);
                lat1(i1) = lat(i,j);
                lon1(i1) = lon(i,j);
                i1=i1+1;
                
            end
        end
        c = c+1;
    end
    
    
    %tamanho dL e dZ
    dL=m_lldist([lon(1) lon(2)],[lat(1) lat(2)])*1000;
    depth=nc_varget(f,'depth');
    for i=1:length(depth)-1;
        dZ(i)=depth(i+1)-depth(i);
    end
    
    % matriz dZ dL
    dZ=dZ(1:28)';
    [ni,nj]=size(U);
    dL=ones(ni,nj)*dL;
    dZ=repmat(dZ,1,nj);
    
    %calculo area e vazão
    dA=dZ.*dL;
    U=U(:,1:19);
    V=V(:,1:19);
    dA=dA(:,1:19);
    
    dist = linspace(0,242,-20);
    dist = repmat(dist,28,1);
    
    d = depth(1:28);
    d = repmat(d,1,-20);
    
         figure(1)
     contourf(dist,d*-1,V,30,'linestyle','none')
      title([sprintf('%04g',dd(1)) sprintf('%02g',dd(2)) sprintf('%02g',dd(3))])
%       caxis([-.6 .6])
      colorbar
     axis equal
    
 %   drawnow
    
    vz=(V*sind(45)+U*cosd(45)).*dA; % transecto orientado 45� � uma linha horizontal
    
    % U V = Componentes da velocidade
    % x normal = cosseno / y normal = seno 
    
    %zerando valores positivos e NaN
    vz(vz>0)=0;
    vz(isnan(vz))=0;
    
    %somando vazao/ vazao em notação oceanografica(Sv)
    vz=sum(vz(:));
    vz=vz/1e06;
    
    Q(aux) = vz;
    aux = aux+1;
    %fprintf(fid,'%04g %02g %02g %6.3f\n',dd(1),dd(2),dd(3),vz);
    
end


