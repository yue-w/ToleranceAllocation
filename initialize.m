function [allParts, CONST,data]= initialize(maxIteration,CONSTMETHOD)
num_part = 3;
num_processes = 2;
part1_dim = 1;
part2_dim = 1;
part3_dim = 1;

BACH = 10000;
DIM = part1_dim + part2_dim + part3_dim ;
% LTOL =  -0.15;
% UTOL = 0.15;
TOL = 0.1;
LLIM = DIM - TOL;% = 3.85
ULIM = DIM + TOL;% = 4.15
%Iterate step for the tolerance
STEP = TOL / 100;
PRICE = 10;
TAGUCH_K = 1;
KSIGMA = 0;

REWORKSIGN.ADDPART = 0;%Do not do rework
REWORKSIGN.ONESIDEREWORK = 1;%Do one side rework (Rework Larg part)
REWORKSIGN.TWOSIDEREWORK = 2;%Two sides rework
REWORK.FLAG = REWORKSIGN;
REWORK.V = 0;%set the value.
CONST = initCONST(BACH,PRICE,DIM,LLIM,ULIM,STEP,TAGUCH_K,KSIGMA,CONSTMETHOD,REWORK);

%lb, ub are the searching area for the tolerance of processes. Set it to the tolerance

%of the product.
ub = TOL;
lb = ub/20;

a = 0; b = 0; c = 0; d = 0;



tol =TOL/num_part;

%Two machines(m) two parts(p).

p = [0.99,0.92];

%Part 1
machiningConstVecPt1 = [1.2,1]; 
reworkingConstVecPt1 = [0.5,0.5];
Xbar_pt1_vec = part1_dim*ones(1,num_processes);
dev_pt1 = [0.1,0.1];
part1_dim_vec = Xbar_pt1_vec;
Sdev_pt1 = standev(part1_dim_vec,dev_pt1, Xbar_pt1_vec, p);

%Part 2
machiningConstVecPt2 = [1.2,1]; 
reworkingConstVecPt2 = [0.5,0.5];
Xbar_pt2_vec = part2_dim*ones(1,num_processes);
dev_pt2 = [0.1,0.1];
part2_dim_vec = Xbar_pt2_vec;
Sdev_pt2 = standev(part2_dim_vec,dev_pt2, Xbar_pt2_vec, p);

%Part 3
machiningConstVecPt3 = [1.2,1]; 
reworkingConstVecPt3 = [0.5,0.5];
Xbar_pt3_vec = part3_dim*ones(1,num_processes);
dev_pt3 = [0.1,0.1];
part3_dim_vec = Xbar_pt3_vec;
Sdev_pt3 = standev(part3_dim_vec,dev_pt3, Xbar_pt3_vec, p);


part1_process = setprocesses(lb, ub, a, b, c, d,machiningConstVecPt1,reworkingConstVecPt1,Xbar_pt1_vec,Sdev_pt1);
part2_process = setprocesses(lb, ub, a, b, c, d,machiningConstVecPt2,reworkingConstVecPt2,Xbar_pt2_vec,Sdev_pt2);
part3_process = setprocesses(lb, ub, a, b, c, d,machiningConstVecPt3,reworkingConstVecPt3,Xbar_pt3_vec,Sdev_pt3);

init_processIndex = 1;
part1 = init_one_Part(part1_process, tol, part1_dim, init_processIndex);
part2 = init_one_Part(part2_process, tol, part2_dim, init_processIndex);
part3 = init_one_Part(part3_process, tol, part3_dim, init_processIndex);

%Initialize some dimensions that will be used in computing cost
part1 = machinePart(part1, 1,part1_process(init_processIndex).Sdev, part1.tol, CONST);
part2 = machinePart(part2, 1,part2_process(init_processIndex).Sdev, part2.tol, CONST);
part3 = machinePart(part3, 1,part3_process(init_processIndex).Sdev,part3.tol, CONST);

allParts(1) = part1;
allParts(2) = part2;
allParts(3) = part3;

%the total profit of the initialized state.
[maxProfit,num_products,~] = computeTotalProfit(allParts,part1,0,init_processIndex,CONST);

data = setData(maxProfit, maxIteration,num_part,num_products,allParts,0);


end