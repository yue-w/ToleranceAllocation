function [allParts, CONST,data]=clutchrwrkinit(maxIteration,CONSTMETHOD,METHOD)
%{
Case study. Use bigger sigma to compare the result of rework.
%}
A = 20;
    if A==0
        sigmavec =[0.083033 0.0916 0.066367 0.098533];
    elseif A==20
        sigmavec =[0.073733 0.0796 0.050467 0.079033];
    elseif A==100
        sigmavec =[0.0461 0.0535 0.039667 0.068533];
    end

    costVec = [6.510839 5.365357 4.006781 3.476996];
    a = [0 0 0 0];
    b = [0 0 0 0];
    
    initR = 0.1; step = 0.05; topR = 1;
    lengths = (topR-initR)/step+1;
    lengths = int16(lengths);
    R(lengths)=0;
    index = 1;
    for reworkR = initR:step:topR
        [allParts, CONST,data] = clutchrework(sigmavec,maxIteration,reworkR,costVec,a,b,CONSTMETHOD,A);
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