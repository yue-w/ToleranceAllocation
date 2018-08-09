function [parts,num_part_reworked]=addPartsreworktwoside(dimensions,...
                                                thisPart,...
                                                thisProcessIndex,...
                                                designDim,...
                                                sigma, tol, BATCH, ~, ~)

%{
This function find parts outside both the upper and lower bounds and add reworked parts .
%}
                                                
    LS = designDim - tol;
    US = designDim + tol;
    partsInBounds = dimensions(dimensions>=LS & dimensions<=US);
    num_part_reworked = BATCH - length(partsInBounds);
    mu = thisPart.processes(thisProcessIndex).Xbar;
    
    %Assume the reworked part follows a Truncated Normal Distribution
    ratio = 3;
    pd = makedist('Normal','mu',mu,'sigma',sigma/ratio);
    truncateNormal = truncate(pd,LS,US);
    reworkedParts =  random(truncateNormal,1,num_part_reworked); 
    
%       %Assume the reworked parts have 0 deviation
%     reworkedParts =  normrnd(mu,0,[1,num_part_reworked]); 
    
    parts = [partsInBounds reworkedParts];
   
end