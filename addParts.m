function [parts,num_part_added] = addParts(dimensions,thisPart,thisProcessIndex, designDim,sigma, tol, BATCH,numAdded)
%This function check whether the dimension of the parts falls within the
%allocated tolerance to this part. If the part fall outside the tolerance
%band, trash it and make a new one. Make sure that the number of parts prod
%that satisfy dimension requirement = BATCH

    lengthParts = length(dimensions);
    LS = designDim - tol;
    
    US = designDim + tol;
    partsInBounds = dimensions(dimensions>=LS & dimensions<=US);
    numOutside = lengthParts - length(partsInBounds);    
    numAdded = numAdded + numOutside;
    
    if numOutside == 0
        parts = partsInBounds;
        num_part_added = numAdded;
    else
        mu = thisPart.processes(thisProcessIndex).Xbar;
        addedParts = normrnd(mu,sigma,[1,numOutside]);
        [tem,num_part_added]=addParts(addedParts,thisPart,thisProcessIndex, designDim,sigma, tol, BATCH,numAdded);
        
        parts = [partsInBounds tem];
    end
    
end