%Calculates the Reflectivity
%In order to speed up the code, it is parallelized...the convention is...
%tdelay is COLUMN vector of desired delay times
%Mvect (the fourier components) are ROW vectors
%Matrices have size, length(tdelay) x length(Mvect)
function [deltaR,ratio]=BO_TDTR_Sig(tdelay,SysParam,EXTRA)

lambda=SysParam.lambda;
C=SysParam.C;
h=SysParam.h;
r_probe=SysParam.r_probe;
r_pump=SysParam.r_pump;
eta=SysParam.eta;
tau_rep=SysParam.tau_rep;
A_pump=SysParam.A_pump;
TCR=SysParam.TCR;
f=SysParam.f;

fmax=10/min(abs(tdelay)); %maximum frequency considered
ii=sqrt(-1);

M=10*ceil(tau_rep/min(abs(tdelay))); %Highest Fourier component considered
mvect=-M:M; %Range of Fourier components to consider (Vector)
fudge1=exp(-pi*((mvect/tau_rep+f)/fmax).^2);%artificial decay (see paper)
fudge2=exp(-pi*((mvect/tau_rep-f)/fmax).^2);

dT1=zeros(1,length(mvect))';
dT2=zeros(1,length(mvect))';
kmax=1/sqrt(r_pump^2+r_probe^2)*2;

    dT1=rombint_multi(@(kvect) BO_TDTR_TEMP(kvect,mvect/tau_rep+f,lambda,C,h,eta,r_pump,r_probe,A_pump,EXTRA),0,kmax,length(mvect));
    dT2=rombint_multi(@(kvect) BO_TDTR_TEMP(kvect,mvect/tau_rep-f,lambda,C,h,eta,r_pump,r_probe,A_pump,EXTRA),0,kmax,length(mvect));
    
expterm=exp(ii*2*pi/tau_rep*(tdelay*mvect));
Retemp=(ones(length(tdelay),1)*(dT1'.*fudge1+dT2'.*fudge2)).*expterm;
Imtemp=-ii*(ones(length(tdelay),1)*(dT1-dT2)').*expterm;

Resum=sum(Retemp,2); %Sum over all Fourier series components
Imsum=sum(Imtemp,2);

deltaRm=TCR*(Resum+ii*Imsum); %
deltaR=deltaRm.*exp(ii*2*pi*f*tdelay); %Reflectance Fluxation (Complex)

ratio=-real(deltaR)./imag(deltaR);
