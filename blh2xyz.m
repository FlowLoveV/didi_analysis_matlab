function[x,y,z] = blh2xyz(lat,lon,alt)
%���ܣ� �������ת�ռ�ֱ������
%���룺 lat,lon,alt�ֱ�Ϊ�������ϵ�µ�γ�ȣ����Ⱥʹ�ظ�
%       lat��lon�ĵ�λΪ�ȣ�alt�ĵ�λΪ��
%����� x,y,zΪ�ռ�ֱ������ϵ�µ���ά����ֵ����λ��Ϊ��

    format long g

    if(nargin ~= 3)
        error('����������󣬹�����')
    end
    if(nargout ~= 3)
        error('����������󣬹�����')
    end

    if(length(lat) ~= length(lon) || length(lat) ~= length(alt))
        error('�������lat,lon,alt�ĳߴ粻ƥ�䣡')
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
