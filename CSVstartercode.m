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