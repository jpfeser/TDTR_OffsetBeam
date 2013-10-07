%This line should be run before entering this script
%[ratio_data,dR_data] = TDTR_Ani3D_EvalSweep(tdelay,lambda_tensor,C,h,f,tau_rep,wp,Qp,ws,TCR,Offset_vect)


[ratio_model,ratio_ampl]=Offset_Beam_EvalScan(xoffset_sens,lambda,C,t,eta,r,f,td);
%initialize some stuff
N_Offset_vect = numel(Offset_vect)/2;
M_tdelay = length(tdelay);
L_C = length(C);

dR_temp = zeros(N_Offset_vect);
ratio_temp = zeros(N_Offset_vect);
S_C = zeros(N_Offset_vect,L_C);
S_L = zeros(N_Offset_vect,L_C);
S_h  = zeros(N_Offset_vect,L_C);
S_r = zeros(N_Offset_vect);

for ii=1:length(C)
    %-------------Specific heat-----------------
    Ctemp=C;
    Ctemp(ii) = C(ii)*1.01;
    %[ratio_temp,dR_temp] = TDTR_Ani3D_EvalSweep(tdelay,lambda_tensor,C,h,f,tau_rep,wp,Qp,ws,TCR,Offset_vect);
    [ratio_temp,dR_temp] = TDTR_Ani3D_EvalSweep(tdelay,lambda_tensor,Ctemp,h,f,tau_rep,wp,Qp,ws,TCR,Offset_vect);
    delta = ratio_temp-ratio_data;
    Num = delta*C(ii);
    Denom = Ctemp(ii) - C(ii);
    S_C(:,:,ii) = Num/Denom;
    %-------------Thermal Conductivity Tensor ---------
    %-----------(kx)----------
    lambdatemp=lambda_tensor;
    lambdatemp(ii,1)=lambda_tensor(ii,1)*1.01;
    [ratio_temp,dR_temp] = TDTR_Ani3D_EvalSweep(tdelay,lambdatemp,C,h,f,tau_rep,wp,Qp,ws,TCR,Offset_vect);
    delta = ratio_temp-ratio_data;
    Num = delta*lambdatemp(ii,1);
    Denom = lambdatemp(ii,1) - lambda_tensor(ii,1);
    S_L1(:,:,ii) = Num/Denom;
        %-----------(ky)----------
    lambdatemp=lambda_tensor;
    lambdatemp(ii,2)=lambda_tensor(ii,2)*1.01;
    [ratio_temp,dR_temp] = TDTR_Ani3D_EvalSweep(tdelay,lambdatemp,C,h,f,tau_rep,wp,Qp,ws,TCR,Offset_vect);
    delta = ratio_temp-ratio_data;
    Num = delta*lambdatemp(ii,2);
    Denom = lambdatemp(ii,2) - lambda_tensor(ii,2);
    S_L2(:,:,ii) = Num/Denom;
    %-----------(kz)----------
    lambdatemp=lambda_tensor;
    lambdatemp(ii,3)=lambda_tensor(ii,3)*1.01;
    [ratio_temp,dR_temp] = TDTR_Ani3D_EvalSweep(tdelay,lambdatemp,C,h,f,tau_rep,wp,Qp,ws,TCR,Offset_vect);
    delta = ratio_temp-ratio_data;
    Num = delta*lambdatemp(ii,3);
    Denom = lambdatemp(ii,3) - lambda_tensor(ii,3);
    S_L3(:,:,ii) = Num/Denom;
    %-------------Layer Thickess---------------
    %-------------Layer Thickess---------------
    htemp=h;
    htemp(ii) = h(ii)*1.01;
    %[ratio_temp,dR_temp] = TDTR_Ani3D_EvalSweep(tdelay,lambda_tensor,C,h,f,tau_rep,wp,Qp,ws,TCR,Offset_vect);
    [ratio_temp,dR_temp] = TDTR_Ani3D_EvalSweep(tdelay,lambda_tensor,C,htemp,f,tau_rep,wp,Qp,ws,TCR,Offset_vect);
    delta = ratio_temp-ratio_data;
    Num = delta*h(ii);
    Denom = htemp(ii) - h(ii);
    S_h(:,:,ii) = Num/Denom;
    %--------------------------------------------
end

%assumes same size pump/probe to save time
    wtemp=wp;
    wtemp = wp*1.01;
    %[ratio_temp,dR_temp] = TDTR_Ani3D_EvalSweep(tdelay,lambda_tensor,C,h,f,tau_rep,wp,Qp,ws,TCR,Offset_vect);
    [ratio_temp,dR_temp] = TDTR_Ani3D_EvalSweep(tdelay,lambda_tensor,C,h,f,tau_rep,wtemp,Qp,wtemp,TCR,Offset_vect);
    delta = ratio_temp-ratio_data;
    Num = delta*wp;
    Denom = wtemp - wp;
    S_r = Num/Denom;
    
    %% Make plots
        r_offset = xoffset;
    for i = 1:M_tdelay
        figure
        S_C=shiftdim(S_C,2);
        S_L1=shiftdim(S_L1,2);
        S_L2=shiftdim(S_L2,2);
        S_L3=shiftdim(S_L3,2);
        S_h=shiftdim(S_h,2);
        S_r=shiftdim(S_r,2);
        
        plot(r_offset,[S_C(:,:,i)'],'*')
        hold on
        plot(r_offset,[S_L1(:,:,i)'],'s')
        plot(r_offset,[S_L2(:,:,i)'],'d')
        plot(r_offset,[S_L3(:,:,i)'],'o')
        plot(r_offset,[S_h(:,:,i)'],'x')
        plot(r_offset,S_r(:,:)','-')
        Cplotlab=strcat(' C ',int2str((1:length(C))'));
        L1plotlab=strcat('L1 ',int2str((1:length(C))'));
        L2plotlab=strcat('L2 ',int2str((1:length(C))'));
        L3plotlab=strcat('L3 ',int2str((1:length(C))'));
        hplotlab=strcat(' h ',int2str((1:length(C))'));
        legend([Cplotlab;L1plotlab;L2plotlab;L3plotlab;hplotlab;' R '])
    end
        