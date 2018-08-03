function error = variateRst(TOL,tol1,tol2,tol3)
    error = TOL - sqrt(tol1^2+tol2^2+tol3^2);
end