function TotalScrapCost = computeComponentScrapCost(allParts,thisPart, thisPartIndex,thisProcessIndex,CONST)
%This function compute the total scrap cost for all assembled components

    TotalScrapCost = 0;
    numParts = length(allParts);
    
    for i = 1:numParts
        if i ~= thisPartIndex %for the part not under iteration, use the stored values from former iterations
            part = allParts(i);
            processindex = part.processIndex;
            %cost_thisPart = part.processes(part.processIndex).const.machiningConst * part.machinedNum;
            %machiningCost = machiningCost + cost_thisPart;            
        else
            processindex = thisProcessIndex;
            part = thisPart; %For the part under iteration, use the new value set to it
            %cost_thisPart = part.processes(thisProcessIndex).const.machiningConst * part.machinedNum;
            %machiningCost = machiningCost + cost_thisPart;              
        end
            scrapCost = part.processes(processindex).const.a * CONST.SCRAP.RATIO * part.scrapNum; 

            TotalScrapCost = TotalScrapCost + scrapCost; 
            
    end    
end