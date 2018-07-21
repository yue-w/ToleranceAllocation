function productDim = assemble(allParts, thisPart,thisPartIndex,CONST)
%{
Compute the dimension of the products randomly assembled by these parts.
Support nonlinear relationships
%}
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
    
    productDim = sum(partDims,1);
end