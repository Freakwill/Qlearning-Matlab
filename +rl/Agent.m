classdef Agent < rl.Object
    % envirenment for rl
    
    properties
        last_state=[];
        action=[];
        policy=[];
    end
    
    methods
        function obj=Agent(name, env, init_state)
            obj = obj@rl.Object(name, env, init_state);
        end
        
        function obj=init(obj)
            obj.last_state=[];
            obj = obj.init@rl.Object();
        end


        function obj=transition(obj)
            % state transition
            % obj.action = obj.select_action();
            % obj.last_state=obj.current_state;
            % obj.current_state <- obj.last_state, obj.action
        end    

        function obj=step(obj)
            % state transition, then draw it
            obj = obj.transition();
            % animation
            lh=obj.draw();
            pause(.05);
            delete(lh);
        end
        
        function pos=get_pair(obj)
            pos = {obj.last_state(1:2), obj.state(1:2)};
        end

        function tf=isterminal(obj)
            tf=1;
        end

        function obj=train(obj, epochs, max_step)
            % obj.env.init();
            if nargin <= 2
                max_step = 60;
                if nargin <= 1
                    epochs = 400;
                end
            end
            for lp=1:epochs  % looping
                obj=obj.init();
                obj = obj.begin_process(lp);
                policy=[];            % action list
                step=0;               % step
                while ~obj.isterminal() && step<max_step
                    obj = obj.step();
                    policy = [policy, obj.action];
                    step=step+1;
                end
                obj.policy = policy;
                obj = obj.end_process();
            end
        end

        function obj = begin_process(obj, lp)
            title(obj.axes, 'String', sprintf('ROUND %d', lp));
            pause(.2);
        end

        function obj = end_process(obj)
            % what do you want to do after learning
        end

    end
end