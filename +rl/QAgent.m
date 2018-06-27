classdef QAgent < rl.Agent
    % envirenment for rl
    
    properties
        last_action=[];
        QTable;
        QLParam=struct('alpha',0.9,'gamma',0.5);
        stateList;
    end
    
    methods
        
        function obj=QAgent(name, env, init_state)
            obj = obj@rl.Agent(name, env, init_state);
            obj.stateList=[obj.init_state];
            obj.QTable=zeros(1, length(obj.action_space));
        end

        
        function obj=step(obj)
            obj = obj.step@rl.Agent();
            obj = obj.updateQTable();
        end
        
        function obj=updateQTable(obj)
             %    
            r=obj.get_reward();
            k0=index(obj.stateList, obj.last_state);
            k=index(obj.stateList, obj.state); 
            
            if k == 0                  % it is a new state
                q = obj.guessQ();
                V = max(q);
                obj.QTable = [obj.QTable; q];
                obj.stateList=[obj.stateList, obj.state];       
            else
                V = max(obj.QTable(k,:));       % get V(s); it is a familiar state
            end
            % nevertheless, we have get the V(s) (stored in v)
            a = index(obj.action_space, obj.action);
            D = r+obj.QLParam.gamma*V - obj.QTable(k0,a); 
            obj.QTable(k0,a)=obj.QTable(k0,a)+obj.QLParam.alpha*D;   % update Q-table
        end

        function q = guessQ(obj)
            q = zeros(1, length(obj.action_space));
        end

%         function a=select_action(obj)
%                 k=index(obj.stateList, obj.state); % k0-state
%                 qs=obj.QTable(k, :); q=min(qs);
%                 rem=obj.action_space; rem(qs==q)=[];
%                 if isempty(rem)      % policy
%                     a=randi(length(obj.action_space));
%                     a = obj.action_space(a);
%                 else % a=drand(as,qs)
%                     qs(qs==q)=[];    % delete q from qs
%                     a=drand(rem, (qs-q).^4);
%             end
%         end


        function a=select_action(obj)
            k = index(obj.stateList, obj.state); % k0-state
            qs = obj.QTable(k, :);
            [q, idx] = max(qs);
            choices = obj.action_space(qs==q);
            k = randi(length(choices));
            a = choices(k);
        end

%         function a=select_action(obj)
%             k=index(obj.stateList, obj.state); % k0-state
%             qs = obj.QTable(k, :);
%             [q, idx]=max(qs);
%             a=obj.action_space(idx);
%         end
 
        function obj = end_process(obj)
            if obj.issucessful()
                obj.QLParam.alpha = obj.QLParam.alpha * 0.75;
            end
        end
        
        function tf = issuccessful(obj)
            % obj is successful
        end

    end
    
end

