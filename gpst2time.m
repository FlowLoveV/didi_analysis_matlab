function t=gpst2time(gpst)
% gpst to utc time
    utc=gpst-18;
    day=floor(utc/86400);
    sec=utc-day*86400;
    hh=floor(sec/3600);
    mm=floor((sec-hh*3600)/60);
    ss=sec-hh*3600-mm*60;
    t(1)=hh;t(2)=mm;t(3)=ss;
end