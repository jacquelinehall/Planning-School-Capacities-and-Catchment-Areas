function plotcatchment=plotcatchment(Xbest, Geodata)
%% compactness measure using schwartzbergs method
    for i=1:20
        %Define empty lists to add all of the x and y coordinates for the
        %postcodes in the catchment area for i.
        x1=[];
        y1=[];
        for j=1:length(Geodata)
            if Xbest(j)==i
                x1=[x1,Geodata(j,3)];
                y1=[y1,Geodata(j,4)];
            end
        end
         bound=boundary(x1',y1');
         hold on
         plot(polyshape(x1(bound), y1(bound)));
    end


end