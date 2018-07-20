function [allParts, CONST ]= initialize()

BACH = 1000;
DIM = 4;
LTOL =  -0.15;
UTOL = 0.15;
LLIM = DIM + LTOL;% = 3.85
ULIM = DIM + UTOL;% = 4.15
%Iterate step for the tolerance
STEP = (UTOL - LTOL) / 20;
PRICE = 10;
CONST = initCONST(BACH,PRICE,DIM,LLIM,ULIM,STEP);

lb = 0;
ub = ULIM;

a = 0; b = 0; c = 0; d = 0;

num_part = 2;
tol =(UTOL - LTOL)/num_part;


%Two machines(m) two part(p).
%Machine 1. Assume that 95% of the parts fall in the bounds. Unbiased.
machiningConst_m1 = 2;
%Phi(1.96)=97.5%
%Assumes that the mean is 1 and 95% of the parts fall in 0.95-1.05
part1_dim = 1;
part2_dim = 3;
%Part 1
%Use machine 1 to process part 1
dev_pt1 = 0.05;
Xbar_m1_pt1 = 1;
Sdev_m1_pt1 = (part1_dim + dev_pt1 -Xbar_m1_pt1)/1.96;

%Part 2
%Assumes that the mean is 3, and 95% of the parts fall in 2.9-3.1
%Use machine 1 to process part 2
dev_pt2 = 0.1;
Xbar_m1_pt2 = 3;
Sdev_m1_pt2 = (part2_dim + dev_pt2 - Xbar_m1_pt2)/1.96;

%Machine 2. Assume that 90% of the parts fall in the bounds. Unbiased
machiningConst_m2 = 1;
%Phi(1.6449) = 0.95
%Use machine 2 to process Part 1
%Part 1
Xbar_m2_pt1 = part1_dim;
Sdev_m2_pt1 = (part1_dim + dev_pt1 -Xbar_m1_pt1)/1.6449;

%Part 2
%Use machine 2 to process part 2
Xbar_m2_pt2 = part2_dim;
Sdev_m2_pt2 = (part2_dim + dev_pt2 - Xbar_m1_pt2)/1.6449;


process_m1_pt1 = init_one_Process(lb, ub, a, b, c, d, machiningConst_m1, Xbar_m1_pt1, Sdev_m1_pt1);
process_m2_pt1 = init_one_Process(lb, ub, a, b, c, d, machiningConst_m2, Xbar_m2_pt1, Sdev_m2_pt1);
part1_process(1) =  process_m1_pt1;
part1_process(2) =  process_m2_pt1;

process_m1_pt2 = init_one_Process(lb, ub, a, b, c, d, machiningConst_m1, Xbar_m1_pt2, Sdev_m1_pt2);
process_m2_pt2 = init_one_Process(lb, ub, a, b, c, d, machiningConst_m2, Xbar_m2_pt2, Sdev_m2_pt2);
part2_process(1) = process_m1_pt2;
part2_process(2) = process_m2_pt2;



processIndex = 1;
part1 = init_one_Part(part1_process, tol, part1_dim, processIndex,CONST);
part2 = init_one_Part(part2_process, tol, part2_dim, processIndex,CONST);

allParts(1) = part1;
allParts(2) = part2;



end