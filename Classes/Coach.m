classdef Coach < handle

    properties (Constant)
        GEN_MODE_RANDOM = 0;
        GEN_MODE_STATIC = 1;
        
        SETTING_NN_NEURONS_GENERATION = 0;
        SETTING_NN_LAYERS_GENERATION = 1;
    end
    
    properties
        hiddenLayersRanges;
        hiddenCount;
    end
    
    properties (Access = private)
        settingNeuronsGeneration;
        settingLayersGeneration;
    end
    
    methods
        function this = Coach()

        end
        
        function this = set(this, parameter, value)
           if parameter == this.SETTING_NN_LAYERS_GENERATION
               this.settingLayersGeneration = value;
           elseif parameter == this.SETTING_NN_NEURONS_GENERATION
               this.settingNeuronsGeneration = value;
           end
        end
        
        function layers = generateHiddenLayers(this)
            layers = 0;
            if this.settingNeuronsGeneration == this.GEN_MODE_RANDOM
                layers_count = this.generateLayersCount();
                layers = zeros(1, layers_count);
                for layer_index=1:layers_count
                    layers(layer_index) = this.generateNeuronsCount(layer_index);
                end
            end
        end
    end
    
    methods (Access = private)
        function count = generateNeuronsCount(this, layer_index)
            range = this.hiddenLayersRanges(layer_index, :);
            count = range(1) + randperm(range(2) - range(1), 1);
        end  
        
        function layer_count = generateLayersCount(this)
            layer_count = size(this.hiddenLayersRanges, 1);
            if this.SETTING_NN_LAYERS_GENERATION == this.GEN_MODE_RANDOM
                layer_count = randperm(layer_count, 1);
            end
        end
    end
end