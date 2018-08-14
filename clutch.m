function [allParts, CONST,data]=clutch(maxIteration,CONSTMETHOD)
%{
Case study.
%}
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
A = 100;
TAGUCH_K = A/(0.035^2);
STEP = 0.015/50;


REWORKSIGN.ADDPART = 0;%Do not do rework
REWORKSIGN.ONESIDEREWORK = 1;%Do one side rework (Rework Larg part)
REWORKSIGN.TWOSIDEREWORK = 2;%Two sides rework
REWORK.FLAG = REWORKSIGN;
REWORK.V = 0;%set the value.

%Whether inspect each components
INSPECT = 1;

CONST = initCONST(BACH,PRICE,DIM,LLIM,ULIM,STEP,TAGUCH_K,KSIGMA,CONSTMETHOD,REWORK,INSPECT);

%Init process index
init_processIndex1 = 3;
init_processIndex2 = 2;
init_processIndex3 = 1;
init_processIndex4 = 3;

%Vector of the cost to rework each part

reworkR = 0.1;
reworkcostvec = reworkR*[7.7 6.9 5.0 4.89];

%Part 1
a = [10 5 3.5];
b = [0.015 0.5 0.75];
Sdev_pt1 = [0.015/KSIGMA 0.08/KSIGMA; 0.06/KSIGMA 0.15/KSIGMA; 0.12/KSIGMA 0.25/KSIGMA];
% init_sigma1 = mean(Sdev_pt1(1,:),2);
init_sigma1 = 0.179806/KSIGMA;
tol1 = KSIGMA * init_sigma1;%The tolerance is a constant times sigma
part1 = part(a,b,part1_dim,Sdev_pt1,init_sigma1,tol1,init_processIndex1);

%Part 2
a = [8 3];
b = [0.25 0.65];
Sdev_pt2 = [0.02/KSIGMA 0.15/KSIGMA; 0.08/KSIGMA 0.3/KSIGMA];
%init_sigma2 = mean(Sdev_pt2(1,:),2);
init_sigma2 = 0.165358/KSIGMA;
tol2 = KSIGMA * init_sigma2;
part2 = part(a,b,part2_dim,Sdev_pt2,init_sigma2,tol2,init_processIndex2);

%Part 3
a = [2.5 5];
b = [0.3 0.045];
Sdev_pt3 = [0.04/KSIGMA 0.2/KSIGMA; 0.12/KSIGMA 0.25/KSIGMA];
%init_sigma3 = mean(Sdev_pt3(1,:),2);
init_sigma3 = 0.120132/KSIGMA;
tol3 = KSIGMA * init_sigma3;
part3 = part(a,b,part3_dim,Sdev_pt3,init_sigma3,tol3,init_processIndex3);

%Part 4
a = [4 6 0.5];
b = [0.56 0.16 0.88];
Sdev_pt4 = [0.08/KSIGMA 0.12/KSIGMA; 0.15/KSIGMA 0.25/KSIGMA; 0.2/KSIGMA 0.4/KSIGMA];
%init_sigma4 = mean(Sdev_pt4(1,:),2);
init_sigma4 = 0.200581/KSIGMA;
tol4 = KSIGMA * init_sigma4;
part4 = part(a,b,part4_dim,Sdev_pt4,init_sigma4,tol4,init_processIndex4);

%Initialize some dimensions that will be used in computing cost
part1 = machinePart(part1, init_processIndex1, init_sigma1,tol1,CONST);
part2 = machinePart(part2, init_processIndex2, init_sigma2,tol2,CONST);
part3 = machinePart(part3, init_processIndex3, init_sigma3,tol3,CONST);
part4 = machinePart(part4, init_processIndex4, init_sigma4,tol4,CONST);

allParts(1) = part1;
allParts(2) = part2;
allParts(3) = part3;
allParts(4) = part4;

init_tol = [tol1 tol2 tol3 tol4];
init_processIndexvec = [init_processIndex1 init_processIndex2 init_processIndex3 init_processIndex4];

allParts = inittolcost(allParts,init_tol,init_processIndexvec);
allParts = initreworkcost(allParts,init_processIndexvec,reworkcostvec);

%the total profit of the initialized state.
[maxProfit,num_products,TaguchiLoss] = computeTotalProfit(allParts,part1,0,0,CONST);

data = setData(maxProfit, maxIteration,num_part,num_products,allParts,TaguchiLoss);

end