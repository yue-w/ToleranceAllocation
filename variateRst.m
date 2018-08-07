function error = variateRst(TOL,tol1,tol2,tol3)
    error = TOL/3 - sqrt((tol1/3)^2+(tol2/3)^2+(tol3/3)^2);
end