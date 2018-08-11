    fileName = 'rst';
    
    directory = pwd;%Current directory
    directory = fullfile(directory,'\data');
    %Write the result to csv
    filenameCSV = strcat(fileName,'.csv');
    fileDestCSV  = fullfile(directory,filenameCSV); 
    
    r = [1 2 3 4];
    name = 'name';
    resultVector={name,r};
    
    csvwrite(fileDestCSV,resultVector);