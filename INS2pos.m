% INS2pos
fins=fopen('E:\File\wechat\WeChat Files\wxid_tgvuwxev7m7v22\FileStorage\File\2023-05\cpt7后处理 4-28-1.txt');
fpos=fopen('E:\File\wechat\WeChat Files\wxid_tgvuwxev7m7v22\FileStorage\File\2023-05\cpt7后处理 4-28.pos','w');
fprintf(fpos,'%s\n','% program   : RTKPOST');
fprintf(fpos,'%s\n','% ref pos   :');
fprintf(fpos,'%s\n','% (x/y/z-ecef=WGS84,Q=1:fix,2:float,3:sbas,4:dgps,5:single,6:ppp,ns=# of satellites)');
fprintf(fpos,'%s\n','%  GPST                 lat(deg)       lon(deg)        h(m)      Q   ns    sdx(m)    sdy(m)    sdz(m)    sdxy(m)   sdyz(m)   sdzx(m)   age(s)  ratio   fixn');

for i=1:21
    tline1=fgetl(fins);
end
ii=1;
while ~feof(fins)
    % 观测时间，纬度，经度，高程
    %纬度和经度是dddmm.mmmm度分格式，输出时除以100，即转成ddd.mmmmmm格式
    tline1=fgetl(fins);
    nn=textscan(tline1,'%f %f %f %f %f %*[^\n]');
    %将时间存入结果矩阵中
    gpsweek=cell2mat(nn(1));
    gpssec=cell2mat(nn(2));
    if(gpssec~=fix(gpssec))
        continue;
    end
    %b,l(deg),h,vel_n,vel_e,vel_u
    b=cell2mat(nn(3));%lat
    l=cell2mat(nn(4));%log
    h=cell2mat(nn(5));
    ii=ii+1;
    fprintf(fpos,"%4d %f %15.10f %15.10f %10.4f %4d %4d %9.4f %9.4f %9.4f ",...
       gpsweek,gpssec,b,l,h,1,10,0,0,0);
    fprintf(fpos,"%9.4f %9.4f %9.4f %7.2f %7.1f %6d\n",...
       0,0,0,0,0,0);
end
fclose all;