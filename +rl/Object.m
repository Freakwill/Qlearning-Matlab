classdef Object
    % object in the envirenment
    % robot or goal or trap
    
    properties
        name='';
        state_space=[];
        action_space=[];
        axes=1;
        env;
        init_state;
        state=[];
        parameter={};
        default = {'Marker', 'o', 'MarkerFaceColor', 'y', 'MarkerSize', 30};
        % size = [1,1];
    end
    
    methods
        function obj=Object(name, env, init_state, varargin)
            
            if nargin <=2
                init_state = []; 
            end
            obj.init_state = init_state;
            obj.name = name;
            obj.env = env;
            obj.parameter = obj.default;
            for i=1:2:length(varargin)
                property=varargin{i};
                value=varargin{i+1};
                obj.parameter=[obj.parameter,property,value];
            end
        end
        
        function obj=init(obj)
            obj.state=obj.init_state;
            % obj.env=obj.env.append(obj);
            obj.draw();
        end
        
        function obj=reset(obj)
            obj = obj.init();
        end
        
        function obj=step(obj)
        end
        
        function draw(obj)
            pos = obj.get_position();
            line('Parent', obj.env.axes,'Xdata', pos(2)-0.5,'Ydata', pos(1)-0.5, obj.parameter{:});
            text(obj.env.axes, 'Position', pos([2,1])-0.5, 'String', obj.name, 'FontSize', 16);
        end
        
        function pos=get_position(obj)
            pos = obj.state(1:2);
        end
        
        function tf=isat(obj, somewhere)
            if isa(somewhere, 'rl.Object')
                somewhere = somewhere.get_position();
            elseif ischar(somewhere)
                something = obj.env.get(somewhere);
                if isa(something, 'rl.Object')
                    somewhere = something.get_position();
                else
                    tf = false;
                    return
                end
            end
            tf = all(obj.get_position() == somewhere);
        end
    end
    
end


