function dms=dm2dms(dm)
    %�ȷ�(ddmm.mmmm)ת�ȷ���(dd mm ss.ssss)
    %Ŀǰֻ���Ǿ�γ�Ⱦ�����0�����
    dd=floor(dm/100);
    mm=floor(dm-dd*100);
    ss=(dm-dd*100-mm)*60;
    dms(1)=dd;
    dms(2)=mm;
    dms(3)=ss;
end