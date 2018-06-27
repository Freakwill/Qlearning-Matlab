function h=animline(xdata, ydata, varargin)
% input:
% varargin: properties in line or
%           time: time from [xdata(k),ydata(k)] to [xdata(k+1),ydata(k+1)];
%           gradient: gradual change
% xdata,ydata: vector
% grammar:
%     h=line(xdata, ydat, movemark,'Parent',haxes ,'Gradient',10,'Time',1,'MoveMarker','*');

time = 1;
gradient=1;
c={};
movemarker='o';
for i=1:2:length(varargin)
    property=varargin{i};
    value=varargin{i+1};
    switch(lower(property))
        case 'time'
            time=value;
        case 'gradient'
            gradient=value;
        case 'movemarker'
            movemarker=value;
        case 'parent'
            parent = value;
        otherwise
            c=[c,property,value];
    end
end

n=length(xdata);
t=time/(gradient);
for k=1:n-1
    h=line( 'XData', xdata(1:k),'YData', ydata(1:k) ,c{:});
    pause(t); delete(h);
    xk=xdata(k); yk=ydata(k);
    dx=(xdata(k+1)-xk)/gradient; dy=(ydata(k+1)-yk)/gradient; % step length
    for g =1:gradient-1
        h=line( 'XData', [xdata(1:k),xk+dx*g],'YData', [ydata(1:k),yk+dy*g], 'Parent', parent, c{:});
        mk = line('XData', xk+dx*g, 'YData', yk+dy*g, 'Parent', parent, c{:}, 'Marker', movemarker);
        pause(t); delete([h,mk]);
    end
end

h=line('XData', xdata,'YData', ydata ,c{:});