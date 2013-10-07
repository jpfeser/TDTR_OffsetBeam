function [Vout,Vin,ratio]=BO_TDTR_Scan(td,SysParam,xvect)
%BO_TDTR_Scan(td,SysParam,xvect) the TDTR beam offset scan signal
%(in-phase, out-of-phase, and ratio) for a vector of "beam offsets", xvect.
% It will attempt to use parallel processors if the MATLAB toolbox and
% hardware exists (much faster), but it isn't necessary.  Input parameter
% definitions:
%
% td:  time delay (scaler) 
% SysParam: object that specifies thermal/laser
%   system, created using "BO_TDTR_Define_System" functions
% xvect: vector of beam offset (probe axis distance from pump axis)
% locations to simulate.

Vout = zeros(size(xvect));
Vin = zeros(size(xvect));
ratio = zeros(size(xvect));

if license('test','distrib_computing_toolbox')
    parfor i=1:length(xvect)
            [Vout(i),Vin(i),ratio(i)] = BO_TDTR_getVout(td,SysParam,xvect(i))
    end
else
    for i=1:length(xvect)
            [Vout(i),Vin(i),ratio(i)] = BO_TDTR_getVout(td,SysParam,xvect(i))
    end
end