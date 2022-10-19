clear all
close all
clc


main_folder= cd;
Example_folder = [main_folder '\Collemaggio_church'];

cd(Example_folder)
%%

% % ORIGINAL ROI

coordinatesROI=[1,54,1,319];

%coordinatesROI=[1,240,1,320];
labelsROI=['First_Row','Last_Row','First_Column','Last_Column'];

opts=Settings_FIF2_v2('verbose',1,'plots',0,'delta',0.001,'NIMFs',9,'saveIntermediate',0,'extensionType','asymw','alpha','Almost_min','Xi',1.6,'MonotoneMaskLength',true,'verbose',0);

%%
IMF_r=cell(1,500);

i=410;
    %clearvars -except i IMF_r logM_66 coordinatesROI labelsROI opts coordROI_GT
    load(['Lateral_' num2str(i)])
    V=eval(['Lateral_' num2str(i)]);
    [IMF_r{i},logM_66] = FIF2_v3(V(coordinatesROI(1):coordinatesROI(2),coordinatesROI(3):coordinatesROI(4)),opts);
%%
cd ..


x=coordinatesROI(1):coordinatesROI(2);
y=coordinatesROI(3):coordinatesROI(4);
[X,Y]=meshgrid(y,x);
%%
%figure 1
figure
surf(X,Y,V(coordinatesROI(1):coordinatesROI(2),coordinatesROI(3):coordinatesROI(4)),'edgecolor','none')
view(70,120)
%view(2)
set(gca,'fontsize', 48);
set(gcf,'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
%saveas(gcf,'Gray_section_raw', 'fig')
%saveas(gcf,'Gray_section_raw_collemaggio', 'png')
%% IMFs for loop
for d = 1:10
%figure 2
figure(1)
surf(X,Y,sum(IMF_r{i}(:,:,[d]),3),'edgecolor','none')
title(['IMF ',num2str(d)])
view(70,120)
%view(2)
set(gca,'fontsize', 30);
set(gcf,'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
%saveas(gcf,'Gray_section_FIF_PP', 'fig')
%saveas(gcf,'Gray_section_FIF_PP', 'png')
pause
end
%%
figure
surf(X,Y,sum(IMF_r{i}(:,:,[10]),3),'edgecolor','none')
%view(70,120)
view(2)
set(gca,'fontsize', 48);
set(gcf,'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
%saveas(gcf,'Gray_section_FIF_PP', 'fig')
%saveas(gcf,'./Gray_section_FIF_collemaggio_400', 'png')
%%
%% original
%figure 1
figure
surf(X,Y,V(coordinatesROI(1):coordinatesROI(2),coordinatesROI(3):coordinatesROI(4)),'edgecolor','none')
%view(70,120)
view(2)
set(gca,'fontsize', 48);
set(gcf,'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

%% test for 100,200,400
cd 'E:\Thesis\Codes and Data\FIF2-main\Collemaggio_Lateral_Side_Solar_Loading'
%%
for i = 1:500
load(['Lateral_' num2str(i)])
V=eval(['Lateral_' num2str(i)]);
% IMFs antireflective
[IMF_r{i},logM] = FIF2_v3(V(coordinatesROI(1):coordinatesROI(2),coordinatesROI(3):coordinatesROI(4)),opts,logM_66);

%trend
figure
surf(X,Y,sum(IMF_r{i}(:,:,[10]),3),'edgecolor','none')
%view(70,120)
view(2)
set(gca,'fontsize', 48);
set(gcf,'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
end

