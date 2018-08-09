function [allParts,data] = iterateProcessesbound(allParts, thisPartIndex,CONST,data)
%{
This function iterate all processes for one part, choose the process and the
corresponding tolerance with lowest total cost

INPUT:
.
%}
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
        tol = ub;   
        sigma = thisProcess.Sdev;
        while( tol >= lb && tol>0 )   
            thisPart = machinePart(thisPart, i,sigma,tol, CONST);
            [totalProfit,num_products,taguchiLost] = computeTotalProfit(allParts, thisPart,thisPartIndex, i, CONST);            
            if(totalProfit>=data.max)
               data.max = totalProfit;
               data.TaguchiLoss = taguchiLost;
               data.num_products = num_products;
               thisPart.tol = tol; 
               thisPart.processIndex = i;
               allParts(thisPartIndex) = thisPart;
            end
            tol = tol - CONST.STEP;
        end
        
    end
%     allParts(thisPartIndex) = thisPart;
end