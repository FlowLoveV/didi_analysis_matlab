insfile='E:\Project\Inertial Explorer 890\20230325-134257-~1\0325';
imufile='E:\Project\Inertial Explorer 890\20230325-134257-~1\0325_ins.txt';
fins=fopen(insfile);
frtk=fopen(rtkfile,'w');
while ~feof(fins)
    tline=fgetl(fins);
    if tline(1)~='R'
        continue;
    end
    fprintf(frtk,"%s\n",tline);
end



% insfile='..\..\20221019-1s\ins-input-raw.txt';
% rtkfile='..\..\20221019-1s\rtk-input-raw.txt';
% fins=fopen(insfile);
% frtk=fopen(rtkfile,'w');
% while ~feof(fins)
%     tline=fgetl(fins);
%     if tline(1)~='R'
%         continue;
%     end
%     fprintf(frtk,"%s\n",tline);
% end
fclose all;
