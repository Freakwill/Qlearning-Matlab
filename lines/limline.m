function [x,y]=limline(A,B,C,XLim,YLim,N)
% input:
% A,B,C represent the line Ax+By+C=0
% XLim,YLim: the line must be in the domain XLim X YLim
% example:
% XLim=[0,1];
% YLim=[0,1];
% N=100;
% A=rand;B=rand;C=-0.5;
% limline(A,B,C,XLim,YLim,N)
% ax=axes('XLim',XLim,'YLim',XLim);
% line('Parent',ax,'XData',x,'YData',y)
%
if nargin<=5,N=100;
    if nargin<=4,YLim=[0,1];
        if nargin<=3,XLim=[0,1];
        end
    end
end

if B~=0,
    yy=-A/B*XLim-C/B;
    if A<0,
        if yy(1)<YLim(1)
            x1=-B/A*YLim(1)-C/A;
        else
            x1=XLim(1);
        end
        if yy(2)<=YLim(2),
            x2=XLim(2);
        else
            x2=-B/A*YLim(2)-C/A;
        end
        x=linspace(x1,x2,N);
        y=-B/A*x-C/A;
    elseif A>0,
        if yy(1)<=YLim(2),
            x1=XLim(1);
        else
            x1=-B/A*YLim(2)-C/A;
        end
        if yy(2)<YLim(1),
            x2=-B/A*YLim(1)-C/A;
        else
            x2=XLim(2);
        end
        x=linspace(x1,x2,N);
        y=-A/B*x-C/B;
    else
        x=linspace(XLim(1),XLim(2),N);
        y=repmat(-C/B,1,N);
    end
else
    if A~=0,
        x=repmat(-C/A,1,N);
        y=linspace(YLim(1),YLim(2),N);
    else
        x=NaN;y=NaN;
    end
end
