function dms=dm2dms(dm)
    %度分(ddmm.mmmm)转度分秒(dd mm ss.ssss)
    %目前只考虑经纬度均大于0的情况
    dd=floor(dm/100);
    mm=floor(dm-dd*100);
    ss=(dm-dd*100-mm)*60;
    dms(1)=dd;
    dms(2)=mm;
    dms(3)=ss;
end