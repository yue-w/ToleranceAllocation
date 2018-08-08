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
TAGUCH_K = 0;
REWORK = 0;

tol1 = 0.25;
tol2 = 0.2508;

tol3 = 0.1964;
tol4 = 0.2764;

CONST = initCONST(BACH,PRICE,DIM,LLIM,ULIM,STEP,TAGUCH_K,KSIGMA,CONSTMETHOD,REWORK);

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

%Part 1
CST.a = 3.5;
CST.b = 0.75;
Sdev_pt1 =tol1 / KSIGMA;
machiningConst1 =  tolcostequation(CST,tol1); 
reworkingConst = reworkcostR*machiningConst1;
ub = 0.464;     
lb = ub/20;
part1_process = setprocesses(lb, ub, CST.a, CST.b, c, d,machiningConst1,reworkingConst,part1_dim,Sdev_pt1);
part1 = init_one_Part(part1_process, tol1, part1_dim, init_processIndex);

%Part 2
CST.a = 3.0;
CST.b = 0.65;
Sdev_pt2 =tol2/KSIGMA;
machiningConst2 =  tolcostequation(CST,tol2); 
reworkingConst = reworkcostR*machiningConst2;
ub = 0.5616;     
lb = ub/20;
part2_process = setprocesses(lb, ub, CST.a, CST.b, c, d,machiningConst2,reworkingConst,part2_dim,Sdev_pt2);
part2 = init_one_Part(part2_process, tol2, part2_dim, init_processIndex);

%Part 3
CST.a = 2.5;
CST.b = 0.3;
Sdev_pt3 =tol3/KSIGMA;
machiningConst3 =  tolcostequation(CST,tol3); 
reworkingConst = reworkcostR*machiningConst3;
ub = 0.3688;     
lb = ub/20;
part3_process = setprocesses(lb, ub, CST.a, CST.b, c, d,machiningConst3,reworkingConst,part3_dim,Sdev_pt3);
part3 = init_one_Part(part3_process, tol3, part3_dim, init_processIndex);

%Part 4
CST.a = 0.5;
CST.b = 0.88;
Sdev_pt4 =tol4/KSIGMA;
machiningConst4 =  tolcostequation(CST,tol4); 
reworkingConst = reworkcostR*machiningConst4;
ub = 0.5576;     
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
[maxProfit,num_products] = currenttotalprofit(allParts,CONST);

data = setData(maxProfit, maxIteration,num_part,num_products,allParts);


end