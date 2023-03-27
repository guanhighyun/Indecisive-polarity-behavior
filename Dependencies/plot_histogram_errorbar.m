function plot_histogram_errorbar(h,ydata,ydata_error)
[ngroup,nbar] = size(ydata);
histx = nan(nbar, ngroup);
for i = 1:nbar
    histx(i,:) = h(i).XEndPoints;
end
errorbar(histx',ydata,ydata_error,'k.','linewidth',4);
hold off
end