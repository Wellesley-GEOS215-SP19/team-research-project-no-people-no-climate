%%  Starter script for No-People-No-Climate
%Paleozoic
    filename = 'Paleozoic_strata_1994-2012_filt.csv'; 
    strata = readtable(filename);
    strata = sortrows(strata,10); %this line was lower in the next part but makes more sense to put it here
%Rock Geo
    filename = 'tblRockGeoData_filt.csv';
    rockGeo = readtable(filename);

%% Period sorting for ROCKGEO 
rockNAMES = {'Precambrian' 'Cambrian' 'Paleozoic' 'Ordovician' 'Silurian' 'Devonian' 'Mississippian' 'Pennsylvanian'...
    'Permian' 'Triassic' 'Mesozoic' 'Jurassic' 'Cretaceous' 'Tertiary' 'PalEocene' 'Eocene' 'Oligocene' 'Miocene'...
    'Pliocene' 'Quaternary' 'Pleistocene' 'Holocene'};
rockNamesFlipped = fliplr(rockNAMES);
rockNAMES = categorical(rockNAMES); %makes names categorical 
GEOL_AGE_filt = categorical(rockGeo.GEOL_AGE_filt); %preps the data to be categorical so you can sort by each period name
rockperiods = NaN*zeros(length(rockGeo.GEOL_AGE_filt),1); %makes an index of the periods for each 
for i=1:22
    ind = find(GEOL_AGE_filt == rockNamesFlipped(i));
    rockperiods(ind)= i;
end
%% Period sorting for STRATA
strataNAMES = unique(strata.Series_System);
    stratanum = [21	17	17	16	19	17	19	17	16	19	18	22	17	19]; %index numbers are same as rockperiods
strataNAMES = categorical(strataNAMES); %makes names categorical
strata.Series_System = categorical(strata.Series_System); %preps the data as categorical
strataperiods = NaN*zeros(length(strata.Series_System),1); %makes an index of the periods for each
for i=1:14
    ind = find(strata.Series_System == strataNAMES(i));
    strataperiods(ind)= stratanum(i); %assigns index numbers that are the same as rockperiods
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

%% Plotting Quartz vs Total Clay
figure(3);clf;
    scatter(strata.Quartz_, strata.TotalClay_, [], nicecolor('RRw'),'filled');
    xlabel('% quartz'); ylabel('% total clay');
    hold on
    P= polyfit(strata.Quartz_, strata.TotalClay_, 1); 
% [rho,df,rho_sig95] = correlate(strata.Quartz_,strata.TotalClay_);
XtoPlot = [1:7];    
%     figure(8); clf; 
    plot(XtoPlot, P(1)*XtoPlot + P(2), 'r--', 'LineWidth', 1); 
    hold off
%% Plotting quartz vs Feldspar, Carbonate, and Illite
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
for i=length(unique(strataperiods)):-1:1
    scatterm(strata.LATITUDE, strata.LONGITUDE, 25, strataperiods, 'filled'); hold on;
end
    colormap(cmocean('thermal')); colorbar;
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
    usamap({'ME','GA'}); geoshow('landareas.shp','FaceColor','black');hold on;
    scatterm(rockGeo.LATITUDE, rockGeo.LONGITUDE, [], rockperiods, 'filled'); 
    colormap(cmocean('thermal')); h = colorbar; set( h, 'YDir', 'reverse' )
%% Plotting Quartz vs Total Clay colored by period from STRATA data set
figure(12);clf;
    scatter(strata.Quartz_, strata.TotalClay_, [], strata.Series_System,'filled');
    legend('Cambrian', 'Ordovician', 'Silurian', 'Devonian', 'Mississippian');
    xlabel('% quartz'); ylabel('% total clay');
    
%% Plotting the ratio of Quartz/Total Clay by period
figure(13);clf;
    scatter(strataperiods, (strata.Quartz_./strata.TotalClay_), 'filled');
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
    scatter(strataperiods, (strata.Quartz_./strata.Carbonate_), 'filled');
    xlabel('% periods (numeric, check indices)'); ylabel('Quartz/Carbonate');
%% Plotting the ratio of Feldspar/Carbonate by period
figure(16);clf;
    scatter(strataperiods, (strata.Feldspar_./strata.Carbonate_), 'filled');
    xlabel('% periods (numeric, check indices)'); ylabel('Feldspar/Carbonate');
%% Plotting the ratio of Total Clay/Carbonate by period
figure(16);clf;
    scatter(strataperiods, (strata.TotalClay_./strata.Carbonate_), 'filled');
    xlabel('% periods (numeric, check indices)'); ylabel('Total Clay/Carbonate');
    
%% Plotting minerals by period
minerals = {'Quartz_', 'Feldspar_', 'Chlorite_', 'TotalClay_'};
mineraltable = NaN*zeros(14, 4, 3);  %makes a table for averages and std and N
for i=1:(length(unique(strata.Series_System)))
    for j=1:4
        mineraltable(i,j,1) = mean(strata.(minerals{j})(find(strata.Series_System == strataNAMES(i))), 'omitnan');
        mineraltable(i,j,2) = std(strata.(minerals{j})(find(strata.Series_System == strataNAMES(i))), 'omitnan');
        ind = size(find((strata.(minerals{j})(find(strata.Series_System == strataNAMES(i))))>0));
        mineraltable(i,j,3) = ind(1);
    end
end
%%
figure(17)
for i=1:4
	subplot(2,2,i);
    bar(unique(strata.Series_System), mineraltable(:,i,1)); hold on 
    e = errorbar(unique(strata.Series_System), mineraltable(:,i,1), mineraltable(:,i,2), '.');
    e.LineWidth = 3; hold on;
    e.CapSize = 15; hold on;
    ylabel(minerals{i});
    xt = get(gca, 'XTick');
    set(gca, 'FontSize', 10)
end
