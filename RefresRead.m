function res=RefresRead(reffile,outfile,filetype,ts,te)
% 2020.7.1 wyx
% �Ӳο�����ļ��ж�ȡ��ϵ���������  
% 1:��ϵ������(blh,deg)��2��NMEA���(google���)��3��pos��ʽ�����4.Novatel��ʽ���(xyz,���˸˱�)
if(filetype==1)
    frtk=fopen(reffile);
    for i=1:41
        tline1=fgetl(frtk);     
    end
    ii=1;
    while ~feof(frtk)        
        % �۲�ʱ�䣬γ�ȣ����ȣ��߳�
        %γ�Ⱥ;�����dddmm.mmmm�ȷָ�ʽ�����ʱ����100����ת��ddd.mmmmmm��ʽ
        tline1=fgetl(frtk);
        len=length(tline1);
        if(len>60)
            nn=textscan(tline1,'%f %f %f %f %f %f %f %f %*[^\n]');
            %��ʱ�������������
            tt=cell2mat(nn(1));
            res(ii,1:3)=gpst2time(tt);
            %b,l(deg),h,vel_n,vel_e,vel_u
            res(ii,4:9)=cell2mat(nn(2:7));
            res(ii,10)=1;  % cell2mat(nn(8))         
        else
            nn=textscan(tline1,'%f %f %f %f %*[^\n]');
            %��ʱ�������������
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
        % �۲�ʱ�䣬γ�ȣ����ȣ��߳�
        %γ�Ⱥ;�����dddmm.mmmm�ȷָ�ʽ�����ʱ����100����ת��ddd.mmmmmm��ʽ
        tline1=fgetl(frtk);   
        len=length(tline1);
        if len > 50 && tline1(4)=='G'&& tline1(15)=='0'
            nn=textscan(tline1,'$GPGGA,%2c%2c%5c,%f,N,%f,W,%*d,%*d,%*f,%f,M,%f,%*s');      
        else
           continue
        end
        %��ʱ�������������
        %��ʱ���BLH������������       
        tt=cell2mat(nn(1));HH=str2double(tt);%hh
        tt=cell2mat(nn(2));MM=str2double(tt);%mm
        tt=cell2mat(nn(3));SS=str2double(tt);%ss.ssss utc      
        res(ii,1:3)=[HH,MM,SS];
        sec_gga=HH*3600+MM*60+SS;      
        res(ii,1:3)=gpst2time(sec_gga+36); %nmea��ȡ�Ĺ۲�����ʱ��
        %ddmm.mmmmתdms
        b_dms=dm2dms(cell2mat(nn(4)));
        b=b_dms(1)+b_dms(2)/60+b_dms(3)/3600;%deg
        l_dms=dm2dms(cell2mat(nn(5)));
        l=l_dms(1)+l_dms(2)/60+l_dms(3)/3600;%deg
        h=cell2mat(nn(6))+cell2mat(nn(7));
        %������Lȡ��
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
        % �۲�ʱ�䣬 XYZ
        tline1=fgetl(frtk);
        nn=textscan(tline1,'%*10c %f:%f:%f %f %f %f %f %f %*[^\n]');            
        %��ʱ���XYZ������������  
        HH=cell2mat(nn(1));%hh
        MM=cell2mat(nn(2));%mm
        SS=cell2mat(nn(3));%ss.ssss utc
        sec_gga=HH*3600+MM*60+SS;
        sec_ts=ts(1)*3600+ts(2)*60+ts(3);
        sec_te=te(1)*3600+te(2)*60+te(3);
%         if(sec<sec_ts)||(sec>sec_te)
%             continue;
%         end

%         Roll=deg2rad(cell2mat(nn(17)));%���
%         Pitch=deg2rad(cell2mat(nn(18)));%����
%         Yaw=-deg2rad(cell2mat(nn(19)));%����
%         %�������Ҿ���Cb_n
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
        % �۲�ʱ�䣬 XYZ
        tline1=fgetl(frtk);
        nn=textscan(tline1,['%f:%f:%f %d/%d/%d %f %f %f %f %f %f %f' ... 
                            '%*f %*f %f %f %f %*f %f %f %f %*[^\n]']);
        %��ʱ���XYZ������������  
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
        
        Roll=deg2rad(cell2mat(nn(17)));%���
        Pitch=deg2rad(cell2mat(nn(18)));%����
        Yaw=-deg2rad(cell2mat(nn(19)));%����
        %�������Ҿ���Cb_n
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
%     fout=fopen(outfile,'w');
%     fprintf(fout,'%s\n','% (x/y/z-ecef=WGS84,Q=1:fix,2:float,3:sbas,4:dgps,5:single,6:ppp,ns=# of satellites)');
%     fprintf(fout,'%s\n','%  GPST                      x-ecef(m)       y-ecef(m)       z-ecef(m)    Q    ns   sdx(m)    sdy(m)    sdz(m)    sdxy(m)   sdyz(m)   sdzx(m)  age(s)   ratio  fixn');

    ii=1;
    sec_gga=0;
    while ~feof(frtk)        
        % �۲�ʱ�䣬γ�ȣ����ȣ��̣߳��ٶȣ�N,E,U����Roll,Pitch,Yaw
        %γ�Ⱥ;�����dddmm.mmmm�ȷָ�ʽ�����ʱ����100����ת��ddd.mmmmmm��ʽ
        tline1=fgetl(frtk);   
        len=length(tline1);
        if(tline1(1)=='#')||(tline1(2)=='R')
            continue;
        end
        if tline1(1:6)=="$GPGGA"
            mm=textscan(tline1,'$GPGGA,%2c%2c%5c,%f,N,%f,E,%d,%*d,%*f,%f,M,%f,%*s');  
            tt=cell2mat(mm(1));HH=str2double(tt);%hh
            tt=cell2mat(mm(2));MM=str2double(tt);%mm
            tt=cell2mat(mm(3));SS=str2double(tt);%ss.ssss utc
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
        elseif tline1(1:9)=="%INSPVASA"
            nn=textscan(tline1,'%*9c,%f,%f;%*f,%*f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%17c%*s');   
            weeksec=cell2mat(nn(2));%weeksec
            tt_ins=gpst2time(weeksec+18);
            sec_ins=tt_ins(1)*3600+tt_ins(2)*60+tt_ins(3);
            if(sec_gga==sec_ins)
                Roll=cell2mat(nn(9));%���
                Pitch=cell2mat(nn(10));%����
                Yaw=cell2mat(nn(11));%����
                %�������Ҿ���Cb_n
                Cb_n=angle2dcm(-Yaw,Roll,Pitch,'ZXY');
                L_b=[0.07,-0.38,0.37]';
                L_n=Cb_n'*L_b;
                [refpos(1),refpos(2),refpos(3)]=blh2xyz(b,l,h);
                [xyz]=enu2xyz(refpos,L_n');
                [~,blh(1),blh(2),blh(3)]=xyz2blh(xyz(1),xyz(2),xyz(3));
                res(ii,2:4)=blh;
                res(ii,1) =weeksec;
                res(ii,5)=Roll;
                res(ii,6)=Pitch;
                res(ii,7)=Yaw;
                res(ii,8:10)=cell2mat(nn(6:8));%vel N E U
                res(ii,10)=-res(ii,10);%vel D
                if(nn(12)=="INS_SOLUTION_GOOD")&&(soltype==4)
                    res(ii,11)=1;
                else
                    res(ii,11)=0;
                end
%                 fprintf(fout,['%04d/%02d/%02d %02d:%02d:%06.3f %15.4f %15.4f %15.4f',...
%                     '%4d %4d %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %7.2f %7.1f %6d\n'],...
%                     2021,06,17,res(ii,1),res(ii,2),res(ii,3),xyz(1),xyz(2),xyz(3),res(ii,7),0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0);

                ii=ii+1;
                
            end
        else
            continue;
        end        
        
    end
elseif(filetype==6)
    frtk=fopen(reffile);
%     fout=fopen(outfile,'w');
%     fprintf(fout,'%s\n','% (x/y/z-ecef=WGS84,Q=1:fix,2:float,3:sbas,4:dgps,5:single,6:ppp,ns=# of satellites)');
%     fprintf(fout,'%s\n','%  GPST                      x-ecef(m)       y-ecef(m)       z-ecef(m)    Q    ns   sdx(m)    sdy(m)    sdz(m)    sdxy(m)   sdyz(m)   sdzx(m)  age(s)   ratio  fixn');

    ii=1;
    while ~feof(frtk)        
        % �۲�ʱ�䣬γ�ȣ����ȣ��߳�
        %γ�Ⱥ;�����dddmm.mmmm�ȷָ�ʽ�����ʱ����100����ת��ddd.mmmmmm��ʽ
        tline1=fgetl(frtk);   
        len=length(tline1);
        if tline1(4)=='R'
            continue;
        end
        if len > 50
            nn=textscan(tline1,'%*7c%2c%2c%11c,%f,N,%f,E,%d,%d,%*f,%f,M,%f,M,%f,%*s');      
        else
           continue
        end
        %��ʱ�������������
        %��ʱ���BLH������������       
        tt=cell2mat(nn(1));HH=str2double(tt);%hh
        tt=cell2mat(nn(2));MM=str2double(tt);%mm
        tt=cell2mat(nn(3));SS=str2double(tt);%ss.ssss utc    
        sec_gga=HH*3600+MM*60+SS;      
        res(ii,1:3)=gpst2time(sec_gga+36); %nmea��ȡ�Ĺ۲�����ʱ��
        
        %ddmm.mmmmתdms
        b_dms=dm2dms(cell2mat(nn(4)));
        b=b_dms(1)+b_dms(2)/60+b_dms(3)/3600;%deg
        l_dms=dm2dms(cell2mat(nn(5)));
        l=l_dms(1)+l_dms(2)/60+l_dms(3)/3600;%deg
        h=cell2mat(nn(8))+cell2mat(nn(9));
       
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
        [x,y,z]=blh2xyz(b,l,h);
        satnum=cell2mat(nn(7));
        age=cell2mat(nn(10));
%          fprintf(fout,['%04d/%02d/%02d %02d:%02d:%06.3f %15.4f %15.4f %15.4f',...
%             '%4d %4d %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %7.2f %7.1f %6d\n'],...
%             2021,09,26,res(ii,1),res(ii,2),res(ii,3),x,y,z,res(ii,7),satnum,0.0,0.0,0.0,0.0,0.0,0.0,0.0,age,0);

        ii=ii+1;
    end
end
fclose(frtk);

% fclose(fout);
end