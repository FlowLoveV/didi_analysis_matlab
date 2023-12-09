clc;
clear;

% Vel=load('E:\Project\滴滴\二期\DATA\20210610125602\dvel_0610.txt');
% figure;
% plot(Vel(:,7:8));
ts=[0,00,00];%2021-6-10
te=[23,59,00];
% ts=[4,30,00];%2021-06-30  
% te=[6,51,00];
%resfile='..\result\2021-06-10\20210610_GPST_Loose_1s.txt';
% resfile='..\result\2021-06-30\ins_result.txt';%20210610_rtk_Loose_1s.txt';
% reffile='..\result\2021-06-30\BMHR18450607N_30-06-2021_12-20-45.ASC';%BMHR18450607N_22-03-2021_16-10-41.pos
% outfile='..\result\2021-06-30\out.pos';
%ferror=fopen('..\result\2021-06-30\out_0630_didi.csv','a');
% resfile='..\..\result\2021-06-10\didi_rtk_v3.5.pos';%ins_result.txt%20210610_rtk_Loose_1s.txt';
% reffile='..\..\result\2021-06-10\BMHR18450607N_10-06-2021_13-05-34.ASC';%BMHR18450607N_22-03-2021_16-10-41.pos
% outfile='..\..\result\2021-06-10\out.pos';
% ferror=fopen('..\result\2021-06-10\out_0610_didi.csv','a');

% resfile='..\result\2021-06-16\ins_result.txt';%20210610_rtk_Loose_1s.txt';
% reffile='..\result\2021-06-16\BMHR18450607N_16-06-2021_14-01-50.ASC';%BMHR18450607N_22-03-2021_16-10-41.pos
% outfile='..\result\2021-06-10\out.pos';
% ferror=fopen('..\result\2021-06-10\out_0610_didi.csv','a');

% resfile='..\result\2022-06-09\ins_result.txt';5
% reffile='..\result\2022-06-09\NMNE18500002S_2022-06-09_10-26-18.ASC';%BMHR18450607N_22-03-2021_16-10-41.pos
% outfile='..\result\2022-06-09\out.pos';
% ferror=fopen('..\result\2022-06-09\out_0609_didi.csv','a');

% resfile='..\..\20210610125602\ins_result_addrtk_v3.5_2-.txt';%20210610_rtk_Loose_1s.txt';
% reffile='..\..\20210610125602\BMHR18450607N_10-06-2021_13-05-34.ASC';%BMHR18450607N_22-03-2021_16-10-41.pos
% outfile='..\..\20210610125602\out.pos';

% resfile='..\..\20210624\ins_result_addrtk_v3.5_1-.txt';%20210610_rtk_Loose_1s.txt';
% reffile='..\..\20210624\BMHR18450607N_24-06-2021_16-37-23.ASC';%BMHR18450607N_22-03-2021_16-10-41.pos
% outfile='..\..\20210624\out.pos';

% resfile='..\..\20220105\rtk-nmea.pos';%20210610_rtk_Loose_1s.txt';
% resfile='..\..\20220105\ins_result_addrtk_v3.5_2-s.txt'
% resfile='..\..\20220105\didi_rtk_v3.5_2-s.pos';
% reffile='..\..\20220105\NMNE18500002S_2022-01-05_10-39-40.ASC';%BMHR18450607N_22-03-2021_16-10-41.pos
% outfile='..\..\20220105\out.pos';

% resfile='..\..\20221011\2022_10_11_rtcm_.pos';%didi_rtk_v3.5_1-test
% reffile='..\..\20221011\NMNE18500002S_2022-10-11_09-52-38.ASC';%BMHR18450607N_22-03-2021_16-10-41.pos
% outfile='..\..\20221011\out.pos';

% % resfile='..\..\20221019-1s\didi_rtk_duan_raw_blh.pos';%RTK  5 5 1
% % resfile='..\..\20221019-1s\ins_result_addrtk_v3.5_0720.txt';%松组合 2 5 1
% % resfile='..\..\20221019-1s\ins_result_addrtk_v3.5_1-6-3.txt';%紧组合 2 5 1
% resfile='..\..\20221019-1s\ins_result_addrtk_v3.6-6-2.txt';%
% reffile='..\..\20221019-1s\NMNE18500002S_2022-10-19_07-45-38.ASC';%BMHR18450607N_22-03-2021_16-10-41.pos
% outfile='..\..\20221019-1s\out.pos';

% % %379200-381567数据质量还可以
% % resfile='..\..\20221020-40\rtk-nmea.pos';%RTK  4 5 2
% resfile='..\..\20221020-40\ins_result_addrtk_v3.6-6-2.txt';%紧组合 2 5 1
% % resfile='..\..\20221020-40\ins_result_addrtk_v3.5_0720-l.txt';%松组合+零速 2 5 1
% % resfile='..\..\20221020-40\didi_rtk_duan_raw_blh_379200.pos';%RTK  5 5 1
% reffile='..\..\20221020-40\NMNE18500002S_2022-10-20_09-52-29.ASC';%BMHR18450607N_22-03-2021_16-10-41.pos
% outfile='..\..\20221020-40\out.pos';

% %数据质量不太好
% resfile='..\..\202210201626-40\rtk-nmea.pos';%RTK  4 5 2
% % resfile='..\..\202210201626-40\ins_result_addrtk_v3.5_1-7-4.txt';%紧组合 2 5 1
% % resfile='..\..\202210201626-40\ins_result_addrtk_v3.5_0720.txt';%松组合 2 5 1
% % resfile='..\..\202210201626-40\didi_rtk_duan_raw_blh_379200.pos';%RTK  5 5 1
% reffile='..\..\202210201626-40\NMNE18500002S_2022-10-20_08-07-30.ASC';%BMHR18450607N_22-03-2021_16-10-41.pos
% outfile='..\..\202210201626-40\out.pos';

% % resfile='..\..\20221020-80-V19\rtk-nmea.pos';%RTK  4 5 2
% % resfile='..\..\20221020-80-V19\ins_result_addrtk_v3.5_1-7-4.txt';%紧组合 2 5 1
% resfile='..\..\20221020-80-V19\ins_result_addrtk_v3.5_0720.txt';%松组合 2 5 1
% % resfile='..\..\20221020-80-V19\didi_rtk_duan_raw_blh_379200.pos';%RTK  5 5 1
% reffile='..\..\20221020-80-V19\NMNE18500002S_2022-10-20_08-07-30.ASC';%BMHR18450607N_22-03-2021_16-10-41.pos
% outfile='..\..\20221020-80-V19\out.pos';

% %静态路段位置误差几十米，动态可固定，精度分米
% % resfile='..\..\20221020-80-V22\rtk-nmea.pos';%RTK  4 5 2
% % resfile='..\..\20221020-80-V22\ins_result_addrtk_v3.5_1-7-4.txt';%紧组合 2 5 1
% resfile='..\..\20221020-80-V22\ins_result_addrtk_v3.5_0720.txt';%松组合 2 5 1
% % resfile='..\..\20221020-80-V22\didi_rtk_duan_raw_blh_379200.pos';%RTK  5 5 1
% reffile='..\..\20221020-80-V22\NMNE18500002S_2022-10-20_09-52-29.ASC';%BMHR18450607N_22-03-2021_16-10-41.pos
% outfile='..\..\20221020-80-V22\out.pos';

% %全场景 543240-545460 开阔，精度不错
% % resfile='..\..\20221022-40\rtk-nmea.pos';%RTK  4 5 2
% resfile='..\..\20221022-40\ins_result_addrtk_v3.6-6-2.txt';%紧组合 2 5 1；v3.5_1-7-4 
% % resfile='..\..\20221022-40\ins_result_addrtk_v3.5_0720.txt';%松组合 2 5 1
% % resfile='..\..\20221022-40\2022_10_22_rtcm_.pos';%RTD  4 5 2
% % resfile='..\..\20221022-40\didi_rtk_v3.6-3-2-hdspp.pos';%RTK  6 5 2
% reffile='..\..\20221022-40\NMNE18500002S_2022-10-22_08-04-25.ASC';%BMHR18450607N_22-03-2021_16-10-41.pos
% outfile='..\..\20221022-40\out.pos';

% %全场景 184600-186910 开阔，精度不错
% % resfile='..\..\20221025-40\rtk-nmea.pos';%RTK  4 5 2
% resfile='..\..\20221025-40\ins_result_addrtk_v3.6-6-2.txt';%紧组合 2 5 1
% % resfile='..\..\20221025-40\ins_result_addrtk_v3.5_0720.txt';%松组合 2 5 1
% % resfile='..\..\20221025-40\didi_rtk_duan_raw_blh.pos';%RTK  5 5 1
% reffile='..\..\20221025-40\NMNE18500002S_2022-10-25_04-24-26.ASC';%BMHR18450607N_22-03-2021_16-10-41.pos
% outfile='..\..\20221025-40\out.pos';

% resfile='..\..\20221024-80-1\rtk-nmea.pos';%RTK  4 5 2
% % resfile='..\..\20221024-80-1\ins_result_addrtk_v3.5_1-7-4.txt';%紧组合 2 5 1
% % resfile='..\..\20221024-80-1\ins_result_addrtk_v3.5_0720.txt';%松组合 2 5 1
% % resfile='..\..\20221024-80-1\didi_rtk_duan_raw_blh_379200.pos';%RTK  5 5 1
% reffile='..\..\20221024-80-1\NMNE18500002S_2022-10-24_09-29-12.ASC';%BMHR18450607N_22-03-2021_16-10-41.pos
% outfile='..\..\20221024-80-1\out.pos';

% %197750-199850
% % resfile='..\..\20220628\rtk-nmea.pos';%didi_rtk_v3.5_1-test
% resfile='..\..\20220628\ins_result_addrtk_v3.6-2.txt';
% % resfile='..\..\20220628\ins_result_addrtk_v3.5_0720-197750-199850.txt';%20210610_rtk_Loose_1s.txt';
% % resfile='..\..\20220628\ins_result_addrtk_v3.5_0720.txt';%20210610_rtk_Loose_1s.txt';
% reffile='..\..\20220628\NMNE18500002S_2022-06-28_08-37-45.ASC';%BMHR18450607N_22-03-2021_16-10-41.pos
% outfile='..\..\20220628\out.pos';

% resfile='..\..\20220629\ins_result_addrtk_v3.5_1-.txt';%20210610_rtk_Loose_1s.txt';
% reffile='..\..\20220629\NMNE18500002S_2022-06-29_10-16-19.ASC';%BMHR18450607N_22-03-2021_16-10-41.pos
% outfile='..\..\20220629\out.pos';

% resfile='..\..\20220630\ins_result_addrtk_v3.5_1-.txt';%20210610_rtk_Loose_1s.txt';
% reffile='..\..\20220630\NMNE18500002S_2022-06-30_04-23-07.ASC';%BMHR18450607N_22-03-2021_16-10-41.pos
% outfile='..\..\20220630\out.pos';

% resfile='..\..\20210630123039\didi_rtk_v3.5_1-test.pos';%20210610_rtk_Loose_1s.txt';
% resfile='..\..\20210630123039\ins_result_addrtk_v3.5_2-.txt';%20210610_rtk_Loose_1s.txt';
% reffile='..\..\20210630123039\BMHR18450607N_30-06-2021_12-20-45.ASC';%BMHR18450607N_22-03-2021_16-10-41.pos
% outfile='..\..\20210630123039\out.pos';


% %全场景 
% resfile='..\..\20230601101642\rtk-nmea.pos';%RTK  4 5 2
% % resfile='..\..\20230601101642\ins_result_addrtk_v3.6-7.txt';%紧组合 2 5 1
% % resfile='..\..\20230601101642\ins_result_addrtk_v3.5_0720.txt';%松组合 2 5 1
% reffile='..\..\20230601101642\NMNE18500002S_2023-06-01_04-12-15.ASC';%BMHR18450607N_22-03-2021_16-10-41.pos
% outfile='..\..\20230601101642\out.pos';

% %全场景 
% % resfile='..\..\20230601130107\rtk-nmea.pos';%RTK  4 5 2
% resfile='..\..\20230601130107\ins_result_addrtk_v3.6-6-2.txt';%紧组合 2 5 1
% % resfile='..\..\20230601130107\ins_result_addrtk_v3.5_0720.txt';%松组合 2 5 1
% reffile='..\..\20230601130107\NMNE18500002S_2023-06-01_08-38-14.ASC';%BMHR18450607N_22-03-2021_16-10-41.pos
% outfile='..\..\20230601130107\out.pos';

% % resfile='..\..\20230602101748\rtk-nmea.pos';%RTK  4 5 2
% resfile='..\..\20230602101748\ins_result_addrtk_v3.6-6-2.txt';%紧组合 2 5 1
% % resfile='..\..\20230602101748\ins_result_addrtk_v3.5_0720.txt';%松组合 2 5 1
% reffile='..\..\20230602101748\NMNE18500002S_2023-06-02_04-12-11.ASC';%BMHR18450607N_22-03-2021_16-10-41.pos
% outfile='..\..\20230602101748\out.pos';

%前2000历元还行（0.5m以内），但是后期无法固定
% resfile='..\..\20230602155520\rtk-nmea.pos';%RTK  4 5 2
% resfile='..\..\20230602155520\ins_result_addrtk_v3.6-7.txt';%紧组合 2 5 1
resfile='..\..\20230602155520\final_vdr_analysis.txt';%松组合 2 5 1
resfile1='..\..\20230602155520\rtk-nmea.pos';%松组合 2 5 1
reffile='..\..\20230602155520\NMNE18500002S_2023-06-02_09-51-27.ASC';%BMHR18450607N_22-03-2021_16-10-41.pos
outfile='..\..\20230602155520\out.pos';


% %参考结果数据不对
% % resfile='..\..\20230604142550\rtk-nmea.pos';%RTK  4 5 2
% resfile='..\..\20230604142550\ins_result_addrtk_v3.6-6-2.txt';%紧组合 2 5 1
% % resfile='..\..\20230604142550\ins_result_addrtk_v3.5_0720.txt';%松组合 2 5 1
% reffile='..\..\20230604142550\NMNE18500002S_2023-06-05_08-51-08.ASC';%BMHR18450607N_22-03-2021_16-10-41.pos
% outfile='..\..\20230604142550\out.pos';

% %
% resfile='..\..\20230606141455\rtk-nmea.pos';%RTK  4 5 2
% % resfile='..\..\20230606141455\ins_result_addrtk_v3.6-6-2.txt';%紧组合 2 5 1
% % resfile='..\..\20230606141455\ins_result_addrtk_v3.5_0720.txt';%松组合 2 5 1
% reffile='..\..\20230606141455\NMNE18500002S_2023-06-06_08-06-24.ASC';%BMHR18450607N_22-03-2021_16-10-41.pos
% outfile='..\..\20230606141455\out.pos';



% % 静态测试
% resfile='E:\Project\北斗星通\Rtk_addrtd\data\2023-04-23-1\23-1-rtd-ekf2.pos';
% Res=RtkresRead(resfile,ts,te,4);
% Ref=[-2160421.3767  ,  4383634.2022  ,  4084758.6850];%2023-04-23
% %Ref=[-2845668.7691 ,4662768.8423  ,3281767.9141];
% ENU=ResComp_static(Res(1:end,:),Ref,3);
% figure
% plot(ENU(:,1:3));title('position');legend('E','N','U');



ferror=fopen('..\..\result\out_didi_v3.5.csv','a');

%读取定位结果，GINS格式结果(1,xyz)，算法结果(2,week tow blh),嵌入式RTK结果(3,XYZ),
%NMEA转的POS结果(4,YY/MM/DD HH:MM:SS XYZ),解算的BLH结果(5,week tow BLH),解算的XYZ结果(6,week tow XYZ)
Res=RtkresRead(resfile,ts,te,7);
Res1=RtkresRead(resfile1,ts,te,4);
%读取组合导航参考结果,1:组合导航结果(blh,deg)，2：GOOGLE NMEA结果，3：pos格式结果 4.Novatel格式结果(blh)
Ref= RefresRead_new(reffile,outfile,5,ts,te);
Ref=unique(Ref,'rows');
%比较定位结果和组合导航结果, 1:blh-blh,2:xyz-blh,3:xyz-xyz
ENU=ResComp(Res(1:end,:),Ref,1);
ENU1=ResComp(Res1(1:end,:),Ref,2);
ENU=ENU(ENU(:,1)~=0,:);
ENU1=ENU1(ENU1(:,1)~=0,:);
%统计相对位置误差
% vel=load('E:\Project\滴滴\二期\GNSS-INS-Didi V3.5 框架重构完成_qc_0720\GNSS-INS-Didi V3.5_1-增加IMU辅助周跳探测\GNSS-INS\imuvel_220628.txt');
% [c, ia, ib] = intersect (Ref(:,1),vel(:,1),'rows');
% t=Ref(ia,1);
% V_ref=Ref(ia,8:10);
% V_imu=vel(ib,2:4);
% V_hd=vel(ib,5:7);
% V_tdcp=vel(ib,8:10);
% 
% V_ref_3d=sqrt(sum(V_ref.^2,2));
% V_imu_3d=sqrt(sum(V_imu.^2,2));
% V_hd_3d=sqrt(sum(V_hd.^2,2));
% V_tdcp_3d=sqrt(sum(V_tdcp.^2,2));
% 
% figure
% plot(V_ref_3d-V_imu_3d,'.');
% hold on
% plot(V_ref_3d-V_hd_3d,'.');
% hold on
% plot(V_ref_3d-V_tdcp_3d,'.');
% legend('imu','HDvel','TDCP');
% title('2022-06-28');
%plot cdf and enu


figure
plot(ENU(:,1:3));title('position');legend('E','N','U');
ENU(all(ENU==0,2),:)=[];
[x_50,x_68,x_95,x_99]=CdfPlot(ENU(:,:));
hold on
[x_50_1,x_68_1,x_95_1,x_99_1]=CdfPlot(ENU1(:,:));
hold off
if (x_50~=0)&&(x_99~=0)
    fprintf(ferror,'%.3f,%.3f,%.3f,%.3f\n',x_50,x_68,x_95,x_99);
end
if size(ENU,2)>3
    for i=1:size(ENU,1)
        if ENU(i,6)>180
            ENU(i,6)=ENU(i,6)-360;
        elseif ENU(i,6)<-180
            ENU(i,6)=ENU(i,6)+360;
        end
    end
    figure
    plot(ENU(:,4:6));title('attitude');legend('roll','pitch','heading');
    figure
    plot(ENU(:,7:9));title('velocity');legend('E','N','U');
end
if 0 && size(ENU,2)>3
    matt=mean(ENU(1000:end,4:6));
    roll=ENU(1000:end,4)'-repelem(matt(1),878);
    pitch=ENU(1000:end,5)'-repelem(matt(2),878);
    heading=ENU(1000:end,6)'-repelem(matt(3),878);
    
    y1=cdfplot(roll);tt_95=find(y1.YData<=0.95);  r_95=y1.XData(tt_95(end));
    y1=cdfplot(pitch);tt_95=find(y1.YData<=0.95);  p_95=y1.XData(tt_95(end));
    y1=cdfplot(heading);tt_95=find(y1.YData<=0.95);  h_95=y1.XData(tt_95(end));

%     matt=mean(ENU(1000:end,4:6));
%     roll=ENU(1000:end,4)'-repelem(matt(1),1001);
%     pitch=ENU(1000:end,5)'-repelem(matt(2),1001);
%     heading=ENU(1000:end,6)'-repelem(matt(3),1001);
%     
%     y1=cdfplot(roll);tt_95=find(y1.YData<=0.95);  r_95=y1.XData(tt_95(end));
%     y1=cdfplot(pitch);tt_95=find(y1.YData<=0.95);  p_95=y1.XData(tt_95(end));
%     y1=cdfplot(heading);tt_95=find(y1.YData<=0.95);  h_95=y1.XData(tt_95(end));
end
% [x_50(1),x_68(1),x_95(1),x_99(1)]=CdfPlot(abs(ENU(:,1)));
% [x_50(2),x_68(2),x_95(2),x_99(2)]=CdfPlot(abs(ENU(:,2)));
% [x_50(3),x_68(3),x_95(3),x_99(3)]=CdfPlot(abs(ENU(:,3)));
% max_ENU(1)= max(abs(ENU(:,1)));
% max_ENU(2)= max(abs(ENU(:,2)));
% max_ENU(3)= max(abs(ENU(:,3)));

fclose all;
