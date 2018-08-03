%  %linspace (BASE, LIMIT, N)
 function [return_A, return_numAdd,return_numRework] = test2(A,numAdded,numRework)
    %A = randi([1,10],1,10);
    %less = A(A<=3);
    notLess = A(A>=4);
    large = notLess(notLess>=8);
    inRange = notLess(notLess<8);
    numLarge = length(large);
    numLess = length(A)-length(notLess);
    numAdded = numAdded + numLess;
    numRework = numRework + numLarge;
    
    %Add reworkded parts
    reworkedParts = zeros(1,numLarge);
    inRange = [inRange reworkedParts];
    
    if numLess==0
        return_A = inRange;
        return_numAdd = numAdded;
        return_numRework = numRework;
    else       
        addedParts = randi([1,10],1,numLess);
        [tem,return_numAdd,return_numRework]  = test2(addedParts,numAdded,numRework);
        return_A = [inRange tem];
    end
 end

% A = randi([1,10],1,10);
% large = A>5;
% ALarge = A(large);
% 
% ASmall = A(~large);