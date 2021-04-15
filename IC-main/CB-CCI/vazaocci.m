clear all
close all
clc

di=datenum(1993,01,01);
df=datenum(2012,31,12);
lat=nc_varget('hycom_reanalysis_19930101.nc','lat');
lon=nc_varget('hycom_reanalysis_19930101.nc','lon');
[lon,lat]=meshgrid(lon,lat);

%fid = fopen('ccitransporte.dat','wt');

aux=1

for t=di:df
    dd=datevec(t);
    f=['hycom_reanalysis_' sprintf('%04g',dd(1)) sprintf('%02g',dd(2)) sprintf('%02g',dd(3)) '.nc'];
    file=['cci_' sprintf('%04g',dd(1)) sprintf('%02g',dd(2)) '.dat'];
    
     if ~exist(file, 'file');
%         fclose(fid);
         fid=fopen(file, 'wt');
     end
    
    v=nc_varget(f,'water_v',[0 27 0 0],[1 6 163 213]);
    u=nc_varget(f,'water_u',[0 27 0 0],[1 6 163 213]);
    
    c=127;
    i1=1;
    j1=1;
    
    for i=100:-1:82
        for j=127:145
            if j==c
                U(:,i1) = u(1,:,i,j)';
                V(:,i1) = v(1,:,i,j)';
                lat1(i1) = lat(i,j);
                lon1(i1) = lon(i,j);
                i1=i1+1;
                
            end
        end
        c = c+1;
    end
    
    dL=m_lldist([lon(1) lon(2)],[lat(1) lat(2)])*1000;
    depth=nc_varget(f,'depth');
    for i=1:length(depth)-1;
        dZ(i)=depth(i+1)-depth(i);
    end
    
    dZ=dZ(28:33)';
    [ni,nj]=size(U);
    dL=ones(ni,nj)*dL;
    dZ=repmat(dZ,1,nj);
    
    dA=dZ.*dL;
    vz=(V*sind(45)+U*cosd(45)).*dA;
    
    vz(vz<0)=0;
    vz(isnan(vz))=0;
    
    vz=sum(vz(:));
    vz=vz/1e06;
    
    Q(aux) = vz;
    aux = aux+1;
    
    fprintf('fid', '%04g %02g %02g %6.3f\n', dd(1),dd(2),dd(3),vz);
end
       
                