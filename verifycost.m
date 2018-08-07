a = [3.5 3.0 2.5 0.5];
b = [0.75 0.65 0.3 0.88];
tol = [0.179806 0.165358 0.120132 0.200581];

totalcost = cost(a,b,tol);

tolus =  [0.2488 0.2952 0.1952 0.3664];
totalcostus = cost(a,b,tolus);

X1 = 55.29+0.179806;
X2 = 22.86+0.165358;
X3 = 22.86+0.120132;
X4= 101.69+0.200581;
y1 = dimension(X1,X2,X3,X4);
X1 = 55.29+0.2416;
X2 = 22.86+0.2496;
X3 = 22.86+0.2;
X4= 101.69+0.2836;
yus1 = dimension(X1,X2,X3,X4);

X1 = 55.29-0.179806;
X2 = 22.86-0.165358;
X3 = 22.86-0.120132;
X4= 101.69-0.200581;
y2 = dimension(X1,X2,X3,X4);
X1 = 55.29-0.2416;
X2 = 22.86-0.2496;
X3 = 22.86-0.2;
X4= 101.69-0.2836;
yus2 = dimension(X1,X2,X3,X4);

LOW = 0.122-0.035;
UP = 0.122+0.035;
function totalcost = cost(a,b,tol)
costs = a + b./tol;
totalcost = sum(costs);
end

function y = dimension(X1,X2,X3,X4)
    tem = (X2+X3)/2;
    y = acos((X1+tem)/(X4-tem));
end

