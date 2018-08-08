function process = init_one_Process(lb, ub, a, b, c, d, machiningConst,reworkConst, Xbar, Sdev)
    %lower bound and upper bound of the tolerance.
    %For the VaryBounds method, they are the bounds for the LS and US
    %For the VarySigma method, they are the bounds for the sigma
    process.lb = lb;
    process.ub = ub;
    %some constant used to compute cost
    const.a = a;
    const.b = b;
    const.c = c;
    const.d = d;
    const.machiningConst = machiningConst;
    const.reworkConst = reworkConst;%the cost to rework a part.
    process.const = const;
    
    %Average dimension of parts machined by this process
    %This might or might not equals designed value. Computed using samples.
    process.Xbar = Xbar;
    
    %Standard deviation of this process. Computed using samples. Used for
    %VaryBounds Method
    
    process.Sdev = Sdev;
    
    
end