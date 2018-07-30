% This program use dynamic programming to allocate tolerance to different machining processes.

%Max iteration number
maxIteration = 15;
BOUND = 1;
SIGMA = 2;
CONSTMETHOD.BOUND = BOUND;
CONSTMETHOD.SIGMA = SIGMA;

METHOD = BOUND;
%Define Parts and some constant
switch METHOD
    case BOUND
        [allParts, CONST, data] = initialize(maxIteration,CONSTMETHOD);
    case SIGMA
        [allParts, CONST, data] = initializechangesigma(maxIteration,CONSTMETHOD);
end
[allParts,data] = doValueIteration(allParts, maxIteration,CONST,data,METHOD);

