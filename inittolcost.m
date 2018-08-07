function parts=inittolcost(parts,tol,initProcessIndexvec)
    num_parts = length(parts);
    %for each part
    for i=1:num_parts
        parts(i).processes(initProcessIndexvec(i)).const.machiningConst = ...
            tolcostequation(parts(i).processes(initProcessIndexvec(i)).const,tol(i));
    end
end