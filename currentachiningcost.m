function machiningCost = currentachiningcost(allParts,CONST)
    machiningCost = 0;
    numParts = length(allParts);
    for i = 1:numParts

        part = allParts(i);
        processindex = part.processIndex;
        %cost_thisPart = part.processes(part.processIndex).const.machiningConst * part.machinedNum;
        %machiningCost = machiningCost + cost_thisPart;            

        cost_machining = part.processes(processindex).const.machiningConst * part.machinedNum;

        %Cost of reworking
        %Cost of reworking
        if CONST.REWORK.V ~= CONST.REWORK.FLAG.ADDPART

           cost_rework = part.processes(processindex).const.reworkConst * part.reworkNum;
        else
            cost_rework = 0;
        end
        machiningCost = machiningCost + cost_machining + cost_rework; 
        
    end
end