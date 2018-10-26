function [unitCost,num_products,taguchiLost] = computeUnitCost(allParts, thisPart, thisPartIndex, thisProcessIndex,CONST)
%{
This function compute the unit cost of each product of current tollerance allocation
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
    products = productDims(productDims>=CONST.LTOL & productDims<= CONST.UTOL);
    num_products = length(products);   
    
    machiningCost = computeMachiningCost(allParts,thisPart, thisPartIndex,thisProcessIndex,CONST);
    %Taguchi lost
    taguchiLost = computeTaguchiLost(productDims, CONST); 
    
    totalCost = machiningCost + taguchiLost;
    
    unitCost = totalCost/num_products;

end