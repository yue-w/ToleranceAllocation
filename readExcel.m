% %%Read the profits in the iteration
% filename = 'profit_iterate';
% sheet = 1;
% xlRange = 'C1:CE3';
% max = readexe(filename,sheet,xlRange);


% %%Read the influence of rework cost
filename = 'revenueandloss';
sheet = 1;
xlRange = 'A1:S2';
data = readexe(filename,sheet,xlRange);

function data = readexe(filename,sheet,xlRange)
    directory = pwd;%Current directory
    directory = fullfile(directory,'\data');
    filename = strcat(filename,'.xlsx');
    filename  = fullfile(directory,filename); 
    data = xlsread(filename,sheet,xlRange);
end