function parts=initreworkcost(parts,initProcessIndexvec,reworkcostvec)
    num_parts = length(parts);
    %for each part
    for i=1:num_parts
        parts(i).processes(initProcessIndexvec(i)).const.reworkConst = reworkcostvec(i);       
    end
end