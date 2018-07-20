function [parts,num_part_added] = addParts(parts,thisPart,thisProcessIndex, designDim, tol, BATCH)
%This function check whether the dimension of the parts falls within the
%allocated tolerance to this part. If the part fall outside the tolerance
%band, trash it and make a new one. Make sure that the number of parts prod
%that satisfy dimension requirement = BATCH

    %Use symmetric tolerance.
    parts = parts( (parts >= (designDim - tol)) & (parts <= (designDim + tol)));
    num_part_added = 0;
    gap= BATCH - length(parts);  
    while(gap>0)
        num_part_added = num_part_added + gap;
        addedParts = normrnd(thisPart.processes(thisProcessIndex).Xbar, thisPart.processes(thisProcessIndex).Sdev, [1,gap]);
        addedParts = addedParts(addedParts>=designDim - tol & addedParts <= designDim + tol);
        parts = [parts, addedParts];
        gap = BATCH - length(parts);
    end
    
end