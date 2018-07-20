function part = machinePart_bounds(thisPart, thisProcessIndex, tol, CONST)

    designDim = thisPart.dim;
    dimensions = normrnd(thisPart.processes(thisProcessIndex).Xbar, thisPart.processes(thisProcessIndex).Sdev, [1,CONST.BACH]);
    
    %num_part_added is the number of part needed to be machined to replace the parts falls
    %out side the tolerance bounds
    [dimensions,num_part_added] = addParts(dimensions,thisPart,thisProcessIndex, designDim, tol, CONST.BACH);
    thisPart.totalNum = CONST.BACH + num_part_added;
    part = thisPart;
    part.dimensions = dimensions;
end