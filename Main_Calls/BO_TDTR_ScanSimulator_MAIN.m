clear all
%Anticipated system properties (initial guess for fitting, if you do fitting/errorbar estimation)
%-------------TYPE THERMAL SYSTEM PARAMTERS HERE--------------
abslayer =22;
lambda=[17 0.2 1.40]; %W/m-K
C=[2.4 0.1 1.67]*1e6; %J/m^3-K
h=[100 1 1e6]*1e-9; %m ("Al" thickness estimated at 84nm=81nm Al+3nm oxide, from picosecond acoustic)
eta=1*ones(1,numel(lambda)); %isotropic layers, eta=kx/ky;

td = 100e-12;
r      = 0.5e-6; 
f      = 1.0e6;
xvect = linspace(0,2*r,20)'; % <---- Define the set of beam offsets to simulate

tau_rep = 1/80e6;
A_pump = 0.1*10e-3;
TCR = 1e-4;
SysParam = BO_TDTR_Define_System(lambda,C,h,eta,r,r,f,tau_rep,A_pump,TCR);
%---------------------------------------------------------------




% Simulate a beam offset scan
[Vout,Vin,ratio]=BO_TDTR_Scan(td,SysParam,xvect);

%reconstruct the rest by symmetry
xvect = [-flipud(xvect);xvect(2:end)];
Vout = [flipud(Vout);Vout(2:end)];
Vin = [flipud(Vin);Vin(2:end)];
ratio = [flipud(ratio);ratio(2:end)];

%plot
plot(xvect,ratio,'o');
axis([min(xvect) max(xvect) 0 max(ratio)*1.3]);

% Fit 1/e2 radius
options = optimset('TolFun',1e-11);
ysol = fminsearch(@(X) sum((Vin- (X(4)+X(1)*exp(-(xvect-X(3)).^2/X(2)^2))).^2),[max(Vin),r,0.001*r,0],options);
fprintf('appearent spot size (um)\n')
w0_appearent = ysol(2)*1e6
fprintf('xcenter\n')
xc = ysol(3)*1e6
figure
plot(xvect,real(Vin),'o',xvect,ysol(4)+ysol(1)*exp(-(xvect-ysol(3)).^2/ysol(2)^2))

%FWHM_modelVout = fwhm(xvect,-imag(Sig_Amp))

saveint=input('Want to save results?\n(0=no, 1=yes)\n');
if saveint==1
    save('BO_ScanSimulation_Output.mat')
    dlmwrite(strcat('BO_ScanSimulation_Results',datestr(now,'yyyymmddTHHMMSS')),...
        [xvect,Vin,Vout,ratio],...
        'delimiter','\t')
end