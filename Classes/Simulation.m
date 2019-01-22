classdef Simulation < handle

    properties
        systems = table();
        parameters;
        t;
        stepOpt = stepDataOptions('StepAmplitude', 1);
    end
    
    methods
        function this = Simulation(time)
            if size(time, 1) ~= 1
                error("Invalid time vector")
            end
            this.t = time';
        end
        
        function this = setParameters(this, parameters)
            this.parameters = parameters;
        end
        
        function this = addTF(this, num, den)
            this.systems{end+1, :} = {num, den};
        end
        
        function y = run(this)
            y = [];
            for i=1:height(this.systems)
                sys = this.makeSys(i);
                y(:, end+1) = step(sys, this.t, this.stepOpt);
            end
        end
    end
    
    methods (Access = private)
        function sys = makeSys(this, index)
            num = this.systems{index, 1}{1};
            den = this.systems{index, 2}{1};
            names = this.parameters.Properties.VariableNames;
            for i=1:length(names)
                eval(strcat(names{i}, '=', num2str(this.parameters{:, names{i}}), ';'));
            end
            sys = tf(eval(num), eval(den));
        end
    end
end

