%%  Starter script for No-People-No-Climate
%Paleozoic
    filename = 'Paleozoic_strata_1994-2012_filt.csv'; 
    strata = readtable(filename);
%Rock Geo
    filename = 'tblRockGeoData_filt.csv';
    rockGeo = readtable(filename);


%%
figure(1);clf;
    usamap({'ME','MS'}); geoshow('landareas.shp','FaceColor','black')
    scatterm(strata.LATITUDE, strata.LONGITUDE, strata.Quartz_, 'filled'); colorbar;
    %scatterm(geos215S1(:,1), geos215S1(:,2), 'r.');
%%
%Era Sorting 
uniqueEras = unique(strata.Series_System);
sortedData = sortrows(strata, 10);
cambrianTable = sortedData(1:11,:);
devonianTable = sortedData(12:63,:);
lowerMissTable = sortedData(64:71,:);
lowerOrdTable = sortedData(72:77,:);
midDevTable = sortedData(78:348,:);
midOrdTable = sortedData(349:352,:);
midUpDev = sortedData(353:362,:);
missTable = sortedData(363:369,:);
ordTable = sortedData(370:422,:);
silTable = sortedData(423:461,:);
upperCamTable = sortedData(462,:);
upperDevTable = sortedData(463:884,:);
upperOrdTable = sortedData(885:1043,:);
%%

%youngest Table: missTable
%oldest Table: cambrianTable

figure(2);clf;
    usamap({'ME','MS'}); geoshow('landareas.shp','FaceColor','black')
    scatterm(devonianTable.LATITUDE, devonianTable.LONGITUDE, 14, 'filled'); colorbar;


