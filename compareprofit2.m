%Compare the total profit of two methods
BOUND = 1;
SIGMA = 2;
CLUTCH =3;%The clutch example, tol=3*tol. optimize sigma.
CLUTCHK = 4;%The clutch example, Fix sigma, optimize the k in tol=sigma*K
CONSTMETHOD.BOUND = BOUND;
CONSTMETHOD.SIGMA = SIGMA;
CONSTMETHOD.CLUTCH = CLUTCH;
CONSTMETHOD.CLUTCHK = CLUTCHK;
%Old method
num_part = 4;
%num_processes = 3;
part1_dim = 55.29;
part2_dim = 22.86;
part3_dim = 22.86;
part4_dim = 101.69;
KSIGMA = 3;
BACH = 10000; 

%The cost ratio of machining a new part and reworking it.
reworkcostR = 0.3;
reworkcostvec = reworkcostR*[7.7 6.9 5.0 4.89];

DIM = 0.122;
LLIM =0.087 ;% 0.122-0.035 (rad)
ULIM =0.157 ;% = 0.122+0.035 (rad)

PRICE = 50;

A = 100;
TAGUCH_K = A/(0.035^2);

STEP = 0.02 / 50;
REWORKSIGN.ADDPART = 0;%Do not do rework
REWORKSIGN.ONESIDEREWORK = 1;%Do one side rework (Rework Larg part)
REWORKSIGN.TWOSIDEREWORK = 2;%Two sides rework
REWORK.FLAG = REWORKSIGN;
REWORK.V = 0;%set the value.

%Whether inspect each components
INSPECT = 1;
%Whether to use benefit or unit cost as the metric. 0 is profit, 1 is unit
%cost.
METRIC = 1;
CONST = initCONST(BACH,PRICE,DIM,LLIM,ULIM,STEP,TAGUCH_K,KSIGMA,CONSTMETHOD,REWORK,INSPECT,METRIC);

SCRAP.FLAG = 1;
if  SCRAP.FLAG == 0
    SCRAP.RATIO = 0;
    SCRAP.PSC = 0;%CSP is product scrap cost
else
    SCRAP.RATIO = 0.1;
    SCRAP.PSC = 1.5;
end
CONST.SCRAP = SCRAP;

init_processIndex1 = 3;
init_processIndex2 = 2;
init_processIndex3 = 1;
init_processIndex4 = 3;

%Result of Choi's method
if A ==0
    tol1 = 0.179806;
    tol2 = 0.165358;
    tol3 = 0.120132;
    tol4 =0.200581;
    tol1US = 0.25;
    tol2US =0.2508;%To be modified
    tol3US = 0.1964;%To be modified
    tol4US =0.2764;%To be modified
elseif A==20
    tol1 = 0.173871;
    tol2 = 0.166246;
    tol3 = 0.128388;
    tol4 = 0.2; 
    tol1US = 0.25;%To be modified
    tol2US =0.2508;%To be modified
    tol3US = 0.1964;%To be modified
    tol4US =0.2764;%To be modified
elseif A==100
    tol1 = 0.136677;
    tol2 = 0.149551;
    tol3 = 0.115581;
    tol4 =0.2; 
    tol1US = 0.25;%To be modified
    tol2US =0.2508;%To be modified
    tol3US = 0.1964;%To be modified
    tol4US =0.2764;%To be modified
    init_processIndex1 = 2;
end
init_processIndex = [init_processIndex1 init_processIndex2 init_processIndex3 init_processIndex4];



%Part 1
a = [10 5 3.5];
b = [0.015 0.5 0.75];
Sdev_pt1 = [0.015/KSIGMA 0.08/KSIGMA; 0.06/KSIGMA 0.15/KSIGMA; 0.12/KSIGMA 0.25/KSIGMA];
%tol1 = 0.179806;
init_sigma1 = tol1/KSIGMA;
part1 = part(a,b,part1_dim,Sdev_pt1,init_sigma1,tol1,init_processIndex1);
%US
init_sigma1US = tol1US/KSIGMA;
part1US = part(a,b,part1_dim,Sdev_pt1,init_sigma1US,tol1US,init_processIndex1);

%Part 2
a = [8 3];
b = [0.25 0.65];
Sdev_pt2 = [0.02/KSIGMA 0.15/KSIGMA; 0.08/KSIGMA 0.3/KSIGMA];
%tol2 =0.165358;
init_sigma2 = tol2/KSIGMA;
part2 = part(a,b,part2_dim,Sdev_pt2,init_sigma2,tol2,init_processIndex2);
%US
init_sigma2US = tol2US/KSIGMA;
part2US = part(a,b,part2_dim,Sdev_pt2,init_sigma2US,tol2US,init_processIndex2);

%Part 3
a = [2.5 5];
b = [0.3 0.045];
Sdev_pt3 = [0.04/KSIGMA 0.2/KSIGMA; 0.12/KSIGMA 0.25/KSIGMA];
%tol3 = 0.120132;
init_sigma3 = tol3/KSIGMA;
part3 = part(a,b,part3_dim,Sdev_pt3,init_sigma3,tol3,init_processIndex3);
%US
init_sigma3US = tol3US/KSIGMA;
part3US = part(a,b,part3_dim,Sdev_pt3,init_sigma3US,tol3US,init_processIndex3);

%Part 4
a = [4 6 0.5];
b = [0.56 0.16 0.88];
Sdev_pt4 = [0.08/KSIGMA 0.12/KSIGMA; 0.15/KSIGMA 0.25/KSIGMA; 0.2/KSIGMA 0.4/KSIGMA];
%tol4 =0.200581;
init_sigma4 = tol4/KSIGMA;
part4 = part(a,b,part4_dim,Sdev_pt4,init_sigma4,tol4,init_processIndex4);
%US
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
allParts = inittolcost(allParts,init_tol,init_processIndex);
allParts = initreworkcost(allParts,init_processIndex,reworkcostvec);

switch CONST.METRIC
    case 0 % if benefit is used as the metric
        %the total profit of the initialized state.
        [maxProfit,num_products,TaguchiLoss] = computeTotalProfit(allParts,part1,0,0,CONST);
        metric = maxProfit;
    case 1 % if unit is used as the metric
        [unitCost,num_products,TaguchiLoss] = computeUnitCost(allParts, part1,0, 0, CONST); 
        %Put a negative here so that we can unify the
        %comparation to be the larger the better. (larger negative cost means lower positive cost, e.g. -1>-3)
        metric = -unitCost;
end
%[maxProfit,num_products] = currenttotalprofit(allParts,CONST);

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
allPartsUS = inittolcost(allPartsUS,init_tolUS,init_processIndex);
allPartsUS = initreworkcost(allPartsUS,init_processIndex,reworkcostvec);
switch CONST.METRIC
    case 0 % if benefit is used as the metric
        %the total profit of the initialized state.
        [maxProfit,num_products,TaguchiLoss] = computeTotalProfit(allPartsUS,part1,0,0,CONST);
        metric = maxProfit;
    case 1 % if unit is used as the metric
        [unitCost,num_products,TaguchiLoss] = computeUnitCost(allPartsUS, part1,0, 0, CONST); 
        %Put a negative here so that we can unify the
        %comparation to be the larger the better. (larger negative cost means lower positive cost, e.g. -1>-3)
        metric = -unitCost;
end
%[maxProfitUS,num_productsUS] = currenttotalprofit(allPartsUS,CONST);
