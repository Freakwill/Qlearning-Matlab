function h=cycle(xdata,ydata,ha)
if nargin==2
    ha=ga
end
h=line('Parent',ha, 'XData',[xdata,xdata(1)],'YData',[ydata,ydata(1)]);