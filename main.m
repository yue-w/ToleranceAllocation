% This program use dynamic programming to allocate tolerance to different machining processes.

%Max iteration number
maxIteration = 20;
BOUND = 1;
SIGMA = 2;
CLUTCH =3;%The clutch example, tol=3*tol. optimize sigma.
CLUTCHK = 4;%The clutch example, Fix sigma, optimize the k in tol=sigma*K
CLUTCHRND = 5;%The clutch example, with random process and random tolerance
CLUTCHRWRK = 6;% Compare rework or not.
CONSTMETHOD.BOUND = BOUND;
CONSTMETHOD.SIGMA = SIGMA;
CONSTMETHOD.CLUTCH = CLUTCH;
CONSTMETHOD.CLUTCHK = CLUTCHK;
CONSTMETHOD.CLUTCHRND = CLUTCHRND;
CONSTMETHOD.CLUTCHRWRK = CLUTCHRWRK;
METHOD = CLUTCHK;

%Define Parts and some constant
switch METHOD
    case BOUND
        
        [allParts, CONST, data] = initialize(maxIteration,CONSTMETHOD);
    case SIGMA
        [allParts, CONST, data] = initializechangesigma(maxIteration,CONSTMETHOD);
    case CLUTCH
        [allParts, CONST, data] = clutch(maxIteration,CONSTMETHOD);
    case CLUTCHK
        [allParts, CONST, data] = clutchK(maxIteration,CONSTMETHOD);  
    case CLUTCHRND
        [allParts, CONST, data] = clutchrnd(maxIteration,CONSTMETHOD);  
    case CLUTCHRWRK
        [allParts, CONST, data] = clutchrwrkinit(maxIteration,CONSTMETHOD,METHOD);
        return
end

[allParts,data] = doValueIteration(allParts, maxIteration,CONST,data,METHOD);

