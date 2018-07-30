function [profit,num_products] = profit(allParts, thisPart,thisPartIndex, thisProcessIndex,productDim,CONST)
%{
This function compute the total cost of given tolerance.
The cost for different processes are different. 
For a given process, the machining costs for different tolerances are the
same. As the given tolerance act as limits to truncate the distribution of
machined product (parts out of boundary will be abandoned or repaired with 
a given cost), so, differnet tolerance corresponding to different total cost
(maching cost plus other costs).
%}

    machiningCost = computeMachiningCost(allParts,thisPart, thisPartIndex,thisProcessIndex);
         
    [productProfit,num_products] = computeProductsProfit(productDim,CONST);   
    
    profit =  productProfit - machiningCost;
end