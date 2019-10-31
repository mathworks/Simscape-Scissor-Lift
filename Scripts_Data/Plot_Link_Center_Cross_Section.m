% Copyright 2012-2017 The MathWorks, Inc.

[link_xc_data] = Extr_Data_Link2Hole(40,15,5);
plot(link_xc_data(:,1),link_xc_data(:,2),'b-.','LineWidth',3)
axis([-25 25 -10 10]);
set(gcf,'Position',[470   475   524   204]);
%axis square