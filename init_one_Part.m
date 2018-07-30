function part = init_one_Part(processes, tol, dimension, processIndex)
%This function define attributes of a part
    
    %Array that store the processes that can be used to machine this part
    part.processes = processes;
    
    %The index of the process selected
    part.processIndex = processIndex;
    
    %Tolerance assigned to this part. 
    %For VarySigma, tol=c*sigma. c is constant
    part.tol = tol;
    
    %Designed dimension of this part
    part.dim = dimension;
    
    %Total parts machined (including parts that falls outside the tolerance bounds)
    %scalFactor = 1.1;%used in the begining of the iteration, assume the number of the parts
    part.totalNum =0 ;% CONST.BACH * scalFactor;
    
    %Simulated dimensions of a bach of this parts machined by thisProcess  
    part.dimensions = 0;
    
    %Machining cost with the correponding tolerance
    %part.machiningCost
end