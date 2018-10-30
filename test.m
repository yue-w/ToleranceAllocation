
a = [0.03 0.02];
b = [0.016 0.012];
x1 = linspace(0.0168,0.0286,30);
x2 = linspace(0.0255,0.033);
y1 = a(1) + b(1)./x1;
y2 = a(2) + b(2)./x2;

figure
plot(x1,y1,'g',x2,y2,'b');
legend('process 1','process 2')
xlabel('sigma')
ylabel('machining cost');
% 
% figure
% X = linspace(0,2*pi,25)';
% Y = X;
% Z = 1.5*X;
% W = [Y Z];
% stem(X,W(:,1),'LineStyle','-.',...
%      'MarkerFaceColor','red',...
%      'MarkerEdgeColor','green')
%  hold on
%  stem(X,W(:,2),'LineStyle','-.',...
%      'MarkerFaceColor','green',...
%      'MarkerEdgeColor','red')
% stem(X,W)

% figure
% plot(X,W(:,1),'o');
% hold on
% plot(X,W(:,2),'o');