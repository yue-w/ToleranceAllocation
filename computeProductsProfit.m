function productsProfit= computeProductsProfit(allParts, thisPart,thisPartIndex,CONST)
%Calculate the total profit of assembled products from the parts

    numParts = length(allParts);        
    partDims = zeros(numParts,CONST.BACH);

    for i = 1:numParts
        if i ~= thisPartIndex
            part = allParts(i);
           
        else
            part = thisPart;
        end
        dims = part.dimensions;
        %Shuffle the dimensions of the products
        partDims(i,:) = dims(randperm(CONST.BACH));
    end
    
    productDim = assemble(partDims);

    productDimInTol = productDim(productDim>=CONST.LTOL & productDim<= CONST.UTOL);
    
    productsProfit = length(productDimInTol) * CONST.PRICE;
end