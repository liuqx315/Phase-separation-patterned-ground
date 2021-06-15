% clear all; 
% close all;

Newcolors=[0 0.4470 0.7410;0.8500 0.3250 0.0980;0.9290 0.6940 0.1250; ...
0.4940 0.1840 0.5560; 0.4660 0.6740 0.1880; 0.3010 0.7450 0.9330; ...
0.6350 0.0780 0.1840; 1.0000 1.0000 1.0000; 0 0 0; 0.7 0.7 0.7];
BarFontSize      = 24;
TitleFontSize    = 24;
FS=BarFontSize;

%%
win = 0.2 ;
a = 0.2 ;
Dh = 5.05 ;
v0 = 2.02 ;
beta = 0.2 ;
% C = 0.5.*(beta).^2 ; 
kappa = 0.05 ;
r=0.00; 
gamma=0.5;
MaxWavenumber=500;

X=512; Y=512;
S0_max=6.1; S0_min=0.1;

mS=logspace(log10(S0_min),log10(S0_max),X);
mLam=linspace(0.1,7.3,X);

LamS0=-ones(X,Y);
for qx=1:X
    qx
    S0=mS(qx);
    for qy=1:Y

        Lambda=mLam(qy);

        H0=win/(a*S0^2+r);
        phi1=gamma*beta^2*H0^2*(1.0-Lambda*S0)*exp(-2.0*Lambda*S0);
        phi2=gamma*beta^2*H0*S0*exp(-2*Lambda*S0);
        qq=logspace(log10(0.05),log10(50),MaxWavenumber);
       
        ReaValue=-1;
        for Qindex=1:MaxWavenumber 
            q=qq(Qindex);
            % spatial Wavenumber Marix 
            MM=[-phi1*q.^2-kappa*q.^4 -phi2*q.^2;
                -2*a*S0*H0 -a*S0^2-r-Dh*q.^2];
            eg = max(real(eig(MM)));
            if eg>ReaValue
                ReaValue=eg;
            end
        end
        LamS0(qy,qx)=ReaValue;
    end

end

save(['Lambda_S0_' num2str(S0_max) '.mat']);

%%
[mSx, mLamy]=meshgrid(mS,mLam);

figure('position',[100 100 600 500]);
% contourf(mLam,ReJacob_M,[0,0]); colorbar; shading interp
contourfnu(mSx,mLamy,LamS0,[-inf,0,inf],[],[],false);
colormap(parula(2));
hold on
plot(mS,(r-0.2*mS.^2)/(r*mS+a*mS.^3),'-o')
% StringX= roundn(Scolm(round(linspace(1,X,6))),-1); % log scale otherwise
% StringY= roundn(Lmin+linspace(0,Y,6).*(abs(Lmax-Lmin)/Y),-1);
xticks([0.1 0.2 0.5 1.2 2.7 6.1]); 
% xticks([0.1 0.2 0.5 1.2 2.7 6.1]); 
yticks([0.1 1.5 3.0 4.4 5.9 7.3]); % ytickangle(90)
xlim([0.1 S0_max]);
xtickformat('%.1f'); 
ytickformat('%.1f');
% xticklabels(string(StringX));
% yticklabels(string(StringY)); 
set(gca,'xscale','log','fontsize',BarFontSize,'linewidth',2,'TickDir', 'out',...
    'box','on','YDir','normal','TickLength',[0.02, 0.025],'XMinorTick','off');
xlabel('Initial stone concentrations, $\mathcal{S}_0$ (g/cm$^2$)','Interpreter','latex','FontSize',TitleFontSize);
ylabel('Movement speed decay rate, $\lambda$','Interpreter','latex','FontSize',TitleFontSize);
save2pdf(['Model2withequation(14)_' num2str(S0_max) '.pdf'],gcf,600) ;



