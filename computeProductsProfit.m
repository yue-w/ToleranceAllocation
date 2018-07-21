function [productsProfit, num_products]= computeProductsProfit(productDim,CONST)
%Calculate the total profit of assembled products from the parts


    products = productDim(productDim>=CONST.LTOL & productDim<= CONST.UTOL);
    num_products = length(products);
    productsProfit = num_products * CONST.PRICE;
end