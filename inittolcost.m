function parts=inittolcost(parts,tol,initProcessIndexvec)
    num_parts = length(parts);
    %for each part
    for i=1:num_parts
        machiningcost = tolcostequation(parts(i).processes(initProcessIndexvec(i)).const,tol(i));
        parts(i).processes(initProcessIndexvec(i)).const.machiningConst = machiningcost;       
    end
end