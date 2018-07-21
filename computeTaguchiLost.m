function taguchiCost = computeTaguchiLost(productDims, CONST)

    dev = productDims - CONST.DIM;
    
    
    taguchiCost = CONST.TAGUCH_K * sum(power(dev,2));
end