%Compare the total profit of two methods

%Old method
num_part = 4;
%num_processes = 3;
part1_dim = 55.29;
part2_dim = 22.86;
part3_dim = 22.86;
part4_dim = 101.69;
KSIGMA = 3;
BACH = 10000; 

DIM = 0.122;
LLIM =0.087 ;% 0.122-0.035 (rad)
ULIM =0.157 ;% = 0.122+0.035 (rad)

PRICE = 50;
TAGUCH_K = 0;
REWORK = 0;
STEP = 0.02 / 50;
CONST = initCONST(BACH,PRICE,DIM,LLIM,ULIM,STEP,TAGUCH_K,KSIGMA,2,REWORK);

init_processIndex1 = 3;
init_processIndex2 = 2;
init_processIndex3 = 1;
init_processIndex4 = 3;
init_processIndex = [init_processIndex1 init_processIndex2 init_processIndex3 init_processIndex4];
%Part 1
a = [10 5 3.5];
b = [0.015 0.5 0.75];
Sdev_pt1 = [0.015/KSIGMA 0.08/KSIGMA; 0.06/KSIGMA 0.15/KSIGMA; 0.12/KSIGMA 0.25/KSIGMA];

tol1 = 0.179806;
init_sigma1 = tol1/KSIGMA;
part1 = part(a,b,part1_dim,Sdev_pt1,init_sigma1,tol1,init_processIndex1);
%US
tol1US = 0.2464;
init_sigma1US = tol1/KSIGMA;
part1US = part(a,b,part1_dim,Sdev_pt1,init_sigma1US,tol1US,init_processIndex1);

%Part 2
a = [8 3];
b = [0.25 0.65];
Sdev_pt2 = [0.02/KSIGMA 0.15/KSIGMA; 0.08/KSIGMA 0.3/KSIGMA];
tol2 =0.165358;
init_sigma2 = tol2/KSIGMA;
part2 = part(a,b,part2_dim,Sdev_pt2,init_sigma2,tol2,init_processIndex2);
%US
tol2US =0.2640;
init_sigma2US = tol2/KSIGMA;
part2US = part(a,b,part2_dim,Sdev_pt2,init_sigma2US,tol2US,init_processIndex2);

%Part 3
a = [2.5 5];
b = [0.3 0.045];
Sdev_pt3 = [0.04/KSIGMA 0.2/KSIGMA; 0.12/KSIGMA 0.25/KSIGMA];
tol3 = 0.120132;
init_sigma3 = tol3/KSIGMA;
part3 = part(a,b,part3_dim,Sdev_pt3,init_sigma3,tol3,init_processIndex3);
%US
tol3US = 0.1844;
init_sigma3US = tol3US/KSIGMA;
part3US = part(a,b,part3_dim,Sdev_pt3,init_sigma3US,tol3US,init_processIndex3);

%Part 4
a = [4 6 0.5];
b = [0.56 0.16 0.88];
Sdev_pt4 = [0.08/KSIGMA 0.12/KSIGMA; 0.15/KSIGMA 0.25/KSIGMA; 0.2/KSIGMA 0.4/KSIGMA];
tol4 =0.200581;
init_sigma4 = tol4/KSIGMA;
part4 = part(a,b,part4_dim,Sdev_pt4,init_sigma4,tol4,init_processIndex4);
%US
tol4US =0.2776;
init_sigma4US = tol4US/KSIGMA;
part4US = part(a,b,part4_dim,Sdev_pt4,init_sigma4US,tol4US,init_processIndex4);

%Initialize some dimensions that will be used in computing cost%Init process index
part1 = machinePart(part1, init_processIndex1, init_sigma1,tol1,CONST);
part2 = machinePart(part2, init_processIndex2, init_sigma2,tol2,CONST);
part3 = machinePart(part3, init_processIndex3, init_sigma3,tol3,CONST);
part4 = machinePart(part4, init_processIndex4, init_sigma4,tol4,CONST);

allParts(1) = part1;
allParts(2) = part2;
allParts(3) = part3;
allParts(4) = part4;

init_tol = [tol1 tol2 tol3 tol4];
allParts = initsigmacost(allParts,init_tol,init_processIndex );

%the total profit of the initialized state.
[maxProfit,num_products] = currenttotalprofit(allParts,CONST);

%Our method
part1US = machinePart(part1US, init_processIndex1, init_sigma1US,tol1US,CONST);
part2US = machinePart(part2US, init_processIndex2, init_sigma2US,tol2US,CONST);
part3US = machinePart(part3US, init_processIndex3, init_sigma3US,tol3US,CONST);
part4US = machinePart(part4US, init_processIndex4, init_sigma4US,tol4US,CONST);

allPartsUS(1) = part1US;
allPartsUS(2) = part2US;
allPartsUS(3) = part3US;
allPartsUS(4) = part4US;

init_tolUS = [tol1US tol2US tol3US tol4US];
allPartsUS = initsigmacost(allPartsUS,init_tolUS,init_processIndex );


[maxProfitUS,num_productsUS] = currenttotalprofit(allPartsUS,CONST);
