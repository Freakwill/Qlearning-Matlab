classdef BaseShape
    %  Summary of this class goes here
    %   Detailed explanation goes here

    properties
        parent
        position=[0,0];
        handle
    end

    methods
        function obj = BaseShape(parent, position)
            if nargin==1
                position=[0,0];
            end
            obj.parent = parent;
        end
        
        function obj = plus(obj, vector)
            obj.position = obj.position + vector;
        end

        function h = draw(obj)
            % body
        end
        
        function h = move_along(obj, direction, distance, time)
            if nargin<=3
                time =1;
                if nargin<=2
                    distance=1;
                    if nargin<=1
                        direction=[1,0];
                    end
                end
            end
            h = obj.draw();
            for i=1:obj.gradient
                pause(time/obj.gradient); delete(h);
                obj = obj + distance*1/obj.gradient*direction;
                h = obj.draw();
            end
        end
        
        function h = move_to(obj, destination, time)
            if nargin<=2
                time = 1;
                if nargin<=1
                    destination=[0,0];
                end
            end
            position = obj.shape.Position([1,2]) + obj.shape.Position([3,4])/2;
            direction = destination-position; distance=norm(direction); direction = direction/distance;
            h=obj.move_along(direction, distance,time);
        end
    end
end 