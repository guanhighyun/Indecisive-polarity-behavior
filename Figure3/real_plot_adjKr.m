function [Z,adjKr] = real_plot_adjKr(filename,nframes,L)
[t,pos]=read_molPos3(filename,nframes);
finalidx=find(~isnan(t),1,'last');
r_vec = 0.5:0.1:L/2;

for t = 2:finalidx
[active_xyz] = get_active_Cdc42_distr(pos,nframes);
[H]=compute_Kr(active_xyz{t}(:,1),active_xyz{t}(:,2),r_vec,L);
[maxH,idx] = max(H);
if ~isnan(idx)
    r(t) = r_vec(idx);
end
adjKr(t) = maxH;
end
Z = sum(adjKr>=1.5);

x=(0:10:(finalidx-1)*10)/60;
maxmaxH = max(adjKr);
plot(x,adjKr,'linewidth',3)
xlabel('Time (min)','Fontsize',14)
ylabel('K','Fontsize',14)
ylim([0,4])
xlim([10/60,66])
set(gca,'fontsize',20)
%savefig([sprintf('%s',filename),'.fig']);
%print(gcf,'-dtiff',[sprintf('%s',filename),'.tif'],'-r300');


