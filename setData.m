function data = setData(maxProfit,maxIteration,num_part,num_products,allParts)
    data.max = maxProfit;
    %Store max profit when iterate each part
    data.max_pt = zeros(1,maxIteration*num_part+1);
    data.max_pt(1) = data.max;
    %Store max profit of each iteration
    data.max_it = zeros(1,maxIteration+1);
    data.max_it(1) = data.max;

    %Store the number of products falls into the tolerance range
    %Store it when iterate each part
    data.num_products_pt = zeros(1,maxIteration*num_part+1);
    data.num_products_pt(1) =num_products; 
    %Store it for each iteration
    data.num_products_it= zeros(1,maxIteration+1);
    data.num_products_it(1) =num_products; 

    %Store the number of parts machined so that there are BACH parts falls into
    %allocated tolerance.
    
    %Store value for each iteration
    data.num_prts= zeros(num_part,maxIteration+1);
    
    for index = 1:num_part
        data.num_prts(index,1) = allParts(index).totalNum;
    end
end