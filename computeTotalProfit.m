function [totalProfit,num_products] = computeTotalProfit(allParts, thisPart, thisPartIndex, thisProcessIndex,CONST)
%{
This function compute the total cost of current tollerance allocation
strategy. Different cost-tollerance models can be used by using different
execution functions.
IUPUT:
allParts - all the parts
thisPart - the part under iteration
thisProcess - the part under iteration
tol - tollerance allocated to this part in this process
CONST - some constant used in computation
%}
    %Compute the cost caused by repairing/abandon products that fall out
    %of given tolerance.
    
    productDims = assemble(allParts, thisPart,thisPartIndex,CONST);
    [profit,num_products] = profit_bounds(allParts, thisPart, thisPartIndex, thisProcessIndex,productDims, CONST);
    
    %Taguchi lost
    taguchiLost = computeTaguchiLost(productDims, CONST); 
    totalProfit = profit - taguchiLost;
end