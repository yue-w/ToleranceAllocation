function processes=setprocessessigma(a, b, c, d,Xbarvec,Sdev,init_sigma)
    num_process = length(Sdev);
    %Preallocate process. Allocate memory
    processes(num_process) = init_one_Process(0, 0, a(1), b(1), c(1), d(1), 0,0, 0, 0);
    if(length(Sdev)==length(Xbarvec))
        for i = 1:num_process
            machiningConst = 0;
            reworkingConst = 0;
            process = init_one_Process(min(Sdev(i,:)), max(Sdev(i,:)), a(i), b(i), c(i),...
                d(i), machiningConst,reworkingConst, Xbarvec(i), init_sigma);

            processes(i) =  process;
           
        end
    else
        disp('the dimensions of the processes do not match');
    end
end