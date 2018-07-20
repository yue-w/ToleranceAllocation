function allParts = iterateParts(allParts,CONST)
%{
This function do one step of iteration. Iterate each part. For each part,
iterate through all possible processes.

%}
    allPartsCopy = allParts;
    num_parts = length(allPartsCopy);   
    
    for i = 1:num_parts

        %Iterate processes
        allPartsCopy = iterateProcesses(allParts, i ,CONST);
%         %lower bound of the tolerance
%         lb = allPartsCopy(i).
    end
    
    
    
allParts = allPartsCopy;
end