function [allParts,data] = iterateProcessessigma(allParts, thisPartIndex,CONST,data)
    thisPart = allParts(thisPartIndex);
    processes = thisPart.processes;
    
    %number of processes
    num_process = length(processes);
    
    %Iterate all processes
    for i = 1:num_process
        thisProcess = processes(i);
        lb = thisProcess.lb;
        ub = thisProcess.ub;   
        %Iterate tolerances
        sigma = ub;   
        
        while( sigma >= lb && sigma>0 )   
            thisPart.tol = CONST.KSIGMA*sigma;
            thisPart = machinePart_sigma(thisPart, i, sigma, CONST);
            %update machining cost using sigma
            thisPart.processes(i).const.machiningConst = ...
                sigmacostequation(thisPart.processes(i).const,sigma);
            
            [totalProfit,num_products] = computeTotalProfit(allParts, thisPart,thisPartIndex, i, CONST);            
            if(totalProfit>=data.max)
               data.max = totalProfit;
               data.num_products = num_products;            
               %thisPart.tol = CONST.KSIGMA*sigma;               
               thisPart.processIndex = i;
               thisPart.processes(i).Sdev=sigma;
               allParts(thisPartIndex) = thisPart;
            end
            sigma = sigma - CONST.STEP;
        end
        
    end
%     allParts(thisPartIndex) = thisPart;
end