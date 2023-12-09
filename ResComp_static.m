function enu=ResComp_static(res,ref,type)
%type   -- 1:blh-blh,2:xyz-blh,3:xyz-xyz
    [ss1,~]=size(res);
    jj=1;
    for ii=1:ss1
%         if(res(ii,7)==1)
%             continue;
%         end
        if(type==1)
            blh=res(ii,2:4);%deg,deg,m
            blh1=ref;%deg,deg,m
            xyz=lla2ecef(blh);
            xyz1=lla2ecef(blh1);
        elseif(type==2)
            xyz=res(ii,2:4);%pos文件
            blh1=ref;%deg,deg,m
            xyz1=lla2ecef(blh1);
        elseif(type==3)
            xyz=res(ii,2:4);%pos文件
            xyz1=ref;%pos文件
            blh1=ecef2lla(xyz1);
        end
        dxyz=xyz-xyz1;
%         d_sz=[2.1952,0.4767,0.4822];
%         dxyz=dxyz+d_sz;
        ENU=xyz2enu(blh1,dxyz);
        if(jj==72)
            jj=72;
        end
        enu(jj,1:3)=ENU';
        jj=jj+1;
    end       
end