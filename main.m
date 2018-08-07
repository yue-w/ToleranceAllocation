% This program use dynamic programming to allocate tolerance to different machining processes.

%Max iteration number
maxIteration = 10;
BOUND = 1;
SIGMA = 2;
CLUTCH =3;
CONSTMETHOD.BOUND = BOUND;
CONSTMETHOD.SIGMA = SIGMA;
CONSTMETHOD.CLUTCH = CLUTCH;

METHOD = CLUTCH;
%Define Parts and some constant
switch METHOD
    case BOUND
        [allParts, CONST, data] = initialize(maxIteration,CONSTMETHOD);
    case SIGMA
        [allParts, CONST, data] = initializechangesigma(maxIteration,CONSTMETHOD);
    case CLUTCH
        [allParts, CONST, data] = clutch(maxIteration,CONSTMETHOD);
end

[allParts,data] = doValueIteration(allParts, maxIteration,CONST,data,METHOD);

