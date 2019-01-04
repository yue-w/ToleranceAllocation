function [dimensions,part] = addPartscases(dimensions,thisPart,thisProcessIndex, designDim,sigma, tol, CONST,numAdded,numRework)
    switch CONST.REWORK.V
        %Do not consider rewoerk.
        case CONST.REWORK.FLAG.ADDPART
            [dimensions,num_part_added] = addParts(dimensions,thisPart,thisProcessIndex, designDim,sigma, tol, CONST.BACH,numAdded);
            thisPart.machinedNum = CONST.BACH + num_part_added; 
            %Number of parts needed to be scrapped
            thisPart.scrapNum = num_part_added;
            thisPart.reworkNum =0;  
        %One sided rework
        case CONST.REWORK.FLAG.ONESIDEREWORK
            [dimensions,num_part_added,num_part_reworked] = addPartsdorework(dimensions,...
                                                        thisPart,...
                                                        thisProcessIndex,...
                                                        designDim,...
                                                        sigma, tol, CONST.BACH, numAdded,numRework);         
            thisPart.machinedNum = CONST.BACH + num_part_added;
            %Number of parts needed to be scrapped
            thisPart.scrapNum = num_part_added;            
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
end