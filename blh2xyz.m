function[x,y,z] = blh2xyz(lat,lon,alt)
%功能： 大地坐标转空间直角坐标
%输入： lat,lon,alt分别为大地坐标系下的纬度，经度和大地高
%       lat与lon的单位为度，alt的单位为米
%输出： x,y,z为空间直角坐标系下的三维坐标值，单位都为米

    format long g

    if(nargin ~= 3)
        error('输入参数错误，共三个')
    end
    if(nargout ~= 3)
        error('输出参数错误，共三个')
    end

    if(length(lat) ~= length(lon) || length(lat) ~= length(alt))
        error('输入参数lat,lon,alt的尺寸不匹配！')
    end

    a = 6378137.0;                      %a - semimajor axis
    e2 = 0.00669437999014E0;			%e2 - first eccentricity squared 

	B = lat .*(pi/180.0);
    L = lon .*(pi/180.0);
    
	sinB = sin(B);
	cosB = cos(B);
	N = a ./ sqrt(1 - e2.*(sinB.*sinB));
	fTemp = (N+alt) .* cosB;
	x = fTemp .* cos(L);
	y = fTemp .* sin(L);
	z = (N.*(1-e2) + alt) .* sinB;
end    
