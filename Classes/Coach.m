classdef Coach < handle

    properties (Constant)
        GEN_MODE_RANDOM = 0;
        GEN_MODE_STATIC = 1;
        
        SETTING_NN_INPUT_NEURONS = 0;
        SETTING_NN_OUTPUT_NEURONS = 1;
        SETTING_NN_HIDDEN_NEURONS = 2;
    end
    
    properties
        hiddenLayersRanges;
    end
    
    properties (Access = private)
        mode;
    end
    
    methods
        function this = Coach()

        end
        
        function this = setGenerationMode(this, mode)
           if mode == this.GEN_MODE_RANDOM
               this.mode = this.GEN_MODE_RANDOM;
           else
               this.mode = this.GEN_MODE_STATIC;
           end
        end
        
        function layers = generateHiddenLayers(this)
            layers = 0;
            if this.mode == this.GEN_MODE_RANDOM
                layer_count = randperm(size(this.hiddenLayersRanges, 1), 1);
                layers = zeros(1, layer_count);
                for layer_index=1:layer_count
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
    end
end