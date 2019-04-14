%%  Starter script for No-People-No-Climate
%Paleozoic
    filename = 'Paleozoic_strata_1994-2012_filt.csv'; 
    strata = readtable(filename);
%Rock Geo
    filename = 'tblRockGeoData_filt.csv';
    rockGeo = readtable(filename);

%% Era Sorting 
uniqueEras = unique(strata.Series_System);
sortedData = sortrows(strata, 10);

% arranged oldest to youngest with most general era older
CAMBRIAN = sortedData(1:11,:); %oldest Table: cambrianTable
upperCAM = sortedData(462,:);
ORD = sortedData(370:422,:);
midORD = sortedData(349:352,:);
lowerORD = sortedData(72:77,:);
upperORD = sortedData(885:1043,:);
SIL = sortedData(423:461,:);
DEVONIAN = sortedData(12:63,:);
midDEV = sortedData(78:348,:);
midUpDEV = sortedData(353:362,:);
upperDEV = sortedData(463:884,:);
lowerMISS = sortedData(64:71,:);
MISS = sortedData(363:369,:); %youngest Table: missTable

periods = {CAMBRIAN; upperCAM; ORD; midORD; lowerORD; upperORD; SIL; DEVONIAN; ...
    midDEV; midUpDEV; upperDEV; lowerMISS; MISS};
periodNAMES = {'CAMBRIAN' 'CAMBRIAN' 'ORDOVICIAN' 'ORDOVICIAN' 'ORDOVICIAN' 'ORDOVICIAN' 'SILURIAN' 'DEVONIAN' ...
    'DEVONIAN' 'DEVONIAN' 'DEVONIAN' 'MISSISSIPPIAN' 'MISSISSIPPIAN'};

%% Quartz map only
figure(1);clf;
    usamap({'ME','GA'}); geoshow('landareas.shp','FaceColor','black')
    scatterm(strata.LATITUDE, strata.LONGITUDE, strata.Quartz_, 'filled'); colorbar;
    
%% Devonian time map
figure(2);clf;
    usamap({'ME','GA'}); geoshow('landareas.shp','FaceColor','black')
    scatterm(DEVONIAN.LATITUDE, DEVONIAN.LONGITUDE, 14, 'filled'); colorbar;

%% Quartz, Feldspar, and Total Clay maps
figure(3);clf;
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

%% Quartz vs Total clay
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
    
%% data visualized by time era (grouped by overall period) 2 4 1 4 2
periodCOLOR = {'rbkk' 'rbkk' 'rbk' 'rbk' 'rbk' 'rbk' 'rb' 'rbww' 'rbww' 'rbww' 'rbww' 'rbwwww' 'rbwwww'};
figure(7);clf;
usamap({'ME','GA'}); geoshow('landareas.shp','FaceColor','black'); hold on;
for i=1:13
    scatterm(periods{i}.LATITUDE, periods{i}.LONGITUDE, 25, nicecolor(periodCOLOR{i}), 'filled'); hold on;
    %legend(periodNAMES{i});hold on;
end
    



