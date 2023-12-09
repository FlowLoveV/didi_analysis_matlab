function [Rm,Rn] = R( lat_pre )
%   ��������Ȧ��î��Ȧ�����ʰ뾶
%   input:  lat_pre -- γ��
%   output: Rm      -- ����Ȧ���ʰ뾶
%           Rn      -- î��Ȧ���ʰ뾶
    a=6.3781370*10^6;                       %���򳤰���
    E=0.00669437999013;                     %��һƫ���ʵ�ƽ��
    Rm=a*(1-E)/(1-E*sin(lat_pre)*sin(lat_pre))^1.5; %����Ȧ���ʰ뾶����
    Rn=a/sqrt(1-E*sin(lat_pre)*sin(lat_pre));       %î��Ȧ���ʰ뾶����
end

