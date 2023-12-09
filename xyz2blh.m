function[state,lat,lon,alt] = xyz2blh(x,y,z)
%功能： 空间直角坐标转大地坐标
%输入： x,y,z为空间直角坐标系下的三维坐标值，单位都为米
%输出： lat,lon,alt分别为大地坐标系下的纬度，经度和大地高
%       lat与lon的单位为度，alt的单位为米
%       state为状态量，当坐标点在Z轴上时，state为-1；当函数异常时，
%       即迭代次数超过1000，state为0；其他情况，state为迭代次数。

format long g

if(nargin ~= 3)
    error('输入参数错误，共三个')
end
if(nargout ~= 4)
    error('输出参数错误，共四个')
end

if(length(x) ~= length(y) || length(x) ~= length(z))
    error('输入参数x,y,z的尺寸不匹配！')
end

a = 6378137.0;                      %a - semimajor axis
b = 6356752.3142;                   %b - semiminor (polar) axis

eps = 1.0E-13;
pi_half = 1.570796326794895E0;		%pi_half为pi/2
e2 = 0.00669437999014E0;			%e2 - first eccentricity squared 
%E2 = 0.00673949674226E0;			%E2 - second eccentricity squared

rho = sqrt(x.^2 + y.^2);

for i = 1:length(x)
    callNumber = 0;
    if(rho(i) <= eps)
        if(z(i) >= 0)
            lat(i) = 90;                                    % 纬度（单位：角度）
        else
            lat(i) = -90;
        end
        lon(i) = 0;
        alt(i) = abs(z(i)) - b;
        state(i) = -1;
        continue;
    else
        lon(i) = 90*atan2(y(i),x(i))/pi_half;               % 经度（单位：角度）
        lat_cur = atan2(z(i)*(1+e2),rho(i));
        sinB = sin(lat_cur);
        N = a / sqrt(1 - e2*sinB*sinB);
        lat_old = lat_cur + 0.01;
        while(abs(lat_cur - lat_old) >= eps && callNumber < 1000)
            callNumber = callNumber + 1;
            lat_old = lat_cur;
            sinB = sin(lat_old);
            lat_cur = atan( (z(i) + N*e2*sinB) / rho(i) );
            N = a / sqrt(1 - e2*sinB*sinB);
        end
        lat(i) = 90 * lat_cur / pi_half;                    % 纬度（单位：角度）
        if(lat_cur < -eps || lat_cur > eps)
            alt(i) = z(i)/sin(lat_cur) - N*(1-e2);
        else
            alt(i) = rho(i)/cos(lat_cur) - N;
        end
        if(callNumber > 1000)
            state(i) = 0;
        else
            state(i) = callNumber;
        end
    end
end    
