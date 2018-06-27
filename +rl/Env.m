classdef Env
    % envirenment for rl
    
    properties
        name='';
        objects=[];
        observation_space=[];
        action_space=[];
        axes=1;
    end
    
    methods
        function obj=Env(name)
            obj.name = name;
        end
        
        function obj=init(obj)
            
            for k=1:length(obj.objects)
                obj.objects(k)=obj.objects(k).init();
            end
            obj.draw()
        end
        function obj=reset(obj)
            obj = obj.init();
        end
        
        function draw(obj)
            %
        end
        
        function obj = append(obj, object)
            obj.objects = [obj.objects, object];
        end
        
        function object = get(obj, object_name)
            object = 0;
            for o=obj.objects
                if strcmp(o.name, object_name)
                    object = o;
                    return
                end
            end
        end
    end
    
end

