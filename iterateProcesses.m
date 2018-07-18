function allParts = iterateProcesses(allParts, thisPartIndex ,step)
%{
This function iterate all processes, choose the process and the
corresponding tolerance with lowest total cost
%}
    thisPart = allParts(thisPartIndex);
    processes = thisPart.processes;
    
    %number of processes
    num_process = length(processes);
    
    %Check all processes
    for i = 1:num_process
        thisProcess = processes(i);
        lb = thisProcess.lb;
        ub = thisProcess.ub;
        
        minCost = computeTotalCost(allParts, thisPart, thisProcess, thisPart.tol);
        tol = ub;
        while( tol >= lb )         
            totalCost = computeTotalCost(allParts, thisPart, thisProcess, tol);
            
            if(totalCost<minCost)
               minCost = totalCost;
               thisPart.tol = tol; 
            end
            tol = tol - step;
        end
        
    end
    
    allParts(thisPartIndex) = thisPart;
end