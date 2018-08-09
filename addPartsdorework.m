function [parts,num_part_added, num_part_reworked]=addPartsdorework(dimensions,...
                                                thisPart,...
                                                thisProcessIndex,...
                                                designDim,...
                                                sigma, tol, BATCH, numAdded, numRework)
%{
This function use recursion to add parts. 
The dimension of reworked parts follow a truncated normal distribution.
num_part_added: new parts that are machined because of craping (Dimension smaller than LS)
num_part_reworked: parts that are reowrked (the dimension are larger
than US.)
%}
                                                
    lengthParts = length(dimensions);
    LS = designDim - tol;
    US = designDim + tol;
    %siftNotSmall = dimensions>=LS;
    partsNotSmall = dimensions(dimensions>=LS);
    %partsSmall = dimensions(~siftNotSmall);
    partsinRange = partsNotSmall(partsNotSmall<US);
    %partsLarge = partsNotSmall(partsNotSmall>US);
    lengthPartsNotSmall = length(partsNotSmall);
    num_partsLarge = lengthPartsNotSmall - length(partsinRange);
    numRework = numRework + num_partsLarge;
    
    numSmall = lengthParts -lengthPartsNotSmall;
    
    numAdded = numAdded + numSmall;
    mu = thisPart.processes(thisProcessIndex).Xbar;
    
      %Assume the reworked part follows a Truncated Normal Distribution
    ratio = 3;
    pd = makedist('Normal','mu',mu,'sigma',sigma/ratio);
    truncateNormal = truncate(pd,LS,US);
    reworkedParts =  random(truncateNormal,1,num_partsLarge); 

%       %Assume the reworked parts have 0 deviation
%     reworkedParts =  normrnd(mu,0,[1,num_partsLarge]); 
    
    partsinRange = [partsinRange reworkedParts];
    
    if numSmall == 0
        parts = partsinRange;
        num_part_added = numAdded;
        num_part_reworked = numRework;
        
    else     
        mu = thisPart.processes(thisProcessIndex).Xbar;
        addedParts = normrnd(mu,sigma,[1,numSmall]);
        [tem,num_part_added,num_part_reworked] = addPartsdorework(addedParts,...
                                                thisPart,...
                                                thisProcessIndex,...
                                                designDim,...
                                                sigma, tol, BATCH, numAdded,numRework);
        parts = [partsinRange tem];
    end
end