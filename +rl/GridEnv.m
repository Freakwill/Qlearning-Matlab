classdef GridEnv < rl.Env
    % grid envirenment for rl
    
    properties
        size;
    end
    
    methods
        function obj=GridEnv(name, size)
            if nargin == 1
                size = [4,4];
            end
            obj = obj@rl.Env(name);
            obj.size = size;
            obj.observation_space = [1, size(1); 1, size(2)];
            obj.action_space = ['^', 'v', '<', '>'];
        end

        function obj=step(obj)
            for k = 1: length(obj.objects)
                obj.objects(k) = obj.objects(k).transition();
            end
        end
        
        function draw(obj)
            linegrid(obj.size(2), obj.size(1), obj.axes);
            for k = 1: length(obj.objects)
                obj.objects(k).draw();
            end
        end
        
    end
    
end

