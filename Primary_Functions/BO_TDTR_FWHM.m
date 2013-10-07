function [FWHM,Vout_max,Vin_max,ratio_max] = BO_TDTR_FWHM(SysParam,tdelay)
%% First calculate concentric case
xoffset = 0;

[Vout_max,Vin_max,ratio_max] = BO_TDTR_getVout(tdelay,SysParam,xoffset);
 

%% Now find FWHM of xoffset direction
Lpx = sqrt(SysParam.eta(1)*SysParam.lambda(1)/SysParam.C(1)*1/(2*pi*SysParam.f));
xmin_guess = sqrt(SysParam.r_pump*SysParam.r_probe)*0.8; %usually 0.8
xmax_guess = sqrt(SysParam.r_pump^2+Lpx^2)*1.3; %usually 1.3
FWHM = 2*fzero(@(x) 0.5*Vout_max- BO_TDTR_getVout(tdelay,SysParam,x),[xmin_guess,xmax_guess],optimset('Display','iter','TolX',1e-9));
