function [Rm,Rn] = R( lat_pre )
%   更新子午圈和卯酉圈的曲率半径
%   input:  lat_pre -- 纬度
%   output: Rm      -- 子午圈曲率半径
%           Rn      -- 卯酉圈曲率半径
    a=6.3781370*10^6;                       %椭球长半轴
    E=0.00669437999013;                     %第一偏心率的平方
    Rm=a*(1-E)/(1-E*sin(lat_pre)*sin(lat_pre))^1.5; %子午圈曲率半径更新
    Rn=a/sqrt(1-E*sin(lat_pre)*sin(lat_pre));       %卯酉圈曲率半径更新
end

