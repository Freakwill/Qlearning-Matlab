classdef MyGridEnv < rl.GridEnv
    % grid envirenment for rl
    
    properties
    end
    
    methods
        function obj=MyGridEnv(name, size)
            if nargin == 1
                size = [4,4];
            end
            obj = obj@rl.GridEnv(name);
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
            obj.draw@rl.GridEnv();
            patch(obj.axes, 'XData',[3, 6, 6, 3], 'YData',[4, 4, 5, 5], 'FaceColor', 'k');
            patch(obj.axes, 'XData',[0,3,3,0], 'YData',[2, 2, 3, 3], 'FaceColor', 'k');
            text(obj.axes, 'Position', [5.5, 4.5], 'String', 'Wall', 'Color', 'w', 'HorizontalAlignment', 'center');
            text(obj.axes, 'Position', [0.5, 0.5], 'String', 'Start', 'Color', 'k', 'HorizontalAlignment', 'center');
        end
        
    end
    
end

