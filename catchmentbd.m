function ps=catchmentbd(XC, i, x, y)
%% Returns the boundary for each catchment area i
    %Define empty lists to add all of the x and y coordinates for the
    %postcodes in the catchment area for i.
    x1=[];
    y1=[];
    for j=1:length(XC)
        if XC(j)==i
            x1=[x1,x(j)];
            y1=[y1,y(j)];
        end
    end
    %Set of bounding coordinates
     bound=boundary(x1',y1');
     ps=polyshape(x1(bound), y1(bound));

end