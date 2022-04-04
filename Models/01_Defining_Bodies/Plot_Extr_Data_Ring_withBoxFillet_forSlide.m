% Copyright 2012-2022 The MathWorks, Inc.
L=75;W=15;rad=5;nH=3;
xy_data = Extr_Data_Ring_withBoxFillet(0.05,0.025,0.08,0.002);

figure
patch(xy_data(:,1),xy_data(:,2),[1 1 1]*0.95,'EdgeColor','none');
hold on
plot(xy_data(:,1),xy_data(:,2),'k-.','LineWidth',1)
hold off
box on
set(gcf,'Position',[578.6000  119.4000  320.0000  303.2000]);
set(gca,'XLim',[-1 1]*0.05*1.05,'YLim',[-1 1]*0.05*1.05);
grid on
%axis equal

