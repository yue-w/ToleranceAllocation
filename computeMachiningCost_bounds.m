function machiningCost = computeMachiningCost_bounds(allParts,thisPart, thisPartIndex,thisProcessIndex)
%This function compute machining cost for all parts. For a given machining
%process, the machining cost for different tolerance are the same.
    machiningCost = 0;
    numParts = length(allParts);
    for i = 1:numParts
        if i ~= thisPartIndex
            part = allParts(i);
           
        else
            part = thisPart;
             
        end
            cost_thisPart = part.processes(thisProcessIndex).const.machiningConst * part.totalNum;
            machiningCost = machiningCost + cost_thisPart; 

    end
end