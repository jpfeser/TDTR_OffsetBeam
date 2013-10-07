function [Vout,Vin,ratio] = BO_TDTR_getVout(tdelay,SysParam,xoffset)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[deltaR_data0,ratio_data0]=BO_TDTR_Sig(tdelay,SysParam,xoffset);
Vout = imag(deltaR_data0);  
Vin = real(deltaR_data0);
ratio = -Vin/Vout;
end

