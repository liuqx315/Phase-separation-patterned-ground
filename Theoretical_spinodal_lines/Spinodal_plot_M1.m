clear all; close all;

Newcolors=[0 0.4470 0.7410;0.8500 0.3250 0.0980;0.9290 0.6940 0.1250; ...
0.4940 0.1840 0.5560; 0.4660 0.6740 0.1880; 0.3010 0.7450 0.9330; ...
0.6350 0.0780 0.1840; 1.0000 1.0000 1.0000; 0 0 0; 0.7 0.7 0.7];
BarFontSize      = 24;
TitleFontSize    = 24;
FS=BarFontSize;

alpha=0.5;
v0=2.02;
beta=0.5*v0;
kappa=0.15;

X=512; Y=512;
mS=logspace(log10(0.1),log10(6.1),X);
mLam=linspace(0.3,7.3,X);
[mS, mLam]=meshgrid(mS,mLam);

Potential_F2=alpha*v0^2.*exp(-2.0.*mLam.*mS).*(mLam.*mS-1)-kappa.*0.2;

figure('position',[100 100 600 500]);
% contourf(mS,mH,Z,[0,0]); colorbar; shading interp
contourfnu(mS,mLam,Potential_F2,[-inf,0,inf],[],[],false);
colormap(parula(2));

% StringX= roundn(Scolm(round(linspace(1,X,6))),-1); % log scale otherwise
% StringY= roundn(Lmin+linspace(0,Y,6).*(abs(Lmax-Lmin)/Y),-1);
 
xticks([0.1 0.2 0.5 1.2 2.7 6.1]); 
yticks([0.3 1.7 3.1 4.5 5.9 7.3]); % ytickangle(90)
xlim([0.1 6.1]); ylim([0.3 7.3]);
xtickformat('%.1f'); ytickformat('%.1f');
% xticklabels(string(StringX));
% yticklabels(string(StringY)); 
set(gca,'xscale','log','fontsize',BarFontSize,'linewidth',2,'TickLength',[0.02, 0.025],...
    'TickDir', 'out','box','on','YDir','normal','XMinorTick','off');
xlabel('Initial stone concentrations, $\mathcal{S}_0$ [g/cm$^2$]','Interpreter','latex','FontSize',TitleFontSize);
ylabel('Movement speed decay rate, $\lambda$','Interpreter','latex','FontSize',TitleFontSize);

save2pdf('Model1_De(SH)_TH.pdf',gcf, 600);


