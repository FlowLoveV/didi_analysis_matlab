function[state,lat,lon,alt] = xyz2blh(x,y,z)
%���ܣ� �ռ�ֱ������ת�������
%���룺 x,y,zΪ�ռ�ֱ������ϵ�µ���ά����ֵ����λ��Ϊ��
%����� lat,lon,alt�ֱ�Ϊ�������ϵ�µ�γ�ȣ����Ⱥʹ�ظ�
%       lat��lon�ĵ�λΪ�ȣ�alt�ĵ�λΪ��
%       stateΪ״̬�������������Z����ʱ��stateΪ-1���������쳣ʱ��
%       ��������������1000��stateΪ0�����������stateΪ����������

format long g

if(nargin ~= 3)
    error('����������󣬹�����')
end
if(nargout ~= 4)
    error('����������󣬹��ĸ�')
end

if(length(x) ~= length(y) || length(x) ~= length(z))
    error('�������x,y,z�ĳߴ粻ƥ�䣡')
end

a = 6378137.0;                      %a - semimajor axis
b = 6356752.3142;                   %b - semiminor (polar) axis

eps = 1.0E-13;
pi_half = 1.570796326794895E0;		%pi_halfΪpi/2
e2 = 0.00669437999014E0;			%e2 - first eccentricity squared 
%E2 = 0.00673949674226E0;			%E2 - second eccentricity squared

rho = sqrt(x.^2 + y.^2);

for i = 1:length(x)
    callNumber = 0;
    if(rho(i) <= eps)
        if(z(i) >= 0)
            lat(i) = 90;                                    % γ�ȣ���λ���Ƕȣ�
        else
            lat(i) = -90;
        end
        lon(i) = 0;
        alt(i) = abs(z(i)) - b;
        state(i) = -1;
        continue;
    else
        lon(i) = 90*atan2(y(i),x(i))/pi_half;               % ���ȣ���λ���Ƕȣ�
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
        lat(i) = 90 * lat_cur / pi_half;                    % γ�ȣ���λ���Ƕȣ�
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
