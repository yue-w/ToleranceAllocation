    function [allParts,data] = iterateParts(allParts,CONST,data,index,METHOD)
%{
This function do one step of iteration. Iterate each part. For each part,
iterate through all possible processes.

%}
    allPartsCopy = allParts;
    num_parts = length(allPartsCopy);   
    
    for i = 1:num_parts

        %Iterate processes
        switch METHOD
            case CONST.METHOD.BOUND
                [allPartsCopy,data] = iterateProcessesbound(allPartsCopy, i ,CONST,data);
            case CONST.METHOD.SIGMA
                [allPartsCopy,data] = iterateProcessessigma(allPartsCopy, i ,CONST,data);
            case CONST.METHOD.CLUTCH
                [allPartsCopy,data] = iterateProcessessigma(allPartsCopy, i ,CONST,data);
        end       
        data.max_pt(num_parts*(index-1)+i+1) = data.max;
        
        data.num_products_pt(num_parts*(index-1)+i+1) = data.num_products;
    end
    data.max_it(index+1) = data.max;
    data.num_products_it(index+1) = data.num_products;
    
    for parts_index = 1:num_parts
        data.num_prts(parts_index,index+1) = allParts(parts_index).totalNum;
        
        data.tol(parts_index,index+1) = allParts(parts_index).tol;
    end
allParts = allPartsCopy;
end