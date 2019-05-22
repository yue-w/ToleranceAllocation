function [allParts, CONST,data]= clutchRateK(maxIteration,CONSTMETHOD)
num_part = 3;
%num_processes = 3;
part1_dim = 55.291;
part2_dim = 22.86;
part3_dim = 101.6;
KSIGMA = 3;
BACH = 10000; 
DIM = 0.12238946846685038;
LLIM =0.08738946846685038 ;% 0.122-0.035 (rad)
ULIM =0.15738946846685037 ;% = 0.122+0.035 (rad)
TOL = 0.035;
%Iterate step for the tolerance
STEP = TOL / 50;

PRICE = 50;

A = 0;
TAGUCH_K = A/(0.035^2);
    if A == 0    
        sigma1 = 0.043333;
        
        sigma2 = 0.09;
        sigma3 = 0.11;
  
    elseif A==20    
        sigma1 = 0.083033333;
        sigma2 = 0.0781;
        sigma3 = 0.056166667;  

    elseif A==100
        sigma1 = 0.0497;
        sigma2 = 0.0499;
        sigma3 = 0.043866667;  
    end
    
%%For A=100
% sigma1 = 0.0461;
% sigma2 = 0.0535;
% sigma3 = 0.039667;
% sigma4 = 0.068533;

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
    SCRAP.RATIO = 0;%the ratio of scrap cost to Ai for the ith component
    SCRAP.PSC = 0;%CSP is product scrap cost
else
    SCRAP.RATIO = 0.1;%the ratio of scrap cost to Ai for the ith component
    SCRAP.PSC = 0.612;%CSP is product scrap cost
end
CONST.SCRAP = SCRAP;

reworkcostR = 0;
%lb, ub are the searching area for the tolerance of processes. Set it to the tolerance
%of the product.

a = 0; b = 0; c = 0; d = 0;
init_processIndex = 1;

% %Init process index
% init_processIndex1 = 3;
% init_processIndex2 = 2;
% init_processIndex3 = 1;
% init_processIndex4 = 3;

%optsigma = [0.2464 0.2640 0.1844 0.2776];
limitRatio = 8;
%Part 1
%If A = 100, the process for the first part is 2, other wise, it is 3
if A~=100
    CST.a = 0.87; %5.0;
    CST.b = 2.062; %20;
    CST.c = 0;
    CST.d = 0.001798/3;
else
    CST.a = 0;
    CST.b = 0;  
end
Sdev_pt1 =sigma1;
tol1 = Sdev_pt1*KSIGMA;
machiningConst1 =  tolcostequation(CST,tol1); 
reworkingConst = reworkcostR*machiningConst1;
ub = limitRatio*Sdev_pt1;     
lb = ub/20;
part1_process = setprocesses(lb, ub, CST.a, CST.b, c, d,machiningConst1,reworkingConst,part1_dim,Sdev_pt1);
part1 = init_one_Part(part1_process, tol1, part1_dim, init_processIndex);

%Part 2
CST.a = 1.71; %3.0;
CST.b = 1.276; %36.7;
CST.c = 0;
CST.d = 0.001653/3;
Sdev_pt2 =sigma2;
tol2 = Sdev_pt2*KSIGMA;
machiningConst2 =  tolcostequation(CST,tol2); 
reworkingConst = reworkcostR*machiningConst2;
ub = limitRatio*Sdev_pt2;     
lb = ub/20;
part2_process = setprocesses(lb, ub, CST.a, CST.b, c, d,machiningConst2,reworkingConst,part2_dim,Sdev_pt2);
part2 = init_one_Part(part2_process, tol2, part2_dim, init_processIndex);

%Part 3
CST.a = 3.54; %1.0;
CST.b = 1.965; % 36.0;
CST.c = 0;
CST.d = 0.002/3;
Sdev_pt3 =sigma3;
tol3 = Sdev_pt3*KSIGMA;
machiningConst3 =  tolcostequation(CST,tol3); 
reworkingConst = reworkcostR*machiningConst3;
ub = limitRatio*Sdev_pt3;     
lb = ub/20;
part3_process = setprocesses(lb, ub, CST.a, CST.b, c, d,machiningConst3,reworkingConst,part3_dim,Sdev_pt3);
part3 = init_one_Part(part3_process, tol3, part3_dim, init_processIndex);



%Initialize some dimensions that will be used in computing cost
part1 = machinePart(part1, 1,part1_process.Sdev, part1.tol, CONST);
part2 = machinePart(part2, 1,part2_process.Sdev, part2.tol, CONST);
part3 = machinePart(part3, 1,part3_process.Sdev,part3.tol, CONST);


allParts(1) = part1;
allParts(2) = part2;
allParts(3) = part3;

%the total profit of the initialized state.


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

data = setData(metric, maxIteration,num_part,num_products,allParts,TaguchiLoss);


end