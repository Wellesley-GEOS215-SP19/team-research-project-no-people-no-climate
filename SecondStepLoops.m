

 
%% 
 %use something similar to the CO2 data lab to match the LAB_ID values from
 %the table and xtb files so that xtb file has corresponding lat and lon so we can graph it
 
 %longrid = unique(geos215.LONGITUTE);
 %latgird = unique(geos215.LATITUDE);
 
 %% use something similar to the CO2 data lab to match the LAB_ID values from
 %the table and xtb files so that xtb file has corresponding lat and lon so we can graph it
for i=1:38581
    indName =find(strcmp(rockGeo.https___mrdata_usgs_gov_ngdb_ngdbrock_tab_zip, chem.LAB_ID(i)));
    chem.LAT(i) = rockGeo.Var5(indName);
    chem.LON(i) = rockGeo.Var6(indName);
end

%% 2b. Pull out the seawater pCO2 (PCO2_SW) and sea surface temperature (SST)
%data and reshape it into your new 3-dimensional arrays
%  for i = 1:21084
%      indLON = find(CO2data.LON(i) == longrid);
%      indLAT = find(CO2data.LAT(i) == latgrid);
%      indM = find(CO2data.MONTH(i) == monthgrid);
%      CO2_SWgrid(indLON, indLAT, indM) = CO2data.PCO2_SW(i);
%      SSTgrid(indLON, indLAT, indM) = CO2data.SST(i);
%  end
%%%% 
 %use something similar to the CO2 data lab to match the LAB_ID values from
 %the table and xtb files so that xtb file has corresponding lat and lon so we can graph it
 
 %longrid = unique(geos215.LONGITUTE);
 %latgird = unique(geos215.LATITUDE);
 
%%