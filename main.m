% This program use dynamic programming to allocate tolerance to different machining processes.

%Max iteration number
maxIteration = 10;

%Define Parts and some constant
[allParts, CONST] = initialize();

doValueIteration(allParts, maxIteration,CONST)

