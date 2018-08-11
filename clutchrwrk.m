function [allParts, CONST,data]=clutchrwrk(maxIteration,CONSTMETHOD)
%{
Case study. Use bigger sigma to compare the result of rework.
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
A = 0;
TAGUCH_K = A/(0.035^2);
STEP = 0.02 / 50;


REWORKSIGN.ADDPART = 0;%Do not do rework
REWORKSIGN.ONESIDEREWORK = 1;%Do one side rework (Rework Larg part)
REWORKSIGN.TWOSIDEREWORK = 2;%Two sides rework
REWORK.FLAG = REWORKSIGN;
REWORK.V = 2;%set the value.
CONST = initCONST(BACH,PRICE,DIM,LLIM,ULIM,STEP,TAGUCH_K,KSIGMA,CONSTMETHOD,REWORK);

%Init process index
init_processIndex1 = 1;
init_processIndex2 = 1;
init_processIndex3 = 1;
init_processIndex4 = 1;

%Vector of the cost to rework each part

reworkR = 0.8;
reworkcostvec = reworkR*[4.5 3.7 5.0 6.1];

sigmascale = 3;
%Part 1
a = 3.5;
b = 0.75;
%Sdev_pt1 = sigmascale*[0.015/KSIGMA 0.08/KSIGMA; 0.06/KSIGMA 0.15/KSIGMA; 0.12/KSIGMA 0.25/KSIGMA];
Sdev_pt1 = sigmascale*[0.12/KSIGMA 0.25/KSIGMA];
% init_sigma1 = mean(Sdev_pt1(1,:),2);
init_sigma1 = mean(Sdev_pt1)/KSIGMA;
tol1 = KSIGMA * init_sigma1;%The tolerance is a constant times sigma
part1 = part(a,b,part1_dim,Sdev_pt1,init_sigma1,tol1,init_processIndex1);

%Part 2
a = 3;
b = 0.65;
%Sdev_pt2 = sigmascale*[0.02/KSIGMA 0.15/KSIGMA; 0.08/KSIGMA 0.3/KSIGMA];
Sdev_pt2 = sigmascale*[0.08/KSIGMA 0.3/KSIGMA];
%init_sigma2 = mean(Sdev_pt2(1,:),2);
init_sigma2 = mean(Sdev_pt2)/KSIGMA;
tol2 = KSIGMA * init_sigma2;
part2 = part(a,b,part2_dim,Sdev_pt2,init_sigma2,tol2,init_processIndex2);

%Part 3
a = 5;
b = 0.045;
%Sdev_pt3 = sigmascale*[0.04/KSIGMA 0.2/KSIGMA; 0.12/KSIGMA 0.25/KSIGMA];
Sdev_pt3 = sigmascale*[0.12/KSIGMA 0.25/KSIGMA];
%init_sigma3 = mean(Sdev_pt3(1,:),2);
init_sigma3 = mean(Sdev_pt3)/KSIGMA;
tol3 = KSIGMA * init_sigma3;
part3 = part(a,b,part3_dim,Sdev_pt3,init_sigma3,tol3,init_processIndex3);

%Part 4
a = 0.5;
b = 0.88;
%Sdev_pt4 = sigmascale*[0.08/KSIGMA 0.12/KSIGMA; 0.15/KSIGMA 0.25/KSIGMA; 0.2/KSIGMA 0.4/KSIGMA];
Sdev_pt4 = sigmascale*[0.2/KSIGMA 0.4/KSIGMA];
%init_sigma4 = mean(Sdev_pt4(1,:),2);
init_sigma4 = mean(Sdev_pt4)/KSIGMA;
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