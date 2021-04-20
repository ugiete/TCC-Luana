 subroutine fhet1(nx,ny,dx,dt,N,jfonte,ifonte,atraso,LT,cw,parq,tipo,fonte,mate)
 implicit none

 integer*8 j,i,k
 integer*8 nx,ny,jfonte,ifonte,parq,N,tipo,fonte
 real*8 dx,dt,t,atraso,LT,dt2,dx2,dy2,dy,mate(ny,nx)
 real*8 GxJ(ny,nx),GIy(ny,nx),CxJ(ny,nx),CIy(ny,nx)
 real*8 PP(ny,nx),PN(ny,nx),PL(ny,nx),cw(ny,nx),cte1,fc2
 real*8 C1,C2,C3,C4,E1
 real*8 pi
 character(30) nstr

 pi =4.D0*DATAN(1.D0)
 fc2 = (3*dsqrt(pi)*lt)**2.d0;
 E1=2.25D0*(10.D0**9.D0)
 10 format(I12)
 open(2,file='sismograma.mat')
 ! GAMMA
 do j=1,ny-1
  do i=1,nx-1
  GxJ(j,i)=0.5*(mate(J,i)+mate(J,i+1))
  GIy(j,i)=0.5*(mate(j,I)+mate(j+1,I))
  CxJ(j,i)=0.5*(cw(J,i)+cw(J,i+1))
  CIy(j,i)=0.5*(cw(j,I)+cw(j+1,I))
  enddo
 enddo
 GxJ=CxJ*CxJ/GxJ
 GIy=CIy*CIy/GIy
 !===========================

 dt2=dt*dt
 dy=dx
 dx2=dx*dx
 dy2=dx2
 
 PP=0;PN=0;PL=0;
 
 do k=1,N
 t=k*dt


  if (tipo.eq.2) then !ABC 2D

  i=nx; j=ny; PN(j,i)=PL(j,i)-cw(j-1,i)*dt/dy*(PL(j,i)-PL(j-1,i)); 
        j=1;  PN(j,i)=PL(j,i)+cw(j,i)*dt/dy*(PL(j+1,i)-PL(j,i)); 

   PP(2:ny-1,nx)=2.*PN(2:ny-1,nx)-PL(2:ny-1,nx)-CW(2:ny-1,nx-1)*dt/dx*((PN(2:ny-1,nx) &
   -PL(2:ny-1,nx))-(PN(2:ny-1,nx-1)-PL(2:ny-1,nx-1))) &
   +0.5*dt2/dy2*cw(2:ny-1,nx-1)*cw(2:ny-1,nx-1)*(PN(3:ny,nx)-2.*PN(2:ny-1,nx)+PN(1:ny-2,nx))

  i=1; j=ny; PN(j,i)=PL(j,i)-cw(j-1,i)*dt/dy*(PL(j,i)-PL(j-1,i)); 
       j=1;  PN(j,i)=PL(j,i)+ cw(j,i)*dt/dy*(PL(j+1,i)-PL(j,i)); 

   PP(2:ny-1,1)=2.*PN(2:ny-1,1)-PL(2:ny-1,1)+CW(2:ny-1,1)*dt/dx*((PN(2:ny-1,2) &
   -PL(2:ny-1,2))-(PN(2:ny-1,1)-PL(2:ny-1,1))) &
   +0.5*dt2/dy2*cw(2:ny-1,1)*cw(2:ny-1,1)*(PN(3:ny,1)-2.*PN(2:ny-1,1)+PN(1:ny-2,1))

   PP(ny,2:nx-1)=2.*PN(ny,2:nx-1)-PL(ny,2:nx-1)-CW(ny-1,2:nx-1)*dt/dy*((PN(ny,2:nx-1) &
   -PL(ny,2:nx-1))-(PN(ny-1,2:nx-1)-PL(ny-1,2:nx-1))) &
   +0.5*dt2/dx2*cw(ny-1,2:nx-1)*cw(ny-1,2:nx-1)*(PN(ny,3:nx)-2.*PN(ny,2:nx-1)+PN(ny,1:nx-2))

   PP(1,2:nx-1)=2.*PN(1,2:nx-1)-PL(1,2:nx-1)+CW(1,2:nx-1)*dt/dy*((PN(2,2:nx-1) &
   -PL(2,2:nx-1))-(PN(1,2:nx-1)-PL(1,2:nx-1))) &
   +0.5*dt2/dx2*cw(1,2:nx-1)*cw(1,2:nx-1)*(PN(1,3:nx)-2.*PN(1,2:nx-1)+PN(1,1:nx-2)) 

  else  !ABC 1D
	PP(1:ny,nx)=PN(1:ny,nx)-cw(1:ny,nx)*dt/dx*(PN(1:ny,nx)-PN(1:ny,nx-1))
	PP(1:ny,1)=PN(1:ny,1)+cw(1:ny,1)*dt/dx*(PN(1:ny,2)-PN(1:ny,1))
	PP(ny,1:nx)=PN(ny,1:nx)-cw(ny,1:nx)*dt/dy*(PN(ny,1:nx)-PN(ny-1,1:nx))
	PP(1,1:nx)=PN(1,1:nx)+ cw(1,1:nx)*dt/dy*(PN(2,1:nx)-PN(1,1:nx))
  endif

  do i=2,nx-1
  do j=2,ny-1
	C1=mate(j,i)*GxJ(j,i)*dt*dt/(dx*dx)
	C2=mate(j,i)*GxJ(j,i-1)*dt*dt/(dx*dx) 
	C3=mate(j,i)*GIy(j,i)*dt*dt/(dy*dy) 
	C4=mate(j,i)*GIy(j-1,i)*dt*dt/(dy*dy)
	PP(j,i)=2*PN(j,i)-PL(j,i)+ C1*(PN(j,i+1)-PN(j,i))-C2*(PN(j,i)-PN(j,i-1))+ C3*(PN(j+1,i)-PN(j,i))- C4*(PN(j,i)-PN(j-1,i))
  enddo
  enddo
 
  if (fonte.eq.1) then
	cte1=-0.25d0*pi*fc2*(t-atraso)**2.d0
	PP(jfonte,ifonte) = PP(jfonte,ifonte) + dt2*(1.d0+2.d0*cte1)*dexp(cte1)    !1/dsqrt(2*pi)
  else
  PP(jfonte,ifonte) = PP(jfonte,ifonte) + E1*dt2*((1.D0-2.D0*((pi*LT*(t-atraso))**2.D0))*exp(-((pi*LT*(t-atraso))**2.D0)))
	!PP(jfonte,ifonte) = PP(jfonte,ifonte) - dt2*dsin(2*pi*LT*t)
  endif
  PL=PN
  PN=PP

  write(2,*) PP(jfonte,:)

  if(mod(k,parq)==0) then
  write(nstr,10) k
  nstr = 'resultados/p'//trim(adjustl(nstr))//'.mat'
  open(1,file=trim(nstr))
  do i=1,ny
	write(1,*) PP(i,:)
  enddo
  close(1)
  endif

 enddo

 close(2)

 return
 end subroutine fhet1
