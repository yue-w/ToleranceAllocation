function [allParts, CONST,data]= clutchK(maxIteration,CONSTMETHOD)
num_part = 4;

part1_dim = 55.29;
part2_dim = 22.86;
part3_dim = 22.86;
part4_dim = 101.69;
KSIGMA = 3;
BACH = 10000;
DIM = 0.122;
LLIM =0.087 ;% 0.122-0.035 (rad)
ULIM =0.157 ;% = 0.122+0.035 (rad)
TOL = 0.035;
%Iterate step for the tolerance
STEP = TOL / 100;

PRICE = 50;

A = 100;
TAGUCH_K = A/(0.035^2);


    if A == 0    
        sigma1 = 0.083033333;
        sigma2 = 0.0964;
        sigma3 = 0.063966667;
        sigma4 = 0.128533333;   
    elseif A==20    
        sigma1 = 0.083033333;
        sigma2 = 0.0781;
        sigma3 = 0.056166667;
        sigma4 = 0.089533333;   

    elseif A==100
        sigma1 = 0.0497;
        sigma2 = 0.0499;
        sigma3 = 0.043866667;
        sigma4 = 0.067333333;   
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
    SCRAP.RATIO = 0;
    SCRAP.PSC = 0;%CSP is product scrap cost
else
    SCRAP.RATIO = 0.1;
    SCRAP.PSC = 1.5;
end
CONST.SCRAP = SCRAP;

reworkcostR = 0.3;
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
limitRatio = 6;
%Part 1
%If A = 100, the process for the first part is 2, other wise, it is 3
if A~=100
    CST.a = 3.5;
    CST.b = 0.75;  
else
    CST.a = 5.0;
    CST.b = 0.5;  
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
CST.a = 3.0;
CST.b = 0.65;
Sdev_pt2 =sigma2;
tol2 = Sdev_pt2*KSIGMA;
machiningConst2 =  tolcostequation(CST,tol2); 
reworkingConst = reworkcostR*machiningConst2;
ub = limitRatio*Sdev_pt2;     
lb = ub/20;
part2_process = setprocesses(lb, ub, CST.a, CST.b, c, d,machiningConst2,reworkingConst,part2_dim,Sdev_pt2);
part2 = init_one_Part(part2_process, tol2, part2_dim, init_processIndex);

%Part 3
CST.a = 2.5;
CST.b = 0.3;
Sdev_pt3 =sigma3;
tol3 = Sdev_pt3*KSIGMA;
machiningConst3 =  tolcostequation(CST,tol3); 
reworkingConst = reworkcostR*machiningConst3;
ub = limitRatio*Sdev_pt3;     
lb = ub/20;
part3_process = setprocesses(lb, ub, CST.a, CST.b, c, d,machiningConst3,reworkingConst,part3_dim,Sdev_pt3);
part3 = init_one_Part(part3_process, tol3, part3_dim, init_processIndex);

%Part 4
CST.a = 0.5;
CST.b = 0.88;
Sdev_pt4 =sigma4;
tol4 = Sdev_pt4*KSIGMA;
machiningConst4 =  tolcostequation(CST,tol4); 
reworkingConst = reworkcostR*machiningConst4;
ub = limitRatio*Sdev_pt4;     
lb = ub/20;
part4_process = setprocesses(lb, ub, CST.a, CST.b, c, d,machiningConst4,reworkingConst,part4_dim,Sdev_pt4);
part4 = init_one_Part(part4_process, tol4, part4_dim, init_processIndex);

%Initialize some dimensions that will be used in computing cost
part1 = machinePart(part1, 1,part1_process.Sdev, part1.tol, CONST);
part2 = machinePart(part2, 1,part2_process.Sdev, part2.tol, CONST);
part3 = machinePart(part3, 1,part3_process.Sdev,part3.tol, CONST);
part4 = machinePart(part4, 1,part4_process.Sdev,part4.tol, CONST);

allParts(1) = part1;
allParts(2) = part2;
allParts(3) = part3;
allParts(4) = part4;
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