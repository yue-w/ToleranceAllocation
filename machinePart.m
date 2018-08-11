function part = machinePart(thisPart, thisProcessIndex, sigma,tol, CONST)
    %tol = sigma*CONST.KSIGMA;
    %tol = thisPart.tol;
    designDim = thisPart.dim;

    dimensions = normrnd(thisPart.processes(thisProcessIndex).Xbar, sigma, [1,CONST.BACH]);
    
    %num_part_added is the number of part needed to be machined to replace the parts falls
    %out side the tolerance bounds
    numAdded = 0;
    numRework = 0;

    if CONST.INSPECT == 1
        [dimensions,thisPart] = addPartscases(dimensions,thisPart,thisProcessIndex,...
            designDim,sigma, tol, CONST,numAdded,numRework);
    else
            thisPart.machinedNum = CONST.BACH;
            thisPart.reworkNum =0;      
    end

    part = thisPart;   
    part.dimensions = dimensions;    
end