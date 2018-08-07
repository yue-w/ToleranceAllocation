function parts=initsigmacost(parts,sigma,initProcessIndexvec)
    num_parts = length(parts);
    %for each part
    for i=1:num_parts
%         num_process = length(parts(i).processes);
        
%         %for each process
%         for j = 1:num_process
%             parts(i).processes(j).const.machiningConst = ...
%                 sigmacostequation(parts(i).processes(j).const,sigma(i));
%         end
        parts(i).processes(initProcessIndexvec(i)).const.machiningConst = ...
            sigmacostequation(parts(i).processes(initProcessIndexvec(i)).const,sigma(i));
    end
end