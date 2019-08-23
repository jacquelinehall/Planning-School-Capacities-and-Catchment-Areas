function NX=neighbourhoodX1(XC, i, x,y, yr)
%This is a neighbourhood search based on contiguity, The definition used
%within this alogirthm is that a neighbouring solution for a catchment area
%X is all points y such that y is the closest point outside X to atleast
%one point within X. Where distance in measured by euclidean distance.

    NX=[];
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

    %For each postcode in the catchment area i find the closest postcode
    %outside the catchment area (by euclidean distance).
    for k=1:length(x1)
        %Define the smallest euclidean distance to be large for each
        %iteration.
        smallED=100000;
        for j=1:length(XC)
            if XC(j,yr)~=i
                x2=x(j);
                y2=y(j);
                if sqrt((x2-x1(k))^2+(y2-y1(k))^2)<smallED %Check if this 
                %distance is the smallest, if there are multiple the same
                %only the first is stored.
                    smallED=sqrt((x2-x1(k))^2+(y2-y1(k))^2);
                    smallEDindex=j;
                end
            end
        end
        NX=[NX,smallEDindex];
    end
    %Remove any duplicate values
    NX=unique(NX);
end