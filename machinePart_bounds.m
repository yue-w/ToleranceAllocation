function part = machinePart_bounds(thisPart, thisProcessIndex, tol, CONST)

    designDim = thisPart.dim;
    %????
    %sigma = (thisPart.processes(thisProcessIndex).lb + thisPart.processes(thisProcessIndex).ub)/2;
    sigma = thisPart.processes(thisProcessIndex).Sdev;
    dimensions = normrnd(thisPart.processes(thisProcessIndex).Xbar, sigma, [1,CONST.BACH]);
    
    %num_part_added is the number of part needed to be machined to replace the parts falls
    %out side the tolerance bounds
    [dimensions,num_part_added] = addParts(dimensions,thisPart,thisProcessIndex, designDim,sigma, tol, CONST.BACH);
    thisPart.totalNum = CONST.BACH + num_part_added;
    part = thisPart;
    part.dimensions = dimensions;
end