%analyse  residuals of kalman filter
residual=load('../../result/INS_TC/residual_20220628.txt');
[b,m,n]=unique(residual(:,1));
resi=zeros(size(b,1),3);
for ii=b(1):b(end)
p=find(residual(:,1)==ii);
resi(ii-b(1)+1,:)=residual(p(end),:);
end
figure
yyaxis left;
plot(resi(3:end,2));
yyaxis right;
plot(resi(3:end,3));

