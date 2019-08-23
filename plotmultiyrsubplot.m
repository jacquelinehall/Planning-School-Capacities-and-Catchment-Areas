function plotmultiyrsubplot(pd,Geodata,x,y,Xbest,sx,sy,numberschools,yr1,yr2)


k2=yr1-1;

for k=(yr1-k2):(yr2-k2)

    %subplot(round((yr2-yr1)/2),2,k)
    subplot(2,2,k)
   
    hold on
for i=1:numberschools
        %secondary schools
         colorstring = 'bmkgymcybmkrcymbgrckmcykgrkgrcmybgrcmmmbrgryykkcmyggbckmkbygkcgrycygrgrk';
         %k=20 
         %colorstring = 'ggggggmcggkkkkbgggg';
         if numberschools==20 %Secondary schools

         
        
        %Define empty lists to add all of the x and y coordinates for the
        %postcodes in the catchment area for i.
        x1=[];
        y1=[];
        for j=1:length(Geodata)
            if Xbest(j,k+k2)==i
                x1=[x1,Geodata(j,3)];
                y1=[y1,Geodata(j,4)];
                
            end
        end
        plot(x1,y1, '.','Color', colorstring(i))
        hold on
         else %Primary schools
             
        %Define empty lists to add all of the x and y coordinates for the
        %postcodes in the catchment area for i.
        x1=[];
        y1=[];
        for j=1:length(Geodata)
            if Xbest(j,k+k2)==i
                x1=[x1,Geodata(j,1)];
                y1=[y1,Geodata(j,2)];
                
            end
        end
        plot(x1,y1, '.','Color', colorstring(i)) 
        hold on    
        
        
        
         end
    end
    
    
    set(gca,'XColor', 'none','YColor','none')
    set(gcf,'color','w');

    title(sprintf("Catchment plan in %d", 2018+k+k2),'FontSize',22)


    hold off

end

newUnits = 'normalized';



end