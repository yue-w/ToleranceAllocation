function [allParts, CONST,data]=ratesigmacost(maxIteration,CONSTMETHOD)
%{
Compare the results of this method to the rate-sigma-cost method.
%}
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

PRICE = 50;
A = 0;
TAGUCH_K = A/(0.035^2);
STEP = 0.01;



REWORKSIGN.ADDPART = 0;%Do not do rework
REWORKSIGN.ONESIDEREWORK = 1;%Do one side rework (Rework Larg part)
REWORKSIGN.TWOSIDEREWORK = 2;%Two sides rework
REWORK.FLAG = REWORKSIGN;
REWORK.V = 0;%set the value.

%Whether inspect each components
INSPECT = 0;
%Whether to use benefit or unit cost as the metric. 0 is profit, 1 is unit cost.
METRIC = 1;
CONST = initCONST(BACH,PRICE,DIM,LLIM,ULIM,STEP,TAGUCH_K,KSIGMA,CONSTMETHOD,REWORK,INSPECT,METRIC);

%Whether to consider Scrap Cost
SCRAP.FLAG = 0;
if  SCRAP.FLAG == 0
    SCRAP.RATIO = 0;%the ratio of scrap cost to Ai for the ith component
    SCRAP.PSC = 0;%CSP is product scrap cost
else
    SCRAP.RATIO = 0.1;%the ratio of scrap cost to Ai for the ith component
    SCRAP.PSC = 0.612;%CSP is product scrap cost
end
CONST.SCRAP = SCRAP;

%Init process index
init_processIndex1 = 1;
init_processIndex2 = 1;
init_processIndex3 = 1;

%Vector of the cost to rework each part

reworkR = 0.3;
reworkcostvec = reworkR*[0 0 0];

%Part 1
a = 0.87; %5.0;
b = 2.062; %20;
e = 0;
f = 0.001798/3;
Sdev_pt1 = [0.1 0.4]/3;
init_sigma1 = mean(Sdev_pt1(1,:),2);
tol1 = KSIGMA * init_sigma1;%The tolerance is a constant times sigma
part1 = partrate(a,b,e,f,part1_dim,Sdev_pt1,init_sigma1,tol1,init_processIndex1);

%Part 2
a = 1.71; %3.0;
b = 1.276; %36.7;
e = 0;
f = 0.001653/3;
Sdev_pt2 = [0.08 0.3];
init_sigma2 = mean(Sdev_pt2(1,:),2);
tol2 = KSIGMA * init_sigma2;
part2 = partrate(a,b,e,f,part2_dim,Sdev_pt2,init_sigma2,tol2,init_processIndex2);

%Part 3
a = 3.54; %1.0;
b = 1.965; % 36.0;
e = 0;
f = 0.002/3;
Sdev_pt3 = [0.1 0.5];
init_sigma3 = mean(Sdev_pt3(1,:),2);
tol3 = KSIGMA * init_sigma3;
part3 = partrate(a,b,e,f,part3_dim,Sdev_pt3,init_sigma3,tol3,init_processIndex3);



%Initialize some dimensions that will be used in computing cost
part1 = machinePart(part1, init_processIndex1, init_sigma1,tol1,CONST);
part2 = machinePart(part2, init_processIndex2, init_sigma2,tol2,CONST);
part3 = machinePart(part3, init_processIndex3, init_sigma3,tol3,CONST);


allParts(1) = part1;
allParts(2) = part2;
allParts(3) = part3;



init_tol = [tol1 tol2 tol3];
init_processIndexvec = [init_processIndex1 init_processIndex2 init_processIndex3];

allParts = inittolcost(allParts,init_tol,init_processIndexvec);
allParts = initreworkcost(allParts,init_processIndexvec,reworkcostvec);

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

%[maxProfitcurrent,num_productscurrent] = currenttotalprofit(allParts,CONST);

data = setData(metric, maxIteration,num_part,num_products,allParts,TaguchiLoss);

end