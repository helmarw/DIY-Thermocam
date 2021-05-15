clear all
[file,path] = uigetfile('*.dat');
filename=fullfile(path,file);
[p,f,e]=fileparts(filename);
%%
close all

% 1 for celsius, 0 for kelvin
celsius = 1;  

if celsius == 1
    unit = '°C';
    format = 'degrees';
elseif celsius == 0
    unit = 'K';
    format ='auto';
end

fileID = fopen(filename);
A = fread(fileID,[160,120],'uint16','ieee-be');
A = (flipud(rot90(A)));

[Max,Imax] = max(A,[],'all','linear');
Max=Max/100-273.15*celsius;
[Min,Imin] = min(A,[],'all','linear');
Min=Min/100-273.15*celsius;
A = A/100-273.15*celsius;

figure1=figure;
image1=imagesc((A));

%-----------------------------------------------------
%disable this part if you dont want min/max datatips
dt=datatip(image1,'DataIndex',Imax);
dt=datatip(image1,'DataIndex',Imin);
image1.DataTipTemplate.DataTipRows(1).Label = '';
image1.DataTipTemplate.DataTipRows(1).Value = '';
image1.DataTipTemplate.DataTipRows(1).Format = format;
image1.DataTipTemplate.DataTipRows(1).Label = '';
image1.DataTipTemplate.DataTipRows(2).Label = '';
image1.DataTipTemplate.DataTipRows(2).Value = '';
%-----------------------------------------------------

colormap(turbo); %choose colormap which you like
c = colorbar;
c.Label.String = ['Temperature/',unit];
xticks([]);
yticks([]);
title(file);
xlabel(['min:',num2str(Min),unit ', max:' num2str(Max),unit]);
daspect([1 1 1]);

%% download from https://de.mathworks.com/matlabcentral/fileexchange/23629-export_fig
outfile= [f,'_',unit];
export_fig(outfile,'-transparent','-m4');