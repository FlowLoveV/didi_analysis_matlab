function res=RtkresRead(infile,ts,te,flag)
% 2020.6.23 wyx
% 读取贴片天线(蓝牙端)解算结果
% filetype -- 程序解算的pos文件
% flag -- 1(GINS结果),2(POS结果)
% res -- 结果矩阵（时间，坐标）
% 时间 -- hh,mm,ss.ssss
% 坐标 -- b(rad),l(rad),h(m)

frtk=fopen(infile);

if flag==1
    for i=1:52
        tline1=fgetl(frtk);
    end
    
    nn=textscan(frtk,'%f %f %f %f %*f %*f %*f %*f %*f %f %f %f %*f %*f %*f %*f %*f %*f %*f %*f %f %f %f');
    res(:,1:10)=cell2mat(nn(1:10));% GPST X Y Z Roll Pitch Heading N E D 
%     res(:,2:10)=cell2mat(nn(2:10));%  
%     res(:,4:10)=cell2mat(nn(4:10));%  B 
%     res(:,5:7)=cell2mat(nn(8:10));% 
%     res(:,8:10)=cell2mat(nn(5:7));% 

elseif flag == 2
    nn=textscan(frtk,'%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%*f');
    res(:,1:4)=cell2mat(nn(1:4));% GPST B L H  
    res(:,5:7)=cell2mat(nn(8:10));%  Roll Pitch Heading
    res(:,8:10)=cell2mat(nn(5:7));% N E D
elseif flag == 3
for i=1:4
    tline1=fgetl(frtk);
end
    nn=textscan(frtk,repmat('%f',[1,16]));
    %将时间和XYZ存入结果矩阵中
    gpst=cell2mat(nn(2));%tow
%     if(sec<sec_ts)||(sec>sec_te)
%         continue;
%     end
    res(:,1)=gpst; %
    res(:,2:4)=cell2mat(nn(3:5));%XYZ
    res(:,5)=cell2mat(nn(6));%Q,只统计Q=2
    res(:,6)=cell2mat(nn(7));%satnum

elseif flag == 4
    for i=1:4
        tline1=fgetl(frtk);
    end
    ii=1;
    while(~feof(frtk))
        tline1=fgetl(frtk);
        nn=textscan(tline1,'%f/%f/%f %f:%f:%f %f %f %f %d %d %*[^\n]');
        %将时间和XYZ存入结果矩阵中
        YY=cell2mat(nn(1));%year
        MO=cell2mat(nn(2));%month
        DD=cell2mat(nn(3));%day
        HH=cell2mat(nn(4));%hh
        MM=cell2mat(nn(5));%mm
        SS=cell2mat(nn(6));%ss.ssss utc
        Date=[YY ,MO, DD, HH, MM, SS];
        [gps_week, gps_sow, ~] = date2gps(Date);

        %     if(sec<sec_ts)||(sec>sec_te)
        %         continue;
        %     end
        
        res(ii,1)=gps_sow; %
        res(ii,2:4)=cell2mat(nn(7:9));%XYZ
        res(ii,5)=cell2mat(nn(10));%Q,只统计Q=2
        res(ii,6)=cell2mat(nn(11));%satnum
        ii=ii+1;
    end
elseif flag == 5
    for i=1:4
        tline1=fgetl(frtk);
    end
    ii=1;
    while(~feof(frtk))
        tline1=fgetl(frtk);      
        
        nn=textscan(tline1,'%d %f %f %f %f %d %d %*[^\n]');
        gps_week=cell2mat(nn(1));
        gps_sow=cell2mat(nn(2));
        
        
        %     if(sec<sec_ts)||(sec>sec_te)
        %         continue;
        %     end
        
        res(ii,1)=gps_sow; %
        res(ii,2:4)=cell2mat(nn(3:5));%BLH
        res(ii,5)=cell2mat(nn(6));%Q,只统计Q=2
        res(ii,6)=cell2mat(nn(7));%satnum
        ii=ii+1;
    end
elseif flag == 6
    for i=1:4
        tline1=fgetl(frtk);
    end
    ii=1;
    while(~feof(frtk))
        tline1=fgetl(frtk);
        
        nn=textscan(tline1,'%d %f %f %f %f %d %d %*[^\n]');
        gps_week=cell2mat(nn(1));
        gps_sow=cell2mat(nn(2));
        
        
        %     if(sec<sec_ts)||(sec>sec_te)
        %         continue;
        %     end
        
        res(ii,1)=gps_sow; %
        res(ii,2:4)=cell2mat(nn(3:5));%XYZ
        res(ii,5)=cell2mat(nn(6));%Q,只统计Q=2
        res(ii,6)=cell2mat(nn(7));%satnum
        ii=ii+1;
    end
elseif flag == 7
    ii = 1;
    format = "";
    for i = 1:62
       format = format + "%f, ";
    end
    while(~feof(frtk))
        tline1 = fgetl(frtk);
        nn = textscan(tline1,format);
        [h,m,s] = f2hms(cell2mat(nn(56)));
        [week,tow,~] = date2gps([2023,6,2,h,m,s]);
        res(ii,1) = tow + 18;       %
        res(ii,2:4) = cell2mat(nn(44:46));  % lat lon h  (rad rad m)
        res(ii,2:3) = res(ii,2:3) * 180 / pi; % change to degress
        res(ii,5:7) = cell2mat(nn(47:49));  % roll pitch yaw (rad)
        res(ii,5:7) = res(ii,5:7) * 180 / pi;
        res(ii,10) = cell2mat(nn(52));% e n u (m/s)
        res(ii,8) = cell2mat(nn(51));
        res(ii,9) = cell2mat(nn(50));
        ii = ii + 1;
    end
    
end
fclose(frtk);
end
