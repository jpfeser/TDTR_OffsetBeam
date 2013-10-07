function [System] = BO_TDTR_Define_System(lambda,C,h,eta,r_pump,r_probe,f,tau_rep,A_pump,TCR)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

System.lambda=lambda;
System.C=C;
System.h=h;
System.eta=eta;
System.tau_rep=tau_rep; %laser repetition period, s
System.f=f; %laser Modulation frequency, Hz
System.r_pump=r_pump; %pump 1/e^2 radius, m
System.r_probe=r_probe; %probe 1/e^2 radius, m
System.A_pump=A_pump; %laser power (Watts) . . . only used for amplitude est.
System.TCR=TCR; %coefficient of thermal reflectance . . . only used for amplitude est.

end

