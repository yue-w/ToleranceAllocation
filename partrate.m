function part=partrate(a,b,e,f,dim,sdev,init_sigma,tol,init_processIndex)
%Initialize a part. Modified from the function part() to support four
%coefficients
    num_processes = length(a);

    Xbar_vec = dim*ones(1,num_processes);

    process = setprocessessigma(a, b, e, f,Xbar_vec,sdev,init_sigma);
%     init_processIndex = 1;
    part = init_one_Part(process, tol, dim, init_processIndex);

end