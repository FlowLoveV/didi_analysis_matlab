function ENU=xyz2enu(BLH,XYZ)
    b=deg2rad(BLH(1));l=deg2rad(BLH(2));
%     M=[        -sin(b)         cos(b),     0;
%         -sin(l)*cos(b),-sin(l)*sin(b),cos(l);
%          cos(l)*cos(b), cos(l)*sin(b),sin(l)];
    M=[        -sin(l)         cos(l),     0;
        -sin(b)*cos(l),-sin(b)*sin(l),cos(b);
         cos(b)*cos(l), cos(b)*sin(l),sin(b)];

     ENU=M*XYZ';
    
end