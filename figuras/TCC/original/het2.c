#include "mex.h"
#include "stdio.h"
void fhet1_(long long int*,long long int*,double*,double*,long long int*,long long int*,long long int*,double*,double*,double*,long long int*,long long int*,long long int*);
void mexFunction(int nlhs, mxArray *plhs[],int nrhs, const mxArray *prhs[])
{
 long long int *nx,*ny;
 long long int *jfonte,*ifonte,*parq,*N,*tipo,*fonte;
 double *dx,*dt,*atraso,*LT,*cw;


 dx = (double*)mxGetData(prhs[0]);
 dt = (double*)mxGetData(prhs[1]);
 N = (long long int*)mxGetData(prhs[2]);
 nx = (long long int*)mxGetData(prhs[3]);
 ny = (long long int*)mxGetData(prhs[4]);
 jfonte = (long long int*)mxGetData(prhs[5]);
 ifonte = (long long int*)mxGetData(prhs[6]);
 atraso = (double*)mxGetData(prhs[7]);
 LT = (double*)mxGetData(prhs[8]);
 cw = (double*)mxGetData(prhs[9]);
 parq = (long long int*)mxGetData(prhs[10]);
 tipo = (long long int*)mxGetData(prhs[11]);
 fonte = (long long int*)mxGetData(prhs[12]);
   
 fhet1_(nx,ny,dx,dt,N,jfonte,ifonte,atraso,LT,cw,parq,tipo,fonte);
 return;
}