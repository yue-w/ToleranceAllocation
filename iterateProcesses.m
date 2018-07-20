function allParts = iterateProcesses(allParts, thisPartIndex,CONST)
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
        
        %Compute cost of current tolerance allocation stragegy
        
        %thisPart = machinePart_bounds(thisPart, thisProcess, tol, CONST);
        thisPart = machinePart_bounds(thisPart, i, thisPart.tol, CONST);
        maxProfit = computeTotalProfit(allParts, thisPart,0, i,CONST);
                        
        %Iterate tolerances
        tol = ub;        
        while( tol >= lb )   
            thisPart = machinePart_bounds(thisPart, i, tol, CONST);
            totalProfit = computeTotalProfit(allParts, thisPart,thisPartIndex, i, CONST);
            
            if(totalProfit>maxProfit)
               maxProfit = totalProfit;
               thisPart.tol = tol; 
               thisPart.processIndex = i;
            end
            tol = tol - CONST.STEP;
        end
        
    end
    
    allParts(thisPartIndex) = thisPart;
end