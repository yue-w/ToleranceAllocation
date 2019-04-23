function productDim = currentassemble(allParts,CONST)
    numParts = length(allParts);        
    partDims = zeros(numParts,CONST.BACH);

    for i = 1:numParts
        part = allParts(i);
        dims = part.dimensions;
        %Shuffle the dimensions of the products
        partDims(i,:) = dims(randperm(CONST.BACH));
    end
    
    %productDim = sum(partDims,1);
    
%     tem = (partDims(2,:)+partDims(3,:))/2;
%     productDim = acos((partDims(1,:)+tem)./(partDims(4,:)-tem));
    productDim = assemblefunction(partDims);
end