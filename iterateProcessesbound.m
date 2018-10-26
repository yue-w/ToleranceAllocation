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
            switch CONST.METRIC
                case 0 % if benefit is used as the metric
                    [totalProfit,num_products,TaguchiLoss] = computeTotalProfit(allParts, thisPart,thisPartIndex, i, CONST); 
                    metric = totalProfit;
                case 1 % if unit is used as the metric
                    [unitCost,num_products,TaguchiLoss] = computeUnitCost(allParts, thisPart,thisPartIndex, i, CONST); 
                    %Put a negative here so that we can unify the
                    %comparation to be the larger the better. (larger negative cost means lower positive cost, e.g. -1>-3)
                    metric = -unitCost;
            end            
            %[totalProfit,num_products,TaguchiLoss] = computeTotalProfit(allParts, thisPart,thisPartIndex, i, CONST);            
            if(metric>=data.max)
               data.max = metric;
               data.TaguchiLoss = TaguchiLoss;
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