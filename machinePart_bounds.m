function part = machinePart_bounds(thisPart, thisProcessIndex, tol, CONST)

    designDim = thisPart.dim;
    %????
    %sigma = (thisPart.processes(thisProcessIndex).lb + thisPart.processes(thisProcessIndex).ub)/2;
    sigma = thisPart.processes(thisProcessIndex).Sdev;
    dimensions = normrnd(thisPart.processes(thisProcessIndex).Xbar, sigma, [1,CONST.BACH]);
    
    %num_part_added is the number of part needed to be machined to replace the parts falls
    %out side the tolerance bounds
    numAdded = 0;    
    numRework = 0;
    if CONST.REWORK == 1
        [dimensions,num_part_added,num_part_reworked] = addPartsdorework(dimensions,...
                                                    thisPart,...
                                                    thisProcessIndex,...
                                                    designDim,...
                                                    sigma, tol, CONST.BACH, numAdded,numRework);        
   
        thisPart.totalNum = CONST.BACH + num_part_added;
        thisPart.reworkNum = thisPart.reworkNum + num_part_reworked;
   
    else
        [dimensions,num_part_added] = addParts(dimensions,thisPart,thisProcessIndex, designDim,sigma, tol, CONST.BACH,numAdded);
        thisPart.totalNum = CONST.BACH + num_part_added;
    end
    part = thisPart;
    part.dimensions = dimensions;
end