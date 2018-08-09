function part = machinePart(thisPart, thisProcessIndex, sigma,tol, CONST)
    %tol = sigma*CONST.KSIGMA;
    %tol = thisPart.tol;
    designDim = thisPart.dim;

    dimensions = normrnd(thisPart.processes(thisProcessIndex).Xbar, sigma, [1,CONST.BACH]);
    
    %num_part_added is the number of part needed to be machined to replace the parts falls
    %out side the tolerance bounds
    numAdded = 0;
    numRework = 0;
%     if CONST.REWORK ~= 0
%         [dimensions,num_part_added,num_part_reworked] = addPartsdorework(dimensions,...
%                                                     thisPart,...
%                                                     thisProcessIndex,...
%                                                     designDim,...
%                                                     sigma, tol, CONST.BACH, numAdded,numRework);         
%         thisPart.machinedNum = CONST.BACH + num_part_added;
%         thisPart.reworkNum =num_part_reworked;
%     else
%         
%         [dimensions,num_part_added] = addParts(dimensions,thisPart,thisProcessIndex, designDim,sigma, tol, CONST.BACH,numAdded);
%         thisPart.machinedNum = CONST.BACH + num_part_added;   
%     end

    switch CONST.REWORK.V
        %Do not consider rewoerk.
        case CONST.REWORK.FLAG.ADDPART
            [dimensions,num_part_added] = addParts(dimensions,thisPart,thisProcessIndex, designDim,sigma, tol, CONST.BACH,numAdded);
            thisPart.machinedNum = CONST.BACH + num_part_added; 
            thisPart.reworkNum =0;  
        %One sided rework
        case CONST.REWORK.FLAG.ONESIDEREWORK
            [dimensions,num_part_added,num_part_reworked] = addPartsdorework(dimensions,...
                                                        thisPart,...
                                                        thisProcessIndex,...
                                                        designDim,...
                                                        sigma, tol, CONST.BACH, numAdded,numRework);         
            thisPart.machinedNum = CONST.BACH + num_part_added;
            thisPart.reworkNum =num_part_reworked;   
        %Two sided rework.    
        case CONST.REWORK.FLAG.TWOSIDEREWORK
            [dimensions,num_part_reworked] = addPartsreworktwoside(dimensions,...
                                                        thisPart,...
                                                        thisProcessIndex,...
                                                        designDim,...
                                                        sigma, tol, CONST.BACH, numAdded,numRework);         
            thisPart.machinedNum = CONST.BACH;
            thisPart.reworkNum =num_part_reworked;           
    end

    part = thisPart;   
    part.dimensions = dimensions;    
end