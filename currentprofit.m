function [productprofit,num_products] = currentprofit(allParts,productDim, CONST)

    machiningCost = currentachiningcost(allParts,CONST);
         
    [productProfit,num_products] = computeProductsProfit(productDim,CONST);   
    
    productprofit =  productProfit - machiningCost;
end