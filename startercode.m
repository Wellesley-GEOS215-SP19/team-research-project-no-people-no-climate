%% Starter script for No-People-No-Climate
%figure of our data locations
filename = 'latlon.xlsx'; 
geos215 = readtable(filename);
geos215 = table2array(geos215);
geos215S1 = xlsread(filename,'Sheet2');
%geos215S1 = table2array(geos215S1);

figure(1);clf;
    worldmap('USA'); geoshow('landareas.shp','FaceColor','black')
    scatterm(geos215(:,1), geos215(:,2), 'm.');
    scatterm(geos215S1(:,1), geos215S1(:,2), 'r.');
    
%% actually uploading data
 %use lines 3-6 as necessary to read in the 3 xlsx sheets in Github and
 %name them something good. 
 
%% 
 %use something similar to the CO2 data lab to match the LAB_ID values from
 %the table and xtb files so that xtb file has corresponding lat and lon so we can graph it
 
 