function res=ExtractNovatelASC(infile,outfile,type)
% type = 1 -- $GPGGA
% type = 2 -- %INSPVASA 位置blh，速度enu，姿态
if type==1
    frtk=fopen(infile);
    fout=fopen(outfile,'w');
    fprintf(fout,'%s\n','% (x/y/z-ecef=WGS84,Q=1:fix,2:float,3:sbas,4:dgps,5:single,6:ppp,ns=# of satellites)');
    fprintf(fout,'%s\n','%  GPST                      x-ecef(m)       y-ecef(m)       z-ecef(m)    Q    ns   sdx(m)    sdy(m)    sdz(m)    sdxy(m)   sdyz(m)   sdzx(m)  age(s)   ratio  fixn');

    ii=1;
    while ~feof(frtk)        
        % 观测时间，纬度，经度，高程
        %纬度和经度是dddmm.mmmm度分格式，输出时除以100，即转成ddd.mmmmmm格式
        tline1=fgetl(frtk);   
        len=length(tline1);
        if len > 80 && tline1(1)=='$'
            nn=textscan(tline1,'$GPGGA,%2c%2c%5c,%f,N,%f,E,%d,%d,%*f,%f,M,%f,%*s');      
        else
           continue
        end
        %将时间存入结果矩阵中
        %将时间和BLH存入结果矩阵中       
        tt=cell2mat(nn(1));HH=str2double(tt);%hh
        tt=cell2mat(nn(2));MM=str2double(tt);%mm
        tt=cell2mat(nn(3));SS=str2double(tt);%ss.ssss utc      
        res(ii,1:3)=[HH,MM,SS];
        sec=HH*3600+MM*60+SS;      
        %ddmm.mmmm转dms
        b_dms=dm2dms(cell2mat(nn(4)));
        b=b_dms(1)+b_dms(2)/60+b_dms(3)/3600;%deg
        l_dms=dm2dms(cell2mat(nn(5)));
        l=l_dms(1)+l_dms(2)/60+l_dms(3)/3600;%deg
        h=cell2mat(nn(8))+cell2mat(nn(9));
        sol=cell2mat(nn(6));
        if sol==1
            soltype=5;
        elseif sol==2
            soltype=4;
        elseif sol==4
            soltype=1;
        elseif sol==5
            soltype=2;
        elseif sol==6
            soltype=3;%dead reckoning
        end
        satnum=cell2mat(nn(7));
        res(ii,4:6)=[b,l,h];%b,l(deg),h(m) 
        [x,y,z]=blh2xyz(b,l,h);
        fprintf(fout,['%04d/%02d/%02d %02d:%02d:%06.3f %15.4f %15.4f %15.4f',...
            '%4d %4d %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %7.2f %7.1f %6d\n'],...
            2021,03,16,HH,MM,SS,x,y,z,soltype,satnum,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0);
        ii=ii+1;
    end   
    fclose(fout);     
    fclose(frtk);
elseif type==2
    frtk=fopen(infile);
    ii=1;
    while ~feof(frtk)        
        % 观测时间，纬度，经度，高程
        %纬度和经度是dddmm.mmmm度分格式，输出时除以100，即转成ddd.mmmmmm格式
        tline1=fgetl(frtk);   
        len=length(tline1);
        if tline1(1:9)=="%INSPVASA"
            nn=textscan(tline1,'%*9c,%f,%f;%*f,%*f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%*s');      
        else
           continue
        end
        res(ii,1)=cell2mat(nn(1));%week
        res(ii,2)=cell2mat(nn(2));%weeksec
        res(ii,3)=cell2mat(nn(3));%b,deg
        res(ii,4)=cell2mat(nn(4));%l,deg
        res(ii,5)=cell2mat(nn(5));%h
        res(ii,6)=cell2mat(nn(7));%e
        res(ii,7)=cell2mat(nn(6));%n
        res(ii,8)=cell2mat(nn(8));%u
        res(ii,9)=cell2mat(nn(9));%raw
        res(ii,10)=cell2mat(nn(10));%pitch
        res(ii,11)=cell2mat(nn(11));%yaw

        ii=ii+1;
    end
    fclose(frtk);

end