for i=parq:parq:N
  x=load(strcat('resultados/p',num2str(i),'.mat'));
  surfc(x)
  title(strcat('p',num2str(i),'.mat'))
  %colormap(jet)
  %shading interp
  %colorbar
  axis tight
  xlabel('x (m)');
  ylabel('y (m)');
  zlabel('P (N/m^2)');
  %indice=mat2str(i);
  %filname=strcat("caso2D",indice,".png");
##if (mod(n,10) == 0)
##  disp(["n = " num2str(n)])
##  print(fig, filname, "-dpng");
##endif
endfor
