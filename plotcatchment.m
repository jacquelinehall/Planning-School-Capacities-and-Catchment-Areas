function plotcatchment=plotcatchment(Xbest, Geodata,numberschools,sx,sy)
%% compactness measure using schwartzbergs method
    for i=1:numberschools
        %Define empty lists to add all of the x and y coordinates for the
        %postcodes in the catchment area for i.
        x1=[];
        y1=[];
        if numberschools==20
            for j=1:length(Geodata)
                if Xbest(j)==i
                    x1=[x1,Geodata(j,3)];
                    y1=[y1,Geodata(j,4)];
                end
            end
        else
            for j=1:length(Geodata)
                if Xbest(j)==i
                    x1=[x1,Geodata(j,1)];
                    y1=[y1,Geodata(j,2)];
                end
            end
        end
         bound=boundary(x1',y1');
         hold on
         plot(polyshape(x1(bound), y1(bound)));
    end
    
        plot(sx,sy,'o', 'Color', [0.8, 0.8, 0.7]);
a = [1:length(sx)]'; b = num2str(a); c = cellstr(b);
dx = 0.1; dy = 0.1;
text(sx+dx, sy+dy, c, 'Color', [0.8, 0.8, 0.7], 'fontsize', 22, 'fontweight', 'bold');




end