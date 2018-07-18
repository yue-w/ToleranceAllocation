function part = init_one_Part(processes, tol, dimension)
%This function define attributes of a part
    
    %Array that store the processes that can be used to machine this part
    part.processes = processes;
    
    %Tolerance assigned to this part
    part.tol = tol;
    
    %Designed dimension of this part
    part.dim = dimension;
    
end