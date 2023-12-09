function [x_50,x_68,x_95,x_99,m_error,r_error]=CdfPlot(ENU)
%  input  -- ENU:平面误差序列,sqrt(N^2+E^2)
%  output -- x:CDF68%对应的平面误差,error:平面误差均值
    %% plot CDF,calculate mean errors
    figure
%     subplot(1,2,1)
    en=sqrt(ENU(:,1).^2+ENU(:,2).^2);
%     en=ENU;
    m_error=mean(en);
    r_error=rms(en);
    max_error=max(en);
    y1=cdfplot(en);%abs(ENU(:,1)) 
    tt_50=find(y1.YData<=0.5);
    tt_68=find(y1.YData<=0.68);
    tt_95=find(y1.YData<=0.95); 
    tt_99=find(y1.YData<=0.99);
    x_50=y1.XData(tt_50(end));  
    x_68=y1.XData(tt_68(end));
    x_95=y1.XData(tt_95(end));
    x_99=y1.XData(tt_99(end));
%     ax=xlim;ay=ylim;
%     hold on
%     plot([ax(1),x_68],[0.68,0.68],'LineStyle','--','Color','red');
%     hold on
%     plot([x_68,x_68],[ay(1),0.68],'LineStyle','--','Color','red');
%     text(x_68,0.04,['\downarrow ',num2str(x_68)],'FontSize',9);
%     text(x_68,0.12,['  ',num2str(max_error)],'FontSize',9);
%     set(gca,'YTick',0:0.2:1);
%     annotation('textbox',...
%         [0.070 0.658 0.0728 0.064],...
%         'Color',[1 0 0],...
%         'String',{'0.68'},...
%         'LineStyle','none','FontSize',9);
%     set(gcf,'position',[600,300,270,220])
    %% plot errors of E、N
%     figure
%     subplot(1,2,2)
%     plot(ENU(:,1));
%     hold on;
%     plot(ENU(:,2));
%     xlabel('t/s');
%     ylabel('errors/m');
%     legend({'E','N'});
%     set(gcf,'position',[600,300,270,220])
%     set(gcf,'position',[600,300,600,220])
end