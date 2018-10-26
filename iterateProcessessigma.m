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
            tol = thisPart.tol;
            thisPart = machinePart(thisPart, i, sigma,tol, CONST);
            
            
            
            %update machining cost using sigma
            thisPart.processes(i).const.machiningConst = ...
                tolcostequation(thisPart.processes(i).const,tol);%Make sure to use the right value: sigma or tolerance
            
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
            
            if(metric>=data.max)
               data.max = metric;
               data.TaguchiLoss = TaguchiLoss;
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