classdef MyQAgent < rl.QAgent
    % envirenment for rl
    
    properties
        % position=[];
    end
    
    methods
        
        function obj=MyQAgent(name, env, init_state)
            if nargin <= 2
                init_state=[1; 1; 10; 0];
            end
            obj = obj@rl.QAgent(name, env, init_state);
            obj.action_space = ['^', 'v', '<', '>'];
            obj.QTable=zeros(1,4);
        end
        
        function obj=transition(obj)
            obj.action = obj.select_action();
            if isempty(obj.last_state) || any(obj.state ~= obj.last_state)
                obj.last_state=obj.state;
                if obj.isat('Resource')
                    obj.state(3) = 20;
                end
            end
            switch obj.action
                case '^'
                    if obj.state(1)<obj.env.size(1)
                        obj.state=obj.state+[1;0;-1;0];
                    end
                case '>'
                    if obj.state(2)<obj.env.size(2)
                        obj.state=obj.state+[0;1;-1;0];
                    end
                case 'v'
                    if obj.state(1)>1
                        obj.state=obj.state+[-1;0;-1;0];
                    end
                case '<'
                    if obj.state(2)>1
                        obj.state=obj.state+[0;-1;-1;0];
                    end
                otherwise
                    error('No such action');
            end
            if obj.state(1)==5 && ismember(obj.state(2),[4,5,6]) ... %obj.isat('wall')
                 || obj.state(1)==3 && ismember(obj.state(2), [1,2,3]) 
                obj.state=obj.last_state;
            end
        end

        function obj=draw(obj)
            if ~ obj.moved()
                pos = obj.get_position();
                obj.handle=line('Parent',obj.env.axes,'Xdata', pos(2)-0.5,'Ydata', pos(1)-0.5, 'Marker','o','MarkerFaceColor','c', 'MarkerSize',18, 'LineStyle', '-.');
            else
                pos = obj.get_pair();
                % text(obj.env.axes, 'Position', pos([2,1])-0.5, 'String', obj.name, 'FontSize', 16);
                obj.handle=move(pos{1}-0.5, pos{2}-0.5, 'Parent',obj.env.axes, 'Marker', 'o', 'MarkerFaceColor','c', 'MarkerSize',18);
            end
            obj.show_info();
            pause(.01);
            delete(obj.handle);
        end
        
        function show_info(obj)
            if obj.state(3) > 3
                xlabel(obj.axes, 'String', sprintf('ROBOT %s, POWER %d', obj.name, obj.state(3)), 'FontSize', 16, 'Color', 'g');
            else
                xlabel(obj.axes, 'String', sprintf('ROBOT %s, POWER %d CAUTION!!!', obj.name, obj.state(3)), 'FontSize', 16, 'Color', 'r');
            end
        end

        function y=isterminal(obj)
            y = obj.isat('Heaven') || obj.isat('Hell') || obj.state(3)<=0;
        end

        function r=get_reward(obj)
            if obj.isat('Trap')
                r = -1;
            elseif obj.isat('Heaven')
                r = 50;
            elseif obj.isat('Hell')
                r = -10;
            elseif obj.isat('Resource')
                if any(obj.state ~= obj.last_state) && obj.state(4)<2
                    r = 0.1;
                end
                if obj.state(3)>10
                    r = -.5;
                elseif obj.state(3)>5
                    r = -.3;
                end
                obj.last_state(4) = obj.last_state(4)+1;
            else
                r = -0.05;
            end
        end

        function q = guessQ(obj)
            j = index(obj.stateList(1:2,:), obj.state(1:2));
            if j ~= 0
                q = obj.QTable(j,:);
            else      % it is a new position
                j = index(obj.stateList(1,:), obj.state(1));
                if j ~= 0
                    q = obj.QTable(j,:);
                
                else
                    j = index(obj.stateList(2,:), obj.state(2));
                    if j ~= 0
                        q = obj.QTable(j,:);
                    else
                        q = zeros(1, length(obj.action_space));
                    end
                end
            end   
        end
 

        function tf = issucessful(obj)
            tf = obj.isat('Heaven');        
        end
        
        function obj = begin_process(obj, lp)
            title(obj.axes, 'String', sprintf('ROUND %d', lp), 'FontSize', 16);
        end
        
        function obj = end_process(obj)
            obj = obj.end_process@rl.QAgent();
            if obj.isat('Heaven')
                xlabel(obj.axes, 'String', 'Success', 'FontSize', 16);
            elseif obj.isat('Hell')
                xlabel(obj.axes, 'String', 'Be dead', 'FontSize', 16);
            else
                xlabel(obj.axes, 'String', 'Fail', 'FontSize', 16);
            end
            pause(.1);
        end

    end
    
end


function h=move(s, t, varargin)
    d=t-s;
    for i = 0:9
        h=line(s(2)+d(2)/10*i,s(1)+d(1)/10*i, varargin{:});
        pause(0.001);
        delete(h);
    end
    h=line(t(2),t(1), varargin{:});
end
