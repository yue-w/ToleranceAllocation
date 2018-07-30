function machiningCost = computeMachiningCost(allParts,thisPart, thisPartIndex,thisProcessIndex)
%This function compute machining cost for all parts. For a given machining
%process, the machining cost for different tolerance are the same.
    machiningCost = 0;
    numParts = length(allParts);
    for i = 1:numParts
        if i ~= thisPartIndex %for the part not under iteration, use the stored values from former iterations
            part = allParts(i);
            cost_thisPart = part.processes(part.processIndex).const.machiningConst * part.totalNum;
            machiningCost = machiningCost + cost_thisPart;            
        else
            part = thisPart; %For the part under iteration, use the new value set to it
            cost_thisPart = part.processes(thisProcessIndex).const.machiningConst * part.totalNum;
            machiningCost = machiningCost + cost_thisPart;              
        end
%             cost_thisPart = part.processes(thisProcessIndex).const.machiningConst * part.totalNum;
%             machiningCost = machiningCost + cost_thisPart; 

    end
end