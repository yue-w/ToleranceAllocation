function [allParts, CONST,data]=clutchrwrkinit(maxIteration,CONSTMETHOD,METHOD)
%{
Case study. Use bigger sigma to compare the result of rework.
%}
Avec = [0 20 100]; 
Alength = length(Avec);

    for i = 1:Alength
        A = Avec(i);
        METRIC = 1;
        a = [3.5 3.0 2.5 0.5];%The value of a and b are reduntant, because the cost is given.
        b = [0.75 0.65 0.3 0.88];
        if A==0
            sigmavec =[0.082433 0.100000 0.066367 0.128233];
            costVec = [6.53275374 5.166666667 4.006780512 2.787496751];        
        elseif A==20
            sigmavec =[0.082133 0.086500 0.063667 0.092833];
            costVec = [6.543831169 5.504816956 4.070680628 3.65978456];        
        elseif A==100
            sigmavec =[0.044300 0.051400 0.042667 0.067633];
            costVec = [8.762227239 7.215304799 4.84375 4.837111878];        
            a = [5.0 3.0 2.5 0.5];%The value of a and b are reduntant, because the cost is given.
            b = [0.5 0.65 0.3 0.88];        
        end
        initR = 0.1; step = 0.05; topR = 1;
        lengths = (topR-initR)/step+1;

        lengths = int16(lengths);
        R(lengths)=0;
        datavec(lengths) = 0;
        index = 1;
        for reworkR = initR:step:topR

            %Average the results of 4 times
            times = 4;
            metric = 0;
            for j = 1:times
                [allParts, CONST,data] = clutchrework(sigmavec,maxIteration,reworkR,costVec,a,b,CONSTMETHOD,A,METRIC);
                [allParts,data] = doValueIteration(allParts, maxIteration,CONST,data,METHOD); 
                metric = metric + data.max;
            end
            R(index) = reworkR;
            datavec(index) = metric/times;
    %         datavec(index) = data;
    %         partsvec(index,:) = allParts;
              index = index + 1;        
        end
        result.R = R;
        result.data = datavec;
        %result.allParts = partsvec;
        %Write the result to a file
        %writetofile(result);
        writetofilesimple(result,int2str(A));    
    end

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

function writetofilesimple(result,A)
    num = length(result.R);
    resultVectorRevenueLoss = zeros(1,num); 
    for index=1:num      
        resultVectorRevenueLoss(index) = result.data(index);            
        %resultVector(3,index) = result.data(index).max;
    end
    resultVectorRevenueLoss = [result.R;resultVectorRevenueLoss];

    directory = pwd;%Current directory
    directory = fullfile(directory,'\data');
    %Revenue and Taguchi Loss
    fileName = strcat('revenueorCost',A); 
    filenameCSV = strcat(fileName,'.csv');
    fileDestCSV  = fullfile(directory,filenameCSV); 
    csvwrite(fileDestCSV,resultVectorRevenueLoss);
end