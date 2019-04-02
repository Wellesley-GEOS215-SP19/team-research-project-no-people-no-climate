%% Starter script for No-People-No-Climate
%figure of our data locations
filename = 'latlon.xlsx'; 
geos215 = readtable(filename);
geos215 = table2array(geos215);
geos215S1 = xlsread(filename,'Sheet2');
%geos215S1 = table2array(geos215S1);
%%
figure(1);clf;
    worldmap('USA'); geoshow('landareas.shp','FaceColor','black')
    scatterm(geos215(:,1), geos215(:,2), 'm.');
    scatterm(geos215S1(:,1), geos215S1(:,2), 'r.');
    
%% actually uploading data