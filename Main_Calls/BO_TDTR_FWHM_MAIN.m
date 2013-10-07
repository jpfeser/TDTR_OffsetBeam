clear all
%close all

%Anticipated system properties (initial guess for fitting, if you do fitting/errorbar estimation)
%-------------TYPE THERMAL SYSTEM PARAMTERS HERE--------------
abslayer =22;
lambda=[100 0.2 1.40]; %W/m-K
C=[2.4 0.1 1.67]*1e6; %J/m^3-K
h=[100 1 1e6]*1e-9; %m ("Al" thickness estimated at 84nm=81nm Al+3nm oxide, from picosecond acoustic)
eta=1*ones(1,numel(lambda)); %isotropic layers, eta=kx/ky;

tdelay = -200e-12;
r      = 1.0e-6; 
f      = 1.0e6;

tau_rep = 1/80e6;
A_pump = 0.1*10e-3;
TCR = 1e-4;
SysParam = BO_TDTR_Define_System(lambda,C,h,eta,r,r,f,tau_rep,A_pump,TCR)

[FWHM,Vout_max,Vin_max,ratio_max] = BO_TDTR_FWHM(SysParam,tdelay);
FWHM
