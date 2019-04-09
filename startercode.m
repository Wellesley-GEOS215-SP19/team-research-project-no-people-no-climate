%% Starter script for No-People-No-Climate
%figure of our data locations
filename = 'latlon.xlsx'; 
geos215 = readtable(filename);
geos215 = table2array(geos215);
geos215S1 = xlsread(filename,'Sheet2');


figure(1);clf;
    worldmap('USA'); geoshow('landareas.shp','FaceColor','black')
    scatterm(geos215(:,1), geos215(:,2), 'm.');
    scatterm(geos215S1(:,1), geos215S1(:,2), 'r.');
    
%% actually uploading data
 %use lines 3-6 as necessary to read in the 3 xlsx sheets in Github and
 %name them something good.
 
 %Paleozoic
filename = 'Paleozoic_strata_1994-2012_filt.xlsx'; 
strata = xlsread(filename,'Gas_shale_db');

%%
%Rock Geo
filename = 'tblRockGeoData_filt.xlsx';
rockGeo = readtable(filename);



%%
%Chem
filename = 'xtbXrfChem_filt.xlsx';
chem = readtable(filename);
