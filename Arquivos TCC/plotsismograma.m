load('sismograma.mat')
t=0:dt:(N-1)*dt;
pcolor(x,t,sismograma)
shading interp
colormap(gray)
axis 'ij'
%ylim([0 0.5])
xlabel('(m)')
ylabel('(s)')
caxis([min(sismograma(:)) max(sismograma(:))]./25)
set(gca, "fontsize", 16);
ybounds=ylim();
%set(gca, "ytick", ybounds(1):0.05:ybounds(2));
%set (gca, "yticklabel", cellstr (num2str (get (gca, "ytick")(:), "%.2f")));