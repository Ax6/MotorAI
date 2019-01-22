classdef Parameters < handle
    
    properties (Access = private)
        settings;
        
        SETTING_RANGEMIN_ = 1;
        SETTING_RANGEMAX_ = 2;
    end
    
    methods
        function this = Parameters()
            this.settings = table();
        end
        
        function this = range(this, name, interval)
            if all(size(interval) ~= [1 2])
                error("Unexpected range interval");
            end
            this.settings{:, end+1} = interval';
            this.settings.Properties.VariableNames{end} = name;
        end
        
        function names = getNames(this)
            names = this.settings.Properties.VariableNames;
        end
        
        function count = getCount(this)
            count = length(this.getNames());
        end
        
        function ranges = getNormRanges(this)
            ranges = this.settings{[this.SETTING_RANGEMIN_, this.SETTING_RANGEMAX_],:}';
        end
        
        function norm = normalise(this, not_norm)
            norm = logEncode(this.getNormRanges(), not_norm);
        end
        
        function denorm = denormalise(this, norm)
            denorm = logDecode(this.getNormRanges(), norm);
        end
    end
end

