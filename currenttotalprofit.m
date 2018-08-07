function [totalProfit,num_products] = currenttotalprofit(allParts, CONST)
    %Compute the cost caused by repairing/abandon products that fall out
    %of given tolerance.

    productDims = currentassemble(allParts,CONST);
    [productprofit,num_products] = currentprofit(allParts,productDims, CONST);
    
    %Taguchi lost
    taguchiLost = computeTaguchiLost(productDims, CONST); 
    totalProfit = productprofit - taguchiLost;
end