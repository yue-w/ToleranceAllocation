function [allParts,data] = doValueIteration(allParts, maxIteration,CONST,data)
%{
This function performs the value iteration

Input:
allParts: array that stores all the part
maxIteration: Maximum iteration number
CONST: stores const. CONST.TOL is the total tollerance 

Output:
allParts: with tolerance been allocated to each part
%} 

%     %number of parts to be assembled
%     num_parts = length(allParts);

    index = 1;
    while(maxIteration>0)
        % Iterate all the parts, for each part iterate all processes
        [allParts,data] = iterateParts(allParts,CONST,data,index);
        maxIteration = maxIteration - 1;
        
        index = index + 1;
    end
end

