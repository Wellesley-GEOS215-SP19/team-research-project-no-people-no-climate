
 
 
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
 
 %Paleozoic
filename = 'Paleozoic_strata_1994-2012_filt.xlsx'; 
strata = xlsread(filename,'Gas_shale_db');
%strata = readtable(filename);
%strata = table2array(strata);

%%
%Rock Geo
filename = 'tblRockGeoData_filt.xlsx';
%rockGeo = xlsread(filename);
rockGeo = readtable(filename); %to conserve sample names
%rockGeo = table2array(rockGeo);


%%
%Chem
filename = 'xtbXrfChem_filt.xlsx';
%chem = xlsread(filename);
chem = readtable(filename); %to conserve sample names
%chem = table2array(chem);

 
%% use something similar to the CO2 data lab to match the LAB_ID values from
 %the table and xtb files so that xtb file has corresponding lat and lon so we can graph it
for i=1:38531
    indName =find(strcmp(rockGeo.https___mrdata_usgs_gov_ngdb_ngdbrock_tab_zip, chem.LAB_ID(i)))
    chem.LAT(i) = rockGeo.Var5(indName);
    chem.LON(i) = rockGeo.Var6(indName);
end

%%
 longrid = unique(geos215.LONGITUTE);
 latgird = unique(geos215.LATITUDE);
 
longrid = [0; unique(CO2data.LON); 360]; %finds all unique longitude values
latgrid = unique(CO2data.LAT); %<-- following the same approach, find all unique latitude values
monthgrid = unique(CO2data.MONTH); %<-- following the same approach, find all unique months

%Create empty 3-dimensional arrays of NaN values to hold your reshaped data
CO2_SWgrid = NaN*zeros(length(longrid), length(latgrid), length(monthgrid));    
SSTgrid = NaN*zeros(length(longrid), length(latgrid), length(monthgrid)); 

%% 2b. Pull out the seawater pCO2 (PCO2_SW) and sea surface temperature (SST)
%data and reshape it into your new 3-dimensional arrays
 for i = 1:21084
     indLON = find(CO2data.LON(i) == longrid);
     indLAT = find(CO2data.LAT(i) == latgrid);
     indM = find(CO2data.MONTH(i) == monthgrid);
     CO2_SWgrid(indLON, indLAT, indM) = CO2data.PCO2_SW(i);
     SSTgrid(indLON, indLAT, indM) = CO2data.SST(i);
 end
%%
%  