function result = factorialrecursion(n)
%This function use recursion to cumpute factorial
    if(n==1)
        result = 1;
    else
        tem = factorialrecursion(n-1);
        result = n*tem;
    end
end