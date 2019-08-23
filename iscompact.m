function CRatio=iscompact(XC, ni,i, x, y,yr)
%% compactness measure using schwartzbergs method

    %Define empty lists to add all of the x and y coordinates for the
    %postcodes in the catchment area for i.
    x1=[];
    y1=[];
    for j=1:length(XC)
        if XC(j,yr)==i
            x1=[x1,x(j)];
            y1=[y1,y(j)];
        end
    end
    %Add the neighbourhood solution moving into catchment area
    x1=[x1,x(ni)];
    y1=[y1,y(ni)];
    %Set of bounding coordinates
     bound=boundary(x1',y1');
     %Calculate areperimeter of district
     AD=area(polyshape(x1(bound), y1(bound)));
     PD=perimeter(polyshape(x1(bound), y1(bound)));
     
     %Calculate perimeter of circle with equal area
     PC=2*pi*sqrt(AD/pi);
     CRatio=PC/PD;

end