function processes=setprocessessigma(a, b, c, d,Xbarvec,Sdev,sigma_vec)
    num_process = length(Sdev);
    %Preallocate process. Allocate memory
    processes(num_process) = init_one_Process(0, 0, a(1), b(1), c(1), d(1), 0, 0, 0);
    if(length(Sdev)==length(Xbarvec))
        for i = 1:num_process
            process = init_one_Process(min(Sdev(i,:)), max(Sdev(i,:)), a(i), b(i), c(i), d(i), 0, Xbarvec(i), sigma_vec(i));

            processes(i) =  process;
           
        end
    else
        disp('the dimensions of the processes do not match');
    end
end