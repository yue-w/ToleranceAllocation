
%X1
figure
tol1 = linspace(0.015, 0.08,30);
tol2 = linspace(0.06, 0.15,30);
tol3 = linspace(0.12, 0.25,30);
%tol4 = linspace(0.3, 0.55,30);
tol = [tol1; tol2; tol3];
a = [10 5 3.5 2];
b = [0.015 0.5 0.75 1];
subplot(2,2,1);
cost1 = a(1) + b(1)./tol(1,:);
cost2 = a(2) + b(2)./tol(2,:);
cost3 = a(3) + b(3)./tol(3,:);
%cost4 = a(4) + b(4)./tol(4,:);
plt1 = plot(tol1,cost1,'g',tol2,cost2,'b',tol3,cost3,'r');
legend('process 1','process 2','process 3')
xlabel('sigma(mm)')
ylabel('machining cost ($)');


%X2
subplot(2,2,2);
tol1 = linspace(0.02, 0.15,30);
tol2 = linspace(0.08, 0.3,30);
%tol3 = linspace(0.33, 0.58,30);
a = [8 3.0 1];
b = [0.25 0.65 0.8];
tol = [tol1; tol2; tol3];
cost1 = a(1) + b(1)./tol(1,:);
cost2 = a(2) + b(2)./tol(2,:);
%cost3 = a(3) + b(3)./tol(3,:);
plot(tol1,cost1,'g',tol2,cost2,'b');
legend('process 1','process 2')
xlabel('sigma (mm)')
ylabel('machining cost ($)');


%X3
subplot(2,2,3);
tol1 = linspace(0.04, 0.2,30);
tol2 = linspace(0.12, 0.25,30);
%tol3 = linspace(0.3, 0.65,30);
a = [2.5 5.0 2];
b = [0.3 0.045 0.25];
%tol = [tol1; tol2; tol3];
cost1 = a(1) + b(1)./tol(1,:);
cost2 = a(2) + b(2)./tol(2,:);
%cost3 = a(3) + b(3)./tol(3,:);
plot(tol1,cost1,'g',tol2,cost2,'b');
legend('process 1','process 2')
xlabel('sigma (mm)')
ylabel('machining cost ($)');


%%X4
subplot(2,2,4);
tol1 = linspace(0.08, 0.12,30);
tol2 = linspace(0.15, 0.25,30);
tol3 = linspace(0.2, 0.4,30);
%tol4 = linspace(0.5, 0.9,30);
tol = [tol1; tol2; tol3];
a = [4 6 0.5 0.2];
b = [0.56 0.16 0.88 1];
cost1 = a(1) + b(1)./tol(1,:);
cost2 = a(2) + b(2)./tol(2,:);
cost3 = a(3) + b(3)./tol(3,:);
%cost4 = a(4) + b(4)./tol(4,:);
plot(tol1,cost1,'g',tol2,cost2,'b',tol3,cost3,'r');
legend('process 1','process 2','process 3')
xlabel('sigma (mm)')
ylabel('machining cost ($)');

% %Common Legend
% hL = subplot(3,2,5.5);
% poshL = get(hL,'position');     % Getting its position
% lgd = legend(hL,plt1,'Process 1','Process 2','Process 3');
% set(lgd,'position',poshL);      % Adjusting legend's position
% axis(hL,'off');                 % Turning its axis off
