function set_colorbar
caxis([0,6]), set(gca,'fontsize',20); 
h = colorbar(gca,'Position',[0.93 0.13 0.01 0.2],'Ticks',[0 6],'Ticklabels',[0,6]);
h.Label.String = 'Concentration (nM)';
set(get(h,'label'),'fontsize',20);
h.Label.Rotation = -90;
h.Label.Position = [5,3,0];
end