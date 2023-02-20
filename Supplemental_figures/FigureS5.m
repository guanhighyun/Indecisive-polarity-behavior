% Plot time evolution of molecule number and compare them between 2D and 3D
% simulations of the combined polarity circuit. Simulations were performed
% with 3000 Cdc42, 170 Bem1-GEF, 30 Far1-GEF, and 2500 receptors. All
% molecules were distributed uniformly at the first time point.

load('FigureData/FigureS5.mat')
figure('position',[300,300,1500,500])
subplot(2,5,1)
compare_number(nframes_3D,nframes_2D,nCdc42T_3D,nCdc42T_2D,'Cdc42T','b','r')
ylabel('Molecule number');
ylim([0,1500])
subplot(2,5,2)
compare_number(nframes_3D,nframes_2D,nBemGEF42_3D,nBemGEF42_2D,'Cdc42T-Bem1-GEF','b','r')
ylim([0,140])
subplot(2,5,3)
compare_number(nframes_3D,nframes_2D,nBemGEFm_3D,nBemGEFm_2D,'Bem1-GEF_m','b','r')
ylim([0,110])
subplot(2,5,4)
compare_number(nframes_3D,nframes_2D,nBemGEFc_3D,nBemGEFc_2D,'Bem1-GEF_c','b','r')
ylim([0,180])
subplot(2,5,5)
compare_number(nframes_3D,nframes_2D,nCdc42Dm_3D,nCdc42Dm_2D,'Cdc42D_m','b','r')
ylim([0,1500])
subplot(2,5,6)
compare_number(nframes_3D,nframes_2D,nCdc42Dc_3D,nCdc42Dc_2D,'Cdc42D_c','b','r')
ylim([0,3000])
subplot(2,5,7)
compare_number(nframes_3D,nframes_2D,nRam_3D,nRam_2D,'Ra_m','b','r')
ylim([1000,2000])
subplot(2,5,8)
compare_number(nframes_3D,nframes_2D,nRac_3D,nRac_2D,'Ri_c','b','r')
ylim([500,1200])
xlabel('Time (min)');
set(gca,'xtick',[0,66])
subplot(2,5,9)
compare_number(nframes_3D,nframes_2D,nRaGEF_3D,nRaGEF_2D,'RaGEF','b','r')
ylim([20,40])
subplot(2,5,10)
compare_number(nframes_3D,nframes_2D,nFarGEF_3D,nFarGEF_2D,'Far1-GEF','b','r')
ylim([0,30])
set(findall(gcf,'-property','FontSize'),'FontSize',20)

function compare_number(nframes_3D,nframes_2D,molecule_number_3D,molecule_number_2D,figtitle,color1,color2)
% Convert the unit of the time from seconds to minutes
%nframes_3D: Time points in 3D simulations
%nframes_2D: Time points in 2D simulations
shadedErrorBar((0:10:(nframes_3D-1)*10)/60,nanmean(molecule_number_3D,1),nanstd(molecule_number_3D),...
    'lineprops',{'linewidth',1,'color',color1,'MarkerFaceColor',color1},'transparent',true,'patchSaturation',0.1)
hold on
shadedErrorBar((0:10:(nframes_2D-1)*10)/60,nanmean(molecule_number_2D,1),nanstd(molecule_number_2D),...
    'lineprops',{'linewidth',1,'color',color2,'MarkerFaceColor',color2},'transparent',true,'patchSaturation',0.1)
set(gca,'xtick',[])
title(figtitle)
end







