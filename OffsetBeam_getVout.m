function [Vout,Vin,phase] = OffsetBeam_getVout(tdelay,SysParam,xoffset)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[deltaR_data0,ratio_data0]=TDTR_REFL_DOUGHNUT_V2(tdelay,SysParam,xoffset);
Vout = imag(deltaR_data0);  
Vin = real(deltaR_data0);
phase = angle(deltaR_data0)*180/pi;
end

