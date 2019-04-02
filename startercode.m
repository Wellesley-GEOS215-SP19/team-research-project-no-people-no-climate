%% Starter script for No-People-No-Climate
%figure of our data locations
filename = 'latlon.xlsx'; 
CO2data = readtable(filename);
figure(1);clf;
    worldmap('USA'); geoshow('landareas.shp','FaceColor','black')
    scatterm(geos215(:,1), geos215(:,2), 'm.');
    scatterm(geos215S1(:,1), geos215S1(:,2), 'r.');
    
%% actually uploading data