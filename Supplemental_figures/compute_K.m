function [finalH,meanH,adjKr] = compute_K(filename,nframes,R)
[t,pos]=read_molPos3(filename,nframes);
finalidx=find(~isnan(t),1,'last');
r_vec = 0:0.1:8.8623/2;
adjKr = nan(1,nframes);

for i = 2:nframes
active_xyz = get_active_Cdc42_distr(pos,nframes);
[az,el,~] = cart2sph(active_xyz{i}(:,1),active_xyz{i}(:,2),active_xyz{i}(:,3));
[H]=compute_Kr(az,el,r_vec,R);
[maxH,idx] = max(H);
if ~isnan(idx)
    r(i) = r_vec(idx);
end
adjKr(i) = maxH;
end
x=0:10:(finalidx-1)*10;
meanH = nanmean(adjKr(201:end));
finalH = adjKr(end);
end