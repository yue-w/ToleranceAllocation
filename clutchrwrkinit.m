function [allParts, CONST,data]=clutchrwrkinit(maxIteration,CONSTMETHOD,METHOD)
%{
Case study. Use bigger sigma to compare the result of rework.
%}
    tolvec =[0.25 0.3 0.25 0.4];
    costVec = [6.5 5.16 3.7 2.7];
    a = [0 0 0 0];
    b = [0 0 0 0];
    
    initR = 0.1; step = 0.05; topR = 0.15;
    lengths = (topR-initR)/step+1;
    lengths = int16(lengths);
    R(lengths)=0;
    index = 1;
    for reworkR = initR:step:topR
        [allParts, CONST,data] = clutchrework(tolvec,maxIteration,reworkR,costVec,a,b,CONSTMETHOD);
        [allParts,data] = doValueIteration(allParts, maxIteration,CONST,data,METHOD); 
        R(index) = reworkR;
        datavec(index) = data;
        partsvec(index,:) = allParts;
        index = index + 1;
    end
    result.R = R;
    result.data = datavec;
    result.allParts = partsvec;
    %Write the result to a file
    writetofile(result);    
end

function writetofile(result)
%This function save the data to file 

    num = length(result.R);
    resultVectorRevenueLoss = zeros(2,num);
    numparts = size(result.allParts,2);    
    resultVectorTol = zeros(numparts,num);
    resultVectorMachinNum = zeros(numparts,num);
    resultVectorReworkNum = zeros(numparts,num);
    for index=1:length(result.data)       
        resultVectorRevenueLoss(1,index) = result.data(index).max;
        resultVectorRevenueLoss(2,index) = result.data(index).TaguchiLoss;       
        for partindex = 1:numparts
            %tolerance
            resultVectorTol(partindex,index) = result.allParts(index,partindex).tol;
            resultVectorMachinNum(partindex,index) = result.allParts(index,partindex).machinedNum;
            resultVectorReworkNum(partindex,index) = result.allParts(index,partindex).reworkNum;
        end
        
        %resultVector(3,index) = result.data(index).max;
    end
    resultVectorRevenueLoss = [result.R;resultVectorRevenueLoss];
    resultVectorTol= [result.R;resultVectorTol];
    resultVectorMachinNum = [result.R;resultVectorMachinNum];
    resultVectorReworkNum =  [result.R;resultVectorReworkNum];
    directory = pwd;%Current directory
    directory = fullfile(directory,'\data');
    %Revenue and Taguchi Loss
    fileName = 'revenueandloss'; 
    filenameCSV = strcat(fileName,'.csv');
    fileDestCSV  = fullfile(directory,filenameCSV); 
    csvwrite(fileDestCSV,resultVectorRevenueLoss);
    
    %Tolerance
    fileName = 'tolerance';
    filenameCSV = strcat(fileName,'.csv');
    fileDestCSV  = fullfile(directory,filenameCSV); 
    csvwrite(fileDestCSV,resultVectorTol);
    
    %Machined num
    fileName = 'machinednumber';
    filenameCSV = strcat(fileName,'.csv');
    fileDestCSV  = fullfile(directory,filenameCSV); 
    csvwrite(fileDestCSV,resultVectorMachinNum);  
    
    %Reworked num
    fileName = 'reworkednumber';
    filenameCSV = strcat(fileName,'.csv');
    fileDestCSV  = fullfile(directory,filenameCSV); 
    csvwrite(fileDestCSV,resultVectorReworkNum);     
    
    
%{
    structure of the file
    row 1: R
    row 2: revenue
    row 3: Taguchi loss
    row 4~ row 7: tolerance
    row 8: machined num
    row 9: reworked num

%}
end