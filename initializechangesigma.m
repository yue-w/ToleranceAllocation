function [allParts, CONST,data]=initializechangesigma(maxIteration,CONSTMETHOD)
%{
This function is in scenerio two. Change sigma.
initialize parameters

%}
num_part = 3;
num_processes = 2;
part1_dim = 1;
part2_dim = 1;
part3_dim = 1;
KSIGMA = 1;

BACH = 10000;
DIM = part1_dim + part2_dim + part3_dim ;
% LTOL =  -0.15;
% UTOL = 0.15;
TOL = 0.2;
LLIM = DIM - TOL;% = 3.85
ULIM = DIM + TOL;% = 4.15


a = [0.030 0.020];
b = [0.016 0.012];
c = [0,0];
d = [0,0];


%Lower bound and upper bound of the probability that the dimension will
%fall between the given us and ls. The probability determines the sigma
pHighEnd = [0.7,0.8];
pLowEnd = [0.6,0.66];
p = [pHighEnd;pLowEnd];

constDev = 0.1;
%We use the function tolerance = k*sigma 
%init_sigma = sqrt((TOL/KSIGMA)^2/num_part);
init_sigma =mean( constDev./norminv((1+pHighEnd)/2));
%init_sigma=0.02;
STEP = init_sigma / 200;

PRICE = 50;
TAGUCH_K = 4;

REWORK = 0;

CONST = initCONST(BACH,PRICE,DIM,LLIM,ULIM,STEP,TAGUCH_K,KSIGMA,CONSTMETHOD,REWORK);

%initialialized sigma
init_sigma_vec = init_sigma*ones(1,num_part);

%Init process index
init_processIndex = 1;
tol = KSIGMA * init_sigma;%The tolerance is a constant times sigma

%Part 1
Xbar_pt1_vec = part1_dim*ones(1,num_processes);
reworkingConstVecPt1 = [0.5,0.5];
dev_pt1 = constDev*ones(1,num_processes);
part1_dim_vec = Xbar_pt1_vec;
Sdev_pt1 = standev(part1_dim_vec,dev_pt1, Xbar_pt1_vec, p);
part1_process = setprocessessigma(a, b, c, d,reworkingConstVecPt1,Xbar_pt1_vec,Sdev_pt1,init_sigma_vec);
part1 = init_one_Part(part1_process, tol, part1_dim, init_processIndex);


%Part 2 
Xbar_pt2_vec = part2_dim*ones(1,num_processes);
reworkingConstVecPt2 = [0.5,0.5];
dev_pt2 = constDev*ones(1,num_processes);
part2_dim_vec = Xbar_pt2_vec;
Sdev_pt2 = standev(part2_dim_vec,dev_pt2, Xbar_pt2_vec, p);
part2_process = setprocessessigma(a, b, c, d,reworkingConstVecPt2,Xbar_pt2_vec,Sdev_pt2,init_sigma_vec);
part2 = init_one_Part(part2_process, tol, part2_dim, init_processIndex);

%Part 3
Xbar_pt3_vec = part3_dim*ones(1,num_processes);
reworkingConstVecPt3 = [0.5,0.5];
dev_pt3 = constDev*ones(1,num_processes);
part3_dim_vec = Xbar_pt3_vec;
Sdev_pt3 = standev(part3_dim_vec,dev_pt3, Xbar_pt3_vec, p);
part3_process = setprocessessigma(a, b, c, d,reworkingConstVecPt3,Xbar_pt3_vec,Sdev_pt3,init_sigma_vec);
part3 = init_one_Part(part3_process, tol, part3_dim, init_processIndex);

%Initialize some dimensions that will be used in computing cost
part1 = machinePart(part1, init_processIndex, init_sigma,tol,CONST);
part2 = machinePart(part2, init_processIndex, init_sigma,tol,CONST);
part3 = machinePart(part3, init_processIndex, init_sigma,tol,CONST);

allParts(1) = part1;
allParts(2) = part2;
allParts(3) = part3;

init_processIndexvec = init_processIndex * ones(1,num_part);
allParts = inittolcost(allParts,init_sigma_vec,init_processIndexvec);

%the total profit of the initialized state.
[maxProfit,num_products] = computeTotalProfit(allParts,part1,0,init_processIndex,CONST);

data = setData(maxProfit, maxIteration,num_part,num_products,allParts);


end