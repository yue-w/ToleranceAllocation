% pd = makedist('Normal','mu',0,'sigma',1);
% t = truncate(pd,-2,2);
% x = -3:.1:3;
% figure;
% plot(x,pdf(pd,x),'Color','red','LineWidth',2)
% hold on;
% plot(x,pdf(t,x),'Color','blue','LineWidth',2,'LineStyle',':')
% legend({'Normal','Truncated'},'Location','NE')
% hold off;

BATCH = 10;
sigma = 0.1;
dimensions = normrnd(0,sigma,[1,BATCH]);
thisProcessIndex = 1;
thisPart.processes(thisProcessIndex).Xbar = 0;
designDim = 0;

tol = 0.05;
numAdded = 0;
numRework = 0;
[parts,num_part_added,num_part_reworked] = addPartsdorework(dimensions,thisPart,thisProcessIndex, designDim,sigma, tol, BATCH,numAdded,numRework);