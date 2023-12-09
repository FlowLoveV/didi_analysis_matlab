function [ xyz_r ] = enu2xyz( refpos,enu )
%ENU2XYZ �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

[state,phi,lam,alt] = xyz2blh(refpos(1),refpos(2),refpos(3));
phi=phi*pi/180;
lam=lam*pi/180;
Cenune=[-sin(lam), cos(lam),0;
    -sin(phi) * cos(lam),-sin(phi)*sin(lam),cos(phi);
    cos(phi)*cos(lam),cos(phi)*sin(lam),sin(phi)];
deltaxyz=Cenune'*enu';
xyz_r=refpos'+deltaxyz;

end

