clear all; clc;
on=1; off=0;
close();
Movie = on;
PlotAll=off;

BarFontSize      = 24;
TitleFontSize    = 24;
FS=BarFontSize;

FID=fopen('clSortedStones.dat', 'r');
A=fread(FID, 3, 'int32');

X=A(1);
Y=A(2);
Z=A(3);
EndTime=A(3);
lengthX=X;
lengthY=Y;
RecordTimes=fread(FID,EndTime+1,'double');
xWorldLimits=linspace(0,lengthX,X);
yWorldLimits=linspace(0,lengthY,Y);
popP=zeros(X,Y,'double');
% popO=zeros(X,Y,'double');
% popW=zeros(X,Y,'double');

% Get Screen dimensions and set Main Window Dimensions
x = get(0,'ScreenSize'); ScreenDim=x(3:4);
MainWindowDim=floor(ScreenDim.*[0.9 0.8]);

if Movie==on,
    writerObj = VideoWriter('Sorted patterns.mp4', 'MPEG-4');
    open(writerObj);
end;

if PlotAll==on,
    MainWindowDim=[1920 818];
else
    MainWindowDim=[720*2 720];
end;

% The graph window is initiated, with specified dimensions.
Figure1=figure('Position',[(ScreenDim-MainWindowDim)/2 MainWindowDim],...
               'Color', 'white');
set(gca,'position',[0.01 0.05 .98 .9 ],'fontsize',BarFontSize);

if PlotAll==on, 
    subplot('position',[0.02 0 0.30 0.95]);
end;
% [XX,YY]=meshgrid(linspace(0.1,2.5,X),linspace(0.3,2.5,Y));
dx=linspace(log(0.5),log(5.5),1024);
xLab=exp(dx);

F1=imagesc(xWorldLimits,yWorldLimits,popP',[0 4]);
% title('stones density (g/cm^2)','FontSize',TitleFontSize);  
cbh=colorbar('SouthOutside','FontSize',BarFontSize); 
colormap('summer'); axis image; axis on;
cbh.Ticks = linspace(0, 4, 5) ; %cbh.TickLabels = num2cell(0:4) ;
% set(get(cbh,'Label'),'string','Phase separation model','Rotation',0.0);
set(gca,'fontsize',BarFontSize,'linewidth',3,'TickDir', 'in','box','off','YDir','normal');
xlabel('Stone concentrations, [g/cm$^2$]','Interpreter','latex','FontSize',TitleFontSize);
ylabel('Movement speed decay rate, $\lambda$','Interpreter','latex','FontSize',TitleFontSize);

xticks(linspace(0,X,6)); yticks(linspace(0,Y,6)); %ytickangle(90)
xticklabels(num2cell(0.1+linspace(0,X,6).*(6.0/X)));
yticklabels(num2cell(0.3+linspace(0,Y,6).*(5.0/Y)));
% ytickformat('%1.2f'); 
% xtickformat('%1.1f'); %ytickformat('%0.1f'); 
% 1.0+linspace(0,512,5).*(1.5/512) for S0 lable
box on;
if PlotAll==on,
    subplot('position',[0.35 0 0.30 0.95]);
    F2=imagesc(xWorldLimits,yWorldLimits,popO',[0 20]);
    title('y (mm)','FontSize',TitleFontSize);  
    colorbar('SouthOutside','FontSize',BarFontSize);
    axis image; axis off;

    subplot('position',[0.68 0 0.30 0.95]);
    F3=imagesc(popW',[0 10]);
    title(' z (mm)','FontSize',TitleFontSize);    
    colorbar('SouthOutside','FontSize',BarFontSize);
    axis image; axis off;  
end
TotalS=zeros(EndTime,2);
AllP=zeros(X,Y,Z);
for x=1:Z,
    AllP(:,:,x)=popP;
    popP=reshape(fread(FID,X*Y,'float32'),X,Y);
%     popO=reshape(fread(FID,X*Y,'float32'),X,Y);
%     popW=reshape(fread(FID,X*Y,'float32'),X,Y);
%     TotalS(x,:)=[x sum(popP(:))];
    set(F1,'CData',popP');
    if PlotAll==on,
        set(F2,'CData',popO');
        set(F3,'CData',popW');  
    end;
    set(Figure1,'Name',['Timestep ' num2str(x/Z*EndTime) ' of ' num2str(EndTime)]); 
    
%     if ~exist('Images')
%         mkdir('Images');
%     end
%     if mod(x,10)==0
%         save2pdf(sprintf('Images/Patterns_%04.0f',x),gcf,600);
%     end
    
    drawnow; 
    
    if Movie==on,
         frame = getframe(Figure1);
         writeVideo(writerObj,frame);
    end

end;

fclose(FID);

if Movie==on,
    close(writerObj);
end;

disp('Done');beep;
