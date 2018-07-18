function process = init_one_Process(lb, ub, a, b, c, d, Xbar, Sdev)
    %lower bound of the tolerance
    process.lb = lb;
    %up bound of the tolerance
    process.ub = ub;
    %some constant used to compute cost
    const.a = a;
    const.b = b;
    const.c = c;
    const.d = d;
    process.const = const;
    
    %Average dimension of parts machined by this process
    process.Xbar = Xbar;
    
    %Standard deviation of this process
    process.Sdev = Sdev;
    
    
end