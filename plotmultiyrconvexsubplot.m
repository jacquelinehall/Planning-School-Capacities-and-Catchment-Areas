function plotmultiyrconvexsubplot(pd,Geodata,x,y,Xbest,sx,sy,numberschools,yr1,yr2)

k2=yr1-1;


for k=(yr1-k2):(yr2-k2)

    %subplot(round((yr2-yr1)/2),2,k)
    subplot(2,2,k)
   
    hold on
    for i=1:numberschools
        %Define empty lists to add all of the x and y coordinates for the
        %postcodes in the catchment area for i.
        x1=[];
        y1=[];
        if numberschools==20
            for j=1:length(Geodata)
                if Xbest(j,k+k2)==i
                    x1=[x1,Geodata(j,3)];
                    y1=[y1,Geodata(j,4)];
                end
            end
        else
            for j=1:length(Geodata)
                if Xbest(j,k+k2)==i
                    x1=[x1,Geodata(j,1)];
                    y1=[y1,Geodata(j,2)];
                end
            end
        end
         bound=boundary(x1',y1');
         hold on
         plot(polyshape(x1(bound), y1(bound)));
    end
    set(gca,'XColor', 'none','YColor','none')
    set(gcf,'color','w');
 

    title(sprintf("Catchment plan in %d", 2018+k+k2),'FontSize',22)


    hold off

end

newUnits = 'normalized';



end