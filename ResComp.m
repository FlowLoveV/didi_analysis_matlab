function enu=ResComp(res,ref,type)
%2022.11.28 修改比对条件为<=0.0051(raw:<0.005)
%type   -- 1:blh-blh,2:xyz-blh,3:xyz-xyz
    [ss1,ss2]=size(res);
    [ff1,~]=size(ref);
    enu=zeros(ff1,3);
    jj=1;
    for ii=1:ss1
        res_weeksec=res(ii,1);
        if ss2 > 6
            if(abs(round(res_weeksec)-res_weeksec)<=0.0051&&ii>1)
                if(abs(round(res_weeksec)-res(ii-1,1))<=0.0051)
                    if jj>1
                        jj=jj-1;
                    else
                        jj=1;
                    end
                end
                res_weeksec=round(res_weeksec);
            else
                continue;
            end
        end
        [kk,~]=find((ref(:,1)==res_weeksec));
        if ~isempty(kk)
             %组合导航状态为1，固定解
           if(ref(kk,11)~=1)
                continue;
           end
           if res_weeksec==545688
               jj=jj;
           end
            if jj==2351
                jj=2351;
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
            ENU=xyz2enu(blh1,dxyz);
            dENU=[0.26,0.4,-0.06];
%             dENU=[-0.06,-0.38,0.26];
            ENU_cor=ENU'+dENU;%
            enu(jj,1:3)=ENU';%ENU_cor;
            if ss2 > 6
                datt=res(ii,5:7)-ref(kk,5:7);
                dvel=res(ii,8:10)-ref(kk,8:10);
                enu(jj,4:6)=datt;
                enu(jj,7:9)=dvel;
                enu(jj,10)=res_weeksec;
            end
            jj=jj+1;
        
        end
    end
    
end