function [Sig_Rat,Sig_Amp]=Offset_Beam_EvalScan(xvect,lambda,C,t,eta,r,f,td)

% %Anticipated system properties (initial guess for fitting, if you do fitting/errorbar estimation)
% lambda=[111 0.04 0.09]; %W/m-K, thermal conductivity. Lambda(1) is the top layer of the structure.
% C=[2.42 0.01 1.61]*1e6; %J/m^3-K, specific heat capacity
% abslayer=10; %absorption depth in nm
% t=[32.8 1 1e6]*1e-9; %m, layer thicknesses
% %lambda(1)=abslayer*lambda(2); %top 1nm is more conducting (and has more capacitance) than the rest of layer (simulates absorbtion)
% %C(1)=abslayer*C(2); %top 1nm 10X rest of layer
% eta=ones(1,numel(lambda)); %isotropic layers, eta=kx/ky;
% 

SysParam.lambda=lambda;
SysParam.C=C;
SysParam.t=t;
SysParam.eta=eta;

SysParam.tau_rep=1/80e6; %laser repetition period, s
SysParam.f=f; %laser Modulation frequency, Hz
SysParam.r_pump=r; %pump 1/e^2 radius, m
SysParam.r_probe=r; %probe 1/e^2 radius, m
SysParam.A_pump=30e-3; %laser power (Watts) . . . only used for amplitude est.
SysParam.TCR=1e-4; %coefficient of thermal reflectance . . . only used for amplitude est.

Sig_Amp = zeros(size(xvect));
Sig_Rat = zeros(size(xvect));
S_r = zeros(size(xvect));

tdelay = td;
for kk=1:length(xvect)
            [deltaR_data0,ratio_data0]=TDTR_REFL_DOUGHNUT_V2(tdelay,SysParam,xvect(kk));
            Sig_Amp(kk) = deltaR_data0;
            Sig_Rat(kk) = ratio_data0;
            [kk,ratio_data0];
end