function [allParts, CONST,data] = clutchrework(sigmavec,maxIteration,reworkR,costVec,a,b,CONSTMETHOD)
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
A = 20;
TAGUCH_K = A/(0.035^2);
STEP = 0.02 / 50;


REWORKSIGN.ADDPART = 0;%Do not do rework
REWORKSIGN.ONESIDEREWORK = 1;%Do one side rework (Rework Larg part)
REWORKSIGN.TWOSIDEREWORK = 2;%Two sides rework
REWORK.FLAG = REWORKSIGN;
REWORK.V = 2;%set the value.

%Whether inspect each components
INSPECT = 1;
CONST = initCONST(BACH,PRICE,DIM,LLIM,ULIM,STEP,TAGUCH_K,KSIGMA,CONSTMETHOD,REWORK,INSPECT);

%Init process index
init_processIndex = 1;

%Vector of the cost to rework each part

%reworkR = 0.8;
reworkcostvec = reworkR*costVec;

c = 0; d = 0;
tolscale = 3;

%Part 1
%Sdev_pt1 = sigmascale*[0.015/KSIGMA 0.08/KSIGMA; 0.06/KSIGMA 0.15/KSIGMA; 0.12/KSIGMA 0.25/KSIGMA];
% init_sigma1 = mean(Sdev_pt1(1,:),2);
Sdev_pt1 = sigmavec(1);
tol1 = sigmavec(1)*KSIGMA;%The tolerance is a constant times sigma
ub = Sdev_pt1 * tolscale;     
lb = ub/20;
part1_process = setprocesses(lb, ub, a(1), b(1), c, d,costVec(1),reworkcostvec(1),part1_dim,Sdev_pt1);
part1 = init_one_Part(part1_process, tol1, part1_dim, init_processIndex);

%Part 2
%Sdev_pt1 = sigmascale*[0.015/KSIGMA 0.08/KSIGMA; 0.06/KSIGMA 0.15/KSIGMA; 0.12/KSIGMA 0.25/KSIGMA];
% init_sigma1 = mean(Sdev_pt1(1,:),2);
Sdev_pt2 = sigmavec(2);
tol2 =  sigmavec(2)*KSIGMA;%The tolerance is a constant times sigma
ub = Sdev_pt2 * tolscale;     
lb = ub/20;
part2_process = setprocesses(lb, ub, a(2), b(2), c, d,costVec(2),reworkcostvec(2),part2_dim,Sdev_pt2);
part2 = init_one_Part(part2_process, tol2, part2_dim, init_processIndex);

%Part 3
%Sdev_pt1 = sigmascale*[0.015/KSIGMA 0.08/KSIGMA; 0.06/KSIGMA 0.15/KSIGMA; 0.12/KSIGMA 0.25/KSIGMA];
% init_sigma1 = mean(Sdev_pt1(1,:),2);
Sdev_pt3 = sigmavec(3);
tol3 =  sigmavec(3)*KSIGMA;%The tolerance is a constant times sigma
ub = Sdev_pt3 * tolscale;     
lb = ub/20;
part3_process = setprocesses(lb, ub, a(3), b(3), c, d,costVec(3),reworkcostvec(3),part3_dim,Sdev_pt3);
part3 = init_one_Part(part3_process, tol3, part3_dim, init_processIndex);

%Part 4
%Sdev_pt1 = sigmascale*[0.015/KSIGMA 0.08/KSIGMA; 0.06/KSIGMA 0.15/KSIGMA; 0.12/KSIGMA 0.25/KSIGMA];
% init_sigma1 = mean(Sdev_pt1(1,:),2);
Sdev_pt4 = sigmavec(4);
tol4 =  sigmavec(4)*KSIGMA;%The tolerance is a constant times sigma
ub = Sdev_pt4 * tolscale;     
lb = ub/20;
part4_process = setprocesses(lb, ub, a(4), b(4), c, d,costVec(4),reworkcostvec(4),part4_dim,Sdev_pt4);
part4 = init_one_Part(part4_process, tol4, part4_dim, init_processIndex);

%Initialize some dimensions that will be used in computing cost
part1 = machinePart(part1, init_processIndex, Sdev_pt1,tol1,CONST);
part2 = machinePart(part2, init_processIndex, Sdev_pt2,tol2,CONST);
part3 = machinePart(part3, init_processIndex, Sdev_pt3,tol3,CONST);
part4 = machinePart(part4, init_processIndex, Sdev_pt4,tol4,CONST);

allParts(1) = part1;
allParts(2) = part2;
allParts(3) = part3;
allParts(4) = part4;


%the total profit of the initialized state.
[maxProfit,num_products,TaguchiLoss] = computeTotalProfit(allParts,part1,0,0,CONST);

data = setData(maxProfit, maxIteration,num_part,num_products,allParts,TaguchiLoss);
end