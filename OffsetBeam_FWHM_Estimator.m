clear all
%close all

%Anticipated system properties (initial guess for fitting, if you do fitting/errorbar estimation)
%-------------TYPE THERMAL SYSTEM PARAMTERS HERE--------------
abslayer =22;
lambda=[100 0.2 1.40]; %W/m-K
C=[2.4 0.1 1.67]*1e6; %J/m^3-K
t=[1 1 1e6]*1e-9; %m ("Al" thickness estimated at 84nm=81nm Al+3nm oxide, from picosecond acoustic)
eta=1*ones(1,numel(lambda)); %isotropic layers, eta=kx/ky;
senseplot=1;

SysParam.lambda=lambda;
SysParam.C=C;
SysParam.t=t;
SysParam.eta=eta;
%Cstrtio3=2.663e6;
%Claalo3=2.800e6;

tdelay = -200e-12;
r      = 1.0e-6; 
f      = 1.0e6;

SysParam.tau_rep=1/80e6; %laser repetition period, s
SysParam.f=f; %laser Modulation frequency, Hz
SysParam.r_pump=r; %pump 1/e^2 radius, m
SysParam.r_probe=r; %probe 1/e^2 radius, m
SysParam.A_pump=30e-3; %laser power (Watts) . . . only used for amplitude est.
SysParam.TCR=1e-4; %coefficient of thermal reflectance . . . only used for amplitude est.

SysParam_base = SysParam;

i=1
%base case
CalcFWHMs_RadialOffset
FWHM(i)
Vout_max(i)
phase(i)

i=2
SysParam.eta(1) = 0;
%base case
CalcFWHMs_RadialOffset
FWHM(i)
Vout_max(i)
phase(i)

FOM(1)=phase(2)-phase(1);
FOM(2)=(FWHM(2)-FWHM(1))/FWHM(2);
FOM(3)=(Vout_max(2)-Vout_max(1))/Vout_max(2);

FOM'