function enu=ResComp(res,ref,type)
%type   -- 1:blh-blh,2:xyz-blh,3:xyz-xyz
    [ss1,~]=size(res);
    [ff1,~]=size(ref);
    enu=zeros(ff1,3);
    jj=1;

    for kk=1:ff1

        for ii=1:ss1
            %找到对应的时间
%             tt1(1:2)=res(ii,1:2);tt1(3)=round(res(ii,3));%流动站时间（整数）
            sec1=ref(kk,1)*3600+ref(kk,2)*60+ref(kk,3);%比测基准时间（小数）
%             date=[2021,6,10,ref(kk,1),ref(kk,2),ref(kk,3)];
            gps_sow = ref(kk,1);
            gpst=res(ii,1);
%             sec2=res(ii,1)*3600+res(ii,2)*60+res(ii,3);%流动站时间（带小数）
            dt=gps_sow-gpst;
            if(dt<0)
                break;
            end
            if(dt>0)
                continue;
            end
%             %组合导航状态为1，固定解
%            if(res(ii,7)~=2)
%                 continue;
%             end
            if(jj==3368)
                jj=3368;
            end
             if(type==1)
                blh=res(ii,2:4);%deg,deg,m
                blh1=ref(kk,2:4);%deg,deg,m
                xyz=lla2ecef(blh);
                xyz1=lla2ecef(blh1);
            elseif(type==2)
                xyz=res(ii,2:4);%pos文件
                blh1=ref(kk,2:4);%deg,deg,m
                xyz1=lla2ecef(blh1);
            elseif(type==3)
                xyz=res(ii,2:4);%pos文件
                xyz1=ref(kk,2:4);%pos文件
                blh1=ecef2lla(xyz1);
            end
            dxyz=xyz-xyz1;
          
            datt=res(ii,5:7)-ref(kk,5:7);
            dvel=res(ii,8:10)-ref(kk,8:10);
            ENU=xyz2enu(blh1,dxyz);       
            enu(jj,1:3)=ENU';
            enu(jj,4:6)=datt;
            enu(jj,7:9)=dvel;
            jj=jj+1;
        end
    end
end