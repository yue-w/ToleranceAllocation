function standev = standev(dim,error, Xbar, p)

    z = norminv((1+p)/2);
    standev = (dim + error - Xbar)./z;
end