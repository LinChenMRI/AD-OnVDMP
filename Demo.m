clear all; close all; clc;
addpath('toolbox')

load Tau.mat

%% plot dynamic curve
Time = linspace(0,15*size(CSFImage,3),size(CSFImage,3))/60;
figure;
plot(Time,Image2Signal(TissueImage,Mask_Cortex),'*','MarkerSize',9); 
xlabel('Time (min)','FontName','Arial','FontSize',18,'fontweight','b');
set (gcf,'Position',[100,100,700*1.3,400*1.3], 'color','w');
set(gca,'FontName','Arial','FontSize',18,'fontweight','b','LineWidth',3,'GridLineStyle','--','TickDir','in');
title('Cortex signal');
xlim([0,max(Time)]);

figure;
plot(Time,Image2Signal(CSFImage, Mask_CSF_part),'*','MarkerSize',9);
xlabel('Time (min)','FontName','Arial','FontSize',18,'fontweight','b');
set (gcf,'Position',[100,100,700*1.3,400*1.3], 'color','w');
set(gca,'FontName','Arial','FontSize',18,'fontweight','b','LineWidth',3,'GridLineStyle','--','TickDir','in');
title('CSF signal');
xlim([0,max(Time)]);

%% calculate AUC map
[AUCMap_CSF,AUCMap_CSF_dyn] = calculateCovAUCMap(CSFImage,Mask_CSF);
imshow3dimage(AUCMap_CSF_dyn,6);mycolormap,mycolorbar;caxis([-10,10]);
set (gcf,'Position',[550 315 1174 592], 'color','w'); title('CSF AUC Map dyn');
figure; imshow(AUCMap_CSF,[], 'InitialMagnification','fit'); mycolormap(1);mycolorbar;caxis([-10,10]);
set (gcf,'Position',[550 315 486 586], 'color','w'); title('CSF AUC Map');

[AUCMap_Tissue,AUCMap_Tissue_dyn] = calculateCovAUCMap(TissueImage,Mask);
figure; imshow(AUCMap_Tissue,[], 'InitialMagnification','fit'); mycolormap(1);caxis([-10,10]);
set (gcf,'Position',[550 315 486 586], 'color','w');  title('Tissue AUC Map');
imshow3dimage(AUCMap_Tissue_dyn,6);mycolormap,mycolorbar;caxis([-10,10]);
set (gcf,'Position',[550 315 1174 592], 'color','w');title('Tissue AUC Map dyn');

% save('Tau_AUCMap.mat','AUCMap_Tissue','AUCMap_Tissue_dyn','AUCMap_CSF','AUCMap_CSF_dyn');
% save('WT_AUCMap.mat','AUCMap_Tissue','AUCMap_Tissue_dyn','AUCMap_CSF','AUCMap_CSF_dyn');