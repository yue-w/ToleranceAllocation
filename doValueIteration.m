function doValueIteration(allParts, maxIteration, CONST)
%{
This function do the value iteration

Input:
allParts: array that stores all the part
maxIteration: Maximum iteration number
CONST: stores const. CONST.TOL is the total tollerance 

Output:
allParts: with tolerance been allocated to each part
%} 

%     %number of parts to be assembled
%     num_parts = length(allParts);
    while(maxIteration>0)
        % Iterate all the parts, for each part iterate all processes
        allParts = iterateParts(allParts);
        maxIteration = maxIteration - 1;
    end
end

