%%  Starter script for No-People-No-Climate
%Paleozoic
    filename = 'Paleozoic_strata_1994-2012_filt.csv'; 
    strata = readtable(filename);
    strata = sortrows(strata,10); %this line was lower in the next part but makes more sense to put it here
%Rock Geo
    filename = 'tblRockGeoData_filt.csv';
    rockGeo = readtable(filename);

%% Period sorting for STRATA
uniqueEras = unique(strata.Series_System);

%Assigning numbers to STRATA periods so they are mappable with each period=number 
strataPERIODS = NaN*zeros(1043,1);

CAMBRIAN = strata(1:11,:); %oldest Table: cambrianTable
        strataPERIODS(1:11) =  2;
upperCAM = strata(462,:);
        strataPERIODS(462) = 2.5;
ORD = strata(370:422,:);
        strataPERIODS(370:422) = 4;
midORD = strata(349:352,:);
        strataPERIODS(349:352) = 4.3;
lowerORD = strata(72:77,:);
        strataPERIODS(72:77) = 4.6;
upperORD = strata(885:1043,:);
        strataPERIODS(885:1043) = 4.9;
SIL = strata(423:461,:);
        strataPERIODS(423:461) = 5;
DEVONIAN = strata(12:63,:);
        strataPERIODS(12:63,:) = 6;
midDEV = strata(78:348,:);
        strataPERIODS(78:348) = 6.3;
midUpDEV = strata(353:362,:);
        strataPERIODS(353:362) = 6.6;
upperDEV = strata(463:884,:);
        strataPERIODS(463:884) = 6.9;
lowerMISS = strata(64:71,:);
        strataPERIODS(64:71) = 7;
MISS = strata(363:369,:); %youngest Table: missTable
        strataPERIODS(363:369) = 7.5;
%% Period sorting for ROCKGEO -- same as above, but does it in a loop 
rockNAMES = {'Precambrian' 'Cambrian' 'Paleozoic' 'Ordovician' 'Silurian' 'Devonian' 'Mississippian' 'Pennsylvanian'...
    'Permian' 'Triassic' 'Mesozoic' 'Jurassic' 'Cretaceous' 'Tertiary' 'PalEocene' 'Eocene' 'Oligocene' 'Miocene'...
    'Pliocene' 'Quaternary' 'Pleistocene' 'Holocene'};
rockNAMES = categorical(rockNAMES); %makes names categorical 
GEOL_AGE_filt = categorical(rockGeo.GEOL_AGE_filt); %preps the data to be categorical so you can sort by each period name
rockperiods = NaN*zeros(length(rockGeo.GEOL_AGE_filt),1); %makes an index of the periods for each 
for i=1:22
    ind = find(GEOL_AGE_filt == rockNAMES(i));
    rockperiods(ind)= i;
end

%% Mapping Quartz from STRATA data set
figure(1);clf;
    usamap({'ME','GA'}); geoshow('landareas.shp','FaceColor','black')
    scatterm(strata.LATITUDE, strata.LONGITUDE,[], strata.Quartz_, 'filled'); colorbar;

    
%% Mapping Quartz, Feldspar, and Total Clay from STRATA data set
figure(2);clf;
    subplot(221);
        usamap({'ME','GA'}); geoshow('landareas.shp','FaceColor','black')
        scatterm(strata.LATITUDE, strata.LONGITUDE, [], strata.Quartz_, 'filled'); colorbar; hold on;
        colormap(cmocean('amp')); hcb=colorbar; title(hcb,'% quartz');
	subplot(222);
        usamap({'ME','GA'}); geoshow('landareas.shp','FaceColor','black')
        scatterm(strata.LATITUDE, strata.LONGITUDE, [], strata.Feldspar_, 'filled'); colorbar;
        hcb=colorbar; title(hcb,'% feldspar');
	subplot(223);
        usamap({'ME','GA'}); geoshow('landareas.shp','FaceColor','black')
        scatterm(strata.LATITUDE, strata.LONGITUDE,[], strata.TotalClay_, 'filled'); colorbar;
        hcb=colorbar; title(hcb,'% total clay');

%% Plotting Quartz vs Total Clay, Feldspar, Carbonate, and Illite
figure(3);clf;
    scatter(strata.Quartz_, strata.TotalClay_, [], nicecolor('RRw'),'filled');
    xlabel('% quartz'); ylabel('% total clay');
figure(4);clf;
    scatter(strata.Quartz_, strata.Feldspar_, [], nicecolor('bgw'),'filled');
    xlabel('% quartz'); ylabel('% feldspar');
figure(5);clf;
    scatter(strata.Quartz_, strata.Carbonate_, [], nicecolor('Yyw'),'filled');
    xlabel('% quartz'); ylabel('% carbonate');
figure(6);clf;
    scatter(strata.Quartz_, strata.Illite_, [], nicecolor('RBw'),'filled');
    xlabel('% quartz'); ylabel('% illite');
    
%% Mapping STRATA data by period (periods assigned to a number but NOT TO (time)SCALE) 
figure(7);clf;
usamap({'ME','GA'}); geoshow('landareas.shp','FaceColor','black'); hold on;
for i=1:length(unique(strataPERIODS))
    %ind = find(strataPERIODS == i);
    scatterm(strata.LATITUDE, strata.LONGITUDE, 25, strataPERIODS, 'filled'); colorbar; hold on;
end
%% Plotting Total Clay vs Feldspar, Illite, Carbonate
figure(8);clf;
    scatter(strata.TotalClay_, strata.Feldspar_, [], nicecolor('RRw'),'filled');
    xlabel('% clay'); ylabel('% feldspar');
figure(9);clf;
    scatter(strata.TotalClay_, strata.Illite_, [], nicecolor('bgw'),'filled');
    xlabel('% clay'); ylabel('% illite');
figure(10);clf;
    scatter(strata.TotalClay_, strata.Carbonate_, [], nicecolor('Yyw'),'filled');
    xlabel('% clay'); ylabel('% carbonate');
%% Mapping ROCKGEO data by period (periods assigned to a number but NOT TO (time)SCALE) 
figure(11);
    usamap({'ME','TX'}); geoshow('landareas.shp','FaceColor','black');hold on;
    scatterm(rockGeo.LATITUDE, rockGeo.LONGITUDE, [], rockperiods, 'filled'); colorbar; hold on;
 
%% Plotting Quartz vs Total Clay colored by period from STRATA data set
figure(12);clf;
    scatter(strata.Quartz_, strata.TotalClay_, [], strataPERIODS,'filled'); colorbar;
    xlabel('% quartz'); ylabel('% total clay');
    
%% Plotting the ratio of Quartz/Total Clay by period
figure(13);clf;
    scatter(strataPERIODS, (strata.Quartz_./strata.TotalClay_), 'filled');
    xlabel('% periods (numeric, check indices)'); ylabel('Quartz/Total Clay');
%% Mapping Carbonate from STRATA data set
figure(14);clf;
    usamap({'ME','GA'}); geoshow('landareas.shp','FaceColor','black')
    scatterm(strata.LATITUDE, strata.LONGITUDE, [],strata.Carbonate_, 'filled'); colorbar;
%% Mapping Pyrite from STRATA data set
figure(15);clf;
    usamap({'ME','GA'}); geoshow('landareas.shp','FaceColor','black')
    scatterm(strata.LATITUDE, strata.LONGITUDE,[], strata.Pyrite_, 'filled'); colorbar;
%% Plotting the ratio of Quartz/Carbonate by period
figure(16);clf;
    scatter(strataPERIODS, (strata.Quartz_./strata.Carbonate_), 'filled');
    xlabel('% periods (numeric, check indices)'); ylabel('Quartz/Carbonate');
%% Plotting the ratio of Feldspar/Carbonate by period
figure(16);clf;
    scatter(strataPERIODS, (strata.Feldspar_./strata.Carbonate_), 'filled');
    xlabel('% periods (numeric, check indices)'); ylabel('Feldspar/Carbonate');
%% Plotting the ratio of Total Clay/Carbonate by period
figure(16);clf;
    scatter(strataPERIODS, (strata.TotalClay_./strata.Carbonate_), 'filled');
    xlabel('% periods (numeric, check indices)'); ylabel('Total Clay/Carbonate');
    
    
