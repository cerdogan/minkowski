%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% @name Circle.m
%% @author Can Erdogan
%% @date Nov 15, 2012
%% @brief Draw a circle
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function h = drawCircle (pos, radius, color) 

    if(nargin < 3), color = 'k'; end;
    
    numSegments = 32;
    angle = (2 * pi) / numSegments;
    ps = [];
    for i = 0 : (numSegments)
        if(i > (numSegments - 1)), j = i - numSegments;
        else j = i + 1; end;
        point1 = pos + radius * [cos(i * angle), sin(i * angle)];
        point2 = pos + radius * [cos(j * angle), sin(j * angle)];
        hold on; 
        axis equal;
        hold on;
        ps(end+1,:) = point1;
    end
    
    h = plot(ps(:,1), ps(:,2) ,['-', color]);
end
