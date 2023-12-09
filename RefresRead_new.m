function res=RefresRead_new(reffile,outfile,filetype,ts,te)
% 2020.7.1 wyx
% 从参考结果文件中读取组合导航解算结果  
% 1:组合导航结果(blh,deg)，2：NMEA结果(google结果)，3：pos格式结果，4.Novatel格式结果(xyz,改了杆臂)
if(filetype==1)
    frtk=fopen(reffile);
    for i=1:41
        tline1=fgetl(frtk);     
    end
    ii=1;
    while ~feof(frtk)        
        % 观测时间，纬度，经度，高程
        %纬度和经度是dddmm.mmmm度分格式，输出时除以100，即转成ddd.mmmmmm格式
        tline1=fgetl(frtk);
        len=length(tline1);
        if(len>60)
            nn=textscan(tline1,'%f %f %f %f %f %f %f %f %*[^\n]');
            %将时间存入结果矩阵中
            tt=cell2mat(nn(1));
            res(ii,1:3)=gpst2time(tt);
            %b,l(deg),h,vel_n,vel_e,vel_u
            res(ii,4:9)=cell2mat(nn(2:7));
            res(ii,10)=1;  % cell2mat(nn(8))         
        else
            nn=textscan(tline1,'%f %f %f %f %*[^\n]');
            %将时间存入结果矩阵中
            tt=cell2mat(nn(1));
            res(ii,1:3)=gpst2time(tt);
            %b,l(deg),h,vel_n,vel_e,vel_u
            res(ii,4:6)=cell2mat(nn(2:4));
        end
        ii=ii+1;
    end
elseif(filetype==2)
    frtk=fopen(reffile);
%     for i=1:2
%     tline1=fgetl(frtk);     
%     end
    ii=1;
    while ~feof(frtk)        
        % 观测时间，纬度，经度，高程
        %纬度和经度是dddmm.mmmm度分格式，输出时除以100，即转成ddd.mmmmmm格式
        tline1=fgetl(frtk);   
        len=length(tline1);
        if len > 50 && tline1(4)=='G'&& tline1(15)=='0'
            nn=textscan(tline1,'$GPGGA,%2c%2c%5c,%f,N,%f,W,%*d,%*d,%*f,%f,M,%f,%*s');      
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
        res(ii,1:3)=gpst2time(sec+36); %nmea提取的观测数据时间
        %ddmm.mmmm转dms
        b_dms=dm2dms(cell2mat(nn(4)));
        b=b_dms(1)+b_dms(2)/60+b_dms(3)/3600;%deg
        l_dms=dm2dms(cell2mat(nn(5)));
        l=l_dms(1)+l_dms(2)/60+l_dms(3)/3600;%deg
        h=cell2mat(nn(6))+cell2mat(nn(7));
        %西半球，L取反
        l=-l;
        res(ii,4:6)=[b,l,h];%b,l(deg),h(m)        
        ii=ii+1;
    end
elseif(filetype==3)
    frtk=fopen(reffile);
    for i=1:4
        tline1=fgetl(frtk);
    end
    ii=1;
    while ~feof(frtk)
        % 观测时间， XYZ
        tline1=fgetl(frtk);
        nn=textscan(tline1,'%*10c %f:%f:%f %f %f %f %f %f %*[^\n]');            
        %将时间和XYZ存入结果矩阵中  
        HH=cell2mat(nn(1));%hh
        MM=cell2mat(nn(2));%mm
        SS=cell2mat(nn(3));%ss.ssss utc
        sec=HH*3600+MM*60+SS;
        sec_ts=ts(1)*3600+ts(2)*60+ts(3);
        sec_te=te(1)*3600+te(2)*60+te(3);
%         if(sec<sec_ts)||(sec>sec_te)
%             continue;
%         end

%         Roll=deg2rad(cell2mat(nn(17)));%横滚
%         Pitch=deg2rad(cell2mat(nn(18)));%俯仰
%         Yaw=-deg2rad(cell2mat(nn(19)));%航向
%         %方向余弦矩阵Cb_n
%         Cb_n=angle2dcm(Yaw,Roll,Pitch,'ZXY');
%         L_b=[0,-0.3,0.3]';
%         L_n=Cb_n'*L_b;
%         refpos=cell2mat(nn(4:6));
%         [xyz]=enu2xyz(refpos,L_n');
%         res(ii,4:6)=xyz;  
        
        res(ii,1:3)=[HH,MM,SS];%gpst2time(sec) 
        res(ii,4:6)=cell2mat(nn(4:6));  
        res(ii,7:8)=cell2mat(nn(7:8));% soltype,satnum  
        ii=ii+1;
    end
elseif(filetype==4)
    frtk=fopen(reffile);
    fout=fopen(outfile,'w');
    fprintf(fout,'%s\n','% (x/y/z-ecef=WGS84,Q=1:fix,2:float,3:sbas,4:dgps,5:single,6:ppp,ns=# of satellites)');
    fprintf(fout,'%s\n','%  GPST                      x-ecef(m)       y-ecef(m)       z-ecef(m)    Q    ns   sdx(m)    sdy(m)    sdz(m)    sdxy(m)   sdyz(m)   sdzx(m)  age(s)   ratio  fixn');
    
    for i=1:15
        tline1=fgetl(frtk);
    end
    ii=1;
    while ~feof(frtk)
        % 观测时间， XYZ
        tline1=fgetl(frtk);
        nn=textscan(tline1,['%f:%f:%f %d/%d/%d %f %f %f %f %f %f %f' ... 
                            '%*f %*f %f %f %f %*f %f %f %f %*[^\n]']);
        %将时间和XYZ存入结果矩阵中  
        HH=cell2mat(nn(1));%hh
        MM=cell2mat(nn(2));%mm
        SS=cell2mat(nn(3));%ss.ssss utc
        MO=cell2mat(nn(4));%month
        DD=cell2mat(nn(5));%day
        YY=cell2mat(nn(6));%year
        res(ii,1:3)=[HH,MM,SS];%gpst2time(sec) 
        
        b=dms2degrees(cell2mat(nn(7:9)));
        l=dms2degrees(cell2mat(nn(10:12)));
        h=cell2mat(nn(13));
%         [x,y,z]=blh2xyz(b,l,h);
%         res(ii,4:6)=[b,l,h];%deg,deg,m
%         [b,l]=deg2rad(b,l);
        
        Roll=deg2rad(cell2mat(nn(17)));%横滚
        Pitch=deg2rad(cell2mat(nn(18)));%俯仰
        Yaw=-deg2rad(cell2mat(nn(19)));%航向
        %方向余弦矩阵Cb_n
        Cb_n=angle2dcm(Yaw,Roll,Pitch,'ZXY');
        L_b=[0,-0.3,0.3]';
        L_n=Cb_n'*L_b;
        [refpos(1),refpos(2),refpos(3)]=blh2xyz(b,l,h);
        [xyz]=enu2xyz(refpos,L_n');
        res(ii,4:6)=xyz;  
%         res(ii,4:6)=[b,l,h];%deg,deg,m

        res(ii,7)=1;
        res(ii,8:10)=cell2mat(nn(14:16));%Ve,Vn,Vu
        fprintf(fout,['%04d/%02d/%02d %02d:%02d:%06.3f %15.4f %15.4f %15.4f',...
            '%4d %4d %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %7.2f %7.1f %6d\n'],...
            YY,MO,DD,HH,MM,SS,xyz(1),xyz(2),xyz(3),1,0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0);
        ii=ii+1;
    end
elseif(filetype==5)
    frtk=fopen(reffile);
    frtk2=fopen(reffile);
    ii=1;
    jj=1;
    gga=[];ins=[];
    fout=fopen(outfile,'w');
    fprintf(fout,'%s\n','% (x/y/z-ecef=WGS84,Q=1:fix,2:float,3:sbas,4:dgps,5:single,6:ppp,ns=# of satellites)');
    fprintf(fout,'%s\n','%  GPST        B-blh(m)       l-blh(m)       h-blh(m)    Q    ns   sdx(m)    sdy(m)    sdz(m)    sdxy(m)   sdyz(m)   sdzx(m)  age(s)   ratio  fixn');

    while ~feof(frtk)||~feof(frtk2)
        % 观测时间，纬度，经度，高程，速度（N,E,U），Roll,Pitch,Yaw
        %纬度和经度是dddmm.mmmm度分格式，输出时除以100，即转成ddd.mmmmmm格式
        tline1=fgetl(frtk);
        tline2=fgetl(frtk2);
        len=length(tline1);
        if tline2(1:9)=="%INSPVASA"
            nn=textscan(tline2,'%*9c,%f,%f;%*f,%*f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%17c%*s');
            weeksec=cell2mat(nn(2));%weeksec
            tt_ins=gpst2time(weeksec+18);
            sec_ins=tt_ins(1)*3600+tt_ins(2)*60+tt_ins(3);
            Roll=cell2mat(nn(9));%横滚
            Pitch=cell2mat(nn(10));%俯仰
            Yaw=cell2mat(nn(11));%航向
            FLAG=cell2mat(nn(12));
            ins(jj,1)=sec_ins;
            ins(jj,2)=Roll;ins(jj,3)=Pitch;ins(jj,4)=Yaw;
            ins(jj,5:21)=FLAG;
            ins(jj,22)=weeksec;
            ins(jj,23:25)=cell2mat(nn(6:8));%vel n e u
            jj=jj+1;
        end
        if tline1(1:6)=="$GPGGA"
            mm=textscan(tline1,'$GPGGA,%2c%2c%5c,%f,N,%f,E,%d,%*d,%*f,%f,M,%f,%*s');
            tt=cell2mat(mm(1));HH=str2double(tt);%hh
            tt=cell2mat(mm(2));MM=str2double(tt);%mm
            tt=cell2mat(mm(3));SS=str2double(tt);%ss.ssss utc
            if HH==9&&MM==1&&SS==50
                HH=HH;
            end
            sec_gga=HH*3600+MM*60+SS+18;
            if(isempty(cell2mat(mm(4))))
                continue;
            end
            b_dms=dm2dms(cell2mat(mm(4)));
            b=b_dms(1)+b_dms(2)/60+b_dms(3)/3600;%deg
            l_dms=dm2dms(cell2mat(mm(5)));
            l=l_dms(1)+l_dms(2)/60+l_dms(3)/3600;%deg
            h=cell2mat(mm(7))+cell2mat(mm(8));
            soltype=cell2mat(mm(6));
            gga(ii,1)=sec_gga;
            gga(ii,2)=b;gga(ii,3)=l;gga(ii,4)=h;
            
            gga(ii,5)=soltype;
            ii=ii+1;
        end
    end
    len1=length(gga);
    len2=length(ins);
    res=[];
    for i=1:len1
        k=find(ins(:,1)==gga(i,1));
        if k<=0
            continue;
        end
        Cb_n=angle2dcm(ins(k,4),ins(k,2),ins(k,3),'ZXY');
%         L_b=[0.07,-0.38,0.37]';
%         L_b=[0.26,0.4,-0.06]';
        L_b=[0,0,0]';
        L_n=Cb_n'*L_b;
        [refpos(1),refpos(2),refpos(3)]=blh2xyz(gga(i,2),gga(i,3),gga(i,4));
        [xyz]=enu2xyz(refpos,L_n');
        [~,BLH(1),BLH(2),BLH(3)]=xyz2blh(xyz(1),xyz(2),xyz(3));
        t=gpst2time(gga(i,1)+18);
        res(i,1)=ins(k,22);
        res(i,2:4)=gga(i,2:4);
%         res(i,2:4)=BLH(1:3);
        res(i,5:7)=ins(k,2:4);% roll pitch yaw
        res(i,8:10)=ins(k,23:25);%vel N E U
        res(i,10)=-res(i,10);%vel D
        if(char(ins(k,5:21))=="INS_SOLUTION_GOOD")%&&(soltype==4)
            if((gga(i,5)==4))
                res(i,11)=1;
            else
                res(i,11)=0;
            end
        else
            res(i,11)=0;
        end
        fprintf(fout,'%4d %10.2f %16.4f %16.4f %16.4f %d %d %9.3f %9.3f %9.3f %9.3f %9.3f %9.3f %9.3f %9.3f %9.3f\n',...
                    2216,res(i,1),xyz(1),xyz(2),xyz(3),res(i,11),0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0);

    end
    
    
elseif(filetype==6)
    frtk=fopen(reffile);
    ii=1;
    while ~feof(frtk)
        
        
        % 观测时间，纬度，经度，高程
        %纬度和经度是dddmm.mmmm度分格式，输出时除以100，即转成ddd.mmmmmm格式
        tline1=fgetl(frtk);   
        len=length(tline1);
        if len > 50
            nn=textscan(tline1,'$GPGGA,%2c%2c%5c,%f,N,%f,E,%d,%*d,%*f,%f,M,%f,%*s');      
        else
           continue
        end
        %将时间存入结果矩阵中
        %将时间和BLH存入结果矩阵中       
        tt=cell2mat(nn(1));HH=str2double(tt);%hh
        tt=cell2mat(nn(2));MM=str2double(tt);%mm
        tt=cell2mat(nn(3));SS=str2double(tt);%ss.ssss utc    
        sec=HH*3600+MM*60+SS;      
        res(ii,1:3)=gpst2time(sec+36); %nmea提取的观测数据时间
       
        %ddmm.mmmm转dms
        b_dms=dm2dms(cell2mat(nn(4)));
        b=b_dms(1)+b_dms(2)/60+b_dms(3)/3600;%deg
        l_dms=dm2dms(cell2mat(nn(5)));
        l=l_dms(1)+l_dms(2)/60+l_dms(3)/3600;%deg
        h=cell2mat(nn(7))+cell2mat(nn(8));
        res(ii,4:6)=[b,l,h];%b,l(deg),h(m)
        soltype=cell2mat(nn(6));
        if(soltype==4)
            res(ii,7)=1;
        elseif(soltype==5)
            res(ii,7)=2;
        elseif(soltype==1)
            res(ii,7)=5;
        elseif(soltype==6)
            res(ii,7)=3;
        else
            res(ii,7)=0;
        end
        ii=ii+1;
    end
end


    


fclose(frtk);

% fclose(fout);
end