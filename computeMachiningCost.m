function machiningCost = computeMachiningCost(allParts,thisPart, thisPartIndex,thisProcessIndex,CONST)
%This function compute machining cost for all parts. For a given machining
%process, the machining cost for different tolerance are the same.
    machiningCost = 0;
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
            cost_machining = part.processes(processindex).const.machiningConst * part.machinedNum;
            
            %Cost of reworking
            if CONST.REWORK.V ~= CONST.REWORK.FLAG.ADDPART
                
               cost_rework = part.processes(processindex).const.reworkConst * part.reworkNum;
            else
                cost_rework = 0;
            end
            machiningCost = machiningCost + cost_machining + cost_rework; 
    end
end