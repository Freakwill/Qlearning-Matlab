classdef AnimLines
    %Animation
    
    properties
        lines=[];  % struct
        parameter=struct('gradient',10,'time',0.5); % struct: time, gradient
    end
    
    properties(Dependent=true, SetAccess=private)
        nline=0;
    end
    
    methods
        function  obj=AnimLines(varargin)
            obj.parameter=struct(varargin{:});
            obj.parameter.gradient = 10;
            obj.parameter.time = 0.5;
        end
        
        function obj=append(obj,ln)
            obj.lines=[obj.lines,ln];
        end
        
%         function ret=subsref(obj, ind)
%             if strcmp(ind.type, '()')
%                 ret=obj.lines(ind);
%             else
%                 ret=obj.ind;
%             end
%         end
        
        function n=get.nline(obj)
            n=length(obj.lines);
        end
        
        function start(obj)
        end
        
        function run(obj)
            gradient=obj.parameter.gradient;
            time=obj.parameter.time;
            n=length(obj.lines(1).xdata);
            t=time/(gradient);
            for k=1:n-1
                for l=1:obj.nline
                    c=struct2array(obj.lines(l));
                    h(l)=line(c{:}, 'XData', obj.lines(l).xdata(1:k),'YData', obj.lines(l).ydata(1:k));
                end
                pause(t); delete(h);
                for l=1:obj.nline
                    xk(l)=obj.lines(l).xdata(k); yk(l)=obj.lines(l).ydata(k);
                    dx(l)=(obj.lines(l).xdata(k+1)-xk(l))/gradient; dy(l)=(obj.lines(l).ydata(k+1)-yk(l))/gradient; % step length
                end
                for g =1:gradient-1
                    for l=1:obj.nline
                        c=struct2array(obj.lines(l));
                        h(l)=line(c{:}, 'XData', [obj.lines(l).xdata(1:k),xk(l)+dx(l)*g],'YData', [obj.lines(l).ydata(1:k),yk(l)+dy(l)*g]);
                    end
                    pause(t); delete(h);
                end
            end
            for l=1:obj.nline
                c=struct2array(obj.lines(l));
                h(l)=line(c{:});
            end
        end
        
%         function delete(obj)
%             delete(obj.lines);
%         end
    end
    
end

