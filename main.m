% This program use dynamic programming to allocate tolerance to different machining processes.

%Max iteration number
maxIteration = 4;

%Define Parts and some constant
[allParts, CONST, data] = initialize(maxIteration);

[allParts,data] = doValueIteration(allParts, maxIteration,CONST,data);

