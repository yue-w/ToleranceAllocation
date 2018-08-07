
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

