function r=blh2ecef(blh)
% blh -- 纬度、经度、高度(rad)
    RE_WGS84=6378137.0;
    FE_WGS84=1.0/298.257223563;
    ee = FE_WGS84 * (2.0 - FE_WGS84);
    cosp=cos(blh(1));
    sinp=sin(blh(1));
    sinl=sin(blh(2));
    cosl=cos(blh(2));
    v = RE_WGS84 / sqrt(1.0 - ee * sinp*sinp);
    r(1)=(v + blh(3))*cosp*cosl;
    r(2) = (v + blh(3))*cosp*sinl;
    r(3)=(v*(1.0 - ee) + blh(3))*sinp;
end