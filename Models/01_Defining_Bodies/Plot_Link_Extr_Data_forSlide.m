% Copyright 2012-2025 The MathWorks, Inc.

L=75;W=15;rad=5;nH=3;
xy_data = Extr_Data_LinkHoles(L,W,rad,nH);

figure
patch(xy_data(:,1),xy_data(:,2),[1 1 1]*0.95,'EdgeColor','none');
hold on
plot(xy_data(:,1),xy_data(:,2),'k-.','LineWidth',1)
hold off
box on
set(gcf,'Position',[116.2000  593.0000  361.6000   77.6000]);
set(gca,'XLim',[-1 1]*50+0*(L+W)/2*1.05 );
grid on

