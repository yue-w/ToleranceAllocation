function part=part(a,b,dim,sdev,init_sigma,tol,init_processIndex)
%{
Initialize a part
%}
    num_processes = length(a);
    c = zeros(1,num_processes);
    d = zeros(1,num_processes);
    Xbar_vec = dim*ones(1,num_processes);
    reworkingConstVec = zeros(1,num_processes);
    % dev_pt1 = constDev*ones(1,num_processes);
    % part1_dim_vec = Xbar_pt1_vec;
    % Sdev_pt1 = standev(part1_dim_vec,dev_pt1, Xbar_pt1_vec, p);
    %Sdev_pt1 = [0.015/KSIGMA 0.08/KSIGMA; 0.06/KSIGMA 0.15/KSIGMA; 0.12/KSIGMA 0.25/KSIGMA];
    %init_sigma = mean(Sdev_pt(1,:),2);
    process = setprocessessigma(a, b, c, d,reworkingConstVec,Xbar_vec,sdev,init_sigma);
%     init_processIndex = 1;
    part = init_one_Part(process, tol, dim, init_processIndex);
end