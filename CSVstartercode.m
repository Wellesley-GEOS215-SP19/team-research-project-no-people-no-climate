% Loading csv and merging into a singular matlab file
% tabularTextDatastore(filepath - filefolder)
% “”.VariableNames =  {single quote names}
% “”.TextscanFormats = {the signs and types and formats}
% Order of the column names need to be the same order
% Can use excel to add columns as dummy columns 
% readall(“”) into a variable name
% Can right click a variable in the workspace and save as a .mat file
% To find indexes they need to matrices
% cell2mat(table2cell(the cells variable))

ttds = tabularTextDatastore('C:\Users\emmal\Documents\GitHub\team-research-project-no-people-no-climate',...
    'FileExtensions','.csv');
ttds.TextscanFormats = {'%s',	'%s',	'%s',	'%s',	'%s',	'%s',	'%s',	'%s',	'%s',	'%s',   '%s',	'%s',...
                         '%s',	'%s',	'%s',	'%s',	'%s',	'%s',	'%s',	'%s',	'%s',	'%s',   '%s',	'%s',	'%s',...
                         '%s',	'%s',	'%s',	'%s',	'%s',	'%s',	'%s',	'%s',	'%s',	'%s',   '%s',	'%s',	'%s',...
                         '%s',	'%s',	'%s',	'%s',	'%s',	'%s',	'%s',	'%s',	'%s',	'%s',   '%s',	'%s',	'%s',...
                         '%s',	'%s',	'%s',	'%s',	'%s',	'%s',	'%s',	'%s',	'%s',	'%s',   '%s',	'%s',	'%s',...
                         '%s',	'%s',	'%s',   '%s',	'%s'};
bigdata = readall(ttds);
%rockmatrix = cell2mat(table2cell(bigdata));
%%
