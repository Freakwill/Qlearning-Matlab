classdef RectWall < rl.Object
    % wall object for rl
    
    properties
        size = [1,1];
    end
    
    methods
        function obj=RectWall(name, env, init_state)
            obj=obj@rl.Object(name, env, init_state);
        end

        function draw(obj)
            pos = obj.get_position();
            text(obj.env.axes, 'Position', pos([2,1])-0.5, 'String', obj.name, 'FontSize', 16);
            patch(obj.env.axes,'Xdata',[pos(2)-1, pos(2)+obj.size(2)-1, pos(2)+obj.size(2)-1, pos(2)-1],'Ydata',[pos(1)-1, pos(1)-1, pos(1)+obj.size(1)-1, pos(1)+obj.size(1)-1], 'Color', 'y')
        end

    end
    
end


