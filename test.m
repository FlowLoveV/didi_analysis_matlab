clc;
clear;
infile='..\..\20221020-40\ins_result_addrtk_v3.5_1-7-1.txt';
outfile='..\..\20221020-40\ins_result_addrtk_v3.5_1-7-1-out.pos';
frtk=fopen(infile);
fout=fopen(outfile,'w');
nn=textscan(frtk,'%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%*f');
    res(:,1:4)=cell2mat(nn(1:4));% GPST B L H  
    res(:,5:7)=cell2mat(nn(8:10));%  Roll Pitch Heading
    res(:,8:10)=cell2mat(nn(5:7));% N E D
    
res(abs(round(res(:,1))-res(:,1))>0.0051,:)=[];
fprintf(fout,'%s\n','% (latitude/longitude/Height=WGS84,Q=1:fix,2:float,3:sbas,4:dgps,5:single,6:ppp,ns=# of satellites)');
    fprintf(fout,'%s\n','%  GPST       x-ecef(m)       y-ecef(m)       z-ecef(m)     Q    ns   sdx(m)    sdy(m)    sdz(m)    sdxy(m)   sdyz(m)   sdzx(m)  age(s)   ratio  fixn');

for ii=1:size(res,1)
 res(ii,1)=round(res(ii,1));
 blh=res(ii,2:4);
 [x,y,z]=blh2xyz(blh(1),blh(2),blh(3));
 fprintf(fout,['%4d %10.3f %15.4f %15.4f %15.4f',...
            '%6d %4d %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %7.2f %7.1f %6d\n'],...
            2232,res(ii,1), x, y,z,1,15,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0);
end
fclose all;
%  num=size(Ref,1);
%  reflla=Ref(1,2:4);
%  jj=1;
% for kk=2:num
%     reslla=Ref(kk,2:4);
%     xyz=lla2ecef(reflla);
%     xyz1=lla2ecef(reslla);
%     
%     dxyz=xyz1-xyz;
%     ENU=xyz2enu(reflla,dxyz);
%     enu(jj,1:3)=ENU';
% 
%     jj=jj+1;
%      
%  end

% num=size(Ref,1);
% jj=1;
% num_bad=0;
% while jj<num
%    if Ref(jj,11)==0
%        num_bad=num_bad+1;
%    end
%    jj=jj+1;
% end

