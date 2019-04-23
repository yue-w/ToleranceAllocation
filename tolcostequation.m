function cost = tolcostequation(CONST,tol)
    if CONST.c==0 && CONST.d==0
        cost = CONST.a + CONST.b/tol;
    else 
        sigma = tol/3;
        cost = CONST.a + CONST.b*sqrt(CONST.d)/sqrt(sigma-CONST.c);
    end
    
end