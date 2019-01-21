function [w, i, t] = simulate(params, varargin)
    var_names = {'InputSignal', 'Time'};
    defaults  = {ones(1, 100), 0:99};
    [u, t] = internal.stats.parseArgs(var_names, defaults, varargin{:});
    
    R = params.R;
    L = params.L;
    K = params.K;
    Jm = params.Jm;
    f = params.f;
    
    sys_w = tf(K, [ ...
       L*Jm, ...
       R*Jm + f*L, ... 
       K*K + f*R ...
       ]);
   
    sys_i = tf([Jm f], [ ...
       L*Jm, ...
       R*Jm + f*L, ... 
       K*K + f*R ...
       ]);
   
    if(u == "step")
        opt = stepDataOptions('StepAmplitude', 1);
        w = step(sys_w, t, opt);
        i = step(sys_i, t, opt);
    else
        w = lsim(sys_w, u, t);
        i = lsim(sys_i, u, t);
    end
end

