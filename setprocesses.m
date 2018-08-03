function processes = setprocesses(lb, ub, a, b, c, d, machiningConstvec,reworkingConstvec,Xbarvec, Sdevvec)

    num_process = length(machiningConstvec);
    %Preallocate process. Allocate memory
    processes(num_process) = init_one_Process(lb, ub, a, b, c, d, 0,0,0, 0);
    if(length(machiningConstvec)==length(Xbarvec) && length(Sdevvec)==length(Xbarvec))
        for i = 1:num_process
            process_m1_pt3 = init_one_Process(lb, ub, a, b, c, d, machiningConstvec(i),reworkingConstvec(i), Xbarvec(i), Sdevvec(i));

            processes(i) =  process_m1_pt3;
           
        end
    else
        disp('the dimensions of the processes do not match');
    end
end