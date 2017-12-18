load('sensors.mat')

%% 10-20 system anchors
X=[sensors([37 18 47 36 21 224 2 69 59 257 183 202 96 87 101 153 170 116 126 150]).X];
Y=[sensors([37 18 47 36 21 224 2 69 59 257 183 202 96 87 101 153 170 116 126 150]).Y];
Z=[sensors([37 18 47 36 21 224 2 69 59 257 183 202 96 87 101 153 170 116 126 150]).Z];

%% region based on nearest anchor
reg = griddata(X,Y,Z,[0 1 2 2 3 4 4 5 6 7 8 9 10 10 11 12 12 13 14 15],[sensors.X],[sensors.Y],[sensors.Z],'nearest');
reg(31) = nan; % exclude nasion
% topoplot(reg,sensors,'style','map','emarker','o','electrodes','on','colormap',colorcube(32))

FpLChans = find(reg==0);
FpRChans = find(reg==1);
FLChans  = find(reg==2);
FMChans  = find(reg==3);
FRChans  = find(reg==4);
TLChans  = find(reg==5);
CLChans  = find(reg==6);
CMChans  = find(reg==7);
CRChans  = find(reg==8);
TRChans  = find(reg==9);
PLChans  = find(reg==10);
PMChans  = find(reg==11);
PRChans  = find(reg==12);
OLChans  = find(reg==13);
OMChans  = find(reg==14);
ORChans  = find(reg==15);
