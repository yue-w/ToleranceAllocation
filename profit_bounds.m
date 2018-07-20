function profit = profit_bounds(allParts, thisPart,thisPartIndex, thisProcessIndex,CONST)
%{
This function compute the total cost of given tolerance.
The cost for different processes are different. 
For a given process, the machining costs for different tolerances are the
same. As the given tolerance act as limits to truncate the distribution of
machined product (parts out of boundary will be abandoned or repaired with 
a given cost), so, differnet tolerance corresponding to different total cost
(maching cost plus other costs).
%}

    machiningCost = computeMachiningCost_bounds(allParts,thisPart, thisPartIndex,thisProcessIndex);
         
    productProfit = computeProductsProfit(allParts, thisPart,thisPartIndex,CONST);   
    
    profit =  productProfit - machiningCost;
end