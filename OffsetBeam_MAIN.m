%These first 10 lines of code are not important
keepdir=0;
if keepdir==1
    save('bla.mat','filename','pathname','keepdir')
else
    save('bla.mat','keepdir')
end
clear all
pause(0.1)
load('bla.mat','filename','pathname','keepdir');
tic %Start the timer

%Anticipated system properties (initial guess for fitting, if you do fitting/errorbar estimation)
lambda=[1 230 0.2 1.14]; %W/m-K
C=[1.6 3.44 0.1 1.62]*1e6; %J/m^3-K
t=[2 100 1 1e9]*1e-9; %m ("Al" thickness estimated at 84nm=81nm Al+3nm oxide, from picosecond acoustic)
%lambda(1)=10*lambda(2); %top 1nm 10X the rest of layer (simulates absorbtion)
%C(1)=10*C(2); %top 1nm 10X rest of layer
eta=ones(1,numel(lambda)); %isotropic layers, eta=kx/ky;

td = 100e-12;
r      = 2.7e-6; 
f      = 1.608e6;

xvect = linspace(0,6.1e-6,20)';
xoffset_min = -6e-6;
xoffset_max = 6e-6;


importdata=1;
Xguess = [lambda(2)];  %Don't forget to update file:  OFFSET_FIT.m

%[Sig_Rat,Sig_Amp]=Offset_Beam_EvalScan(xvect,lambda,C,t,eta,r,f,td)

%--------------Import Data---------------------------
if importdata==1
    if keepdir==1
        filename=input('enter file name string:\n')
    else
        [filename,pathname]=uigetfile('*.*','Choose data file');
    end
    DATAMATRIX=dlmread(strcat(pathname,filename),'\t');
    xoffset_raw=DATAMATRIX(:,1)*1e-6; %imported in microns, change to meters
    Vin_raw=DATAMATRIX(:,2); %Units -> (uV)
    Vout_raw=DATAMATRIX(:,3);
    ratio_raw=DATAMATRIX(:,4);
    [xoffset_data,Vin_data] = extract_interior(xoffset_raw,Vin_raw,xoffset_min,xoffset_max);
    [xoffset_data,Vout_data] = extract_interior(xoffset_raw,Vout_raw,xoffset_min,xoffset_max);
    [xoffset_data,ratio_data] = extract_interior(xoffset_raw,ratio_raw,xoffset_min,xoffset_max);
end

fminsearch(@(X) OFFSET_FIT(X,xoffset_data,ratio_data,lambda,C,t,eta,r,f,td),Xguess);