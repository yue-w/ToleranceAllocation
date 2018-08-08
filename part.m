function part=part(a,b,dim,sdev,init_sigma,tol,init_processIndex)
%{
Initialize a part
%}
    num_processes = length(a);
    c = zeros(1,num_processes);
    d = zeros(1,num_processes);
    Xbar_vec = dim*ones(1,num_processes);

    process = setprocessessigma(a, b, c, d,Xbar_vec,sdev,init_sigma);
%     init_processIndex = 1;
    part = init_one_Part(process, tol, dim, init_processIndex);
end