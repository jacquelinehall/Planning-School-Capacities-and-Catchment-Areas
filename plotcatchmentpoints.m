function plotcatchment=plotcatchmentpoints(Xbest, Geodata,numberschools,sx,sy)
%% Plot the catchment areas as point. 
%Use plotcatchmentpoints(XI, Geodata) for the intial solution and
%plotcatchmentpoints(Xbest, Geodata) after running the local search for an
%updated solution found through the local search.

    figure(1); cla;
    
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
            if Xbest(j)==i
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
            if Xbest(j)==i
                x1=[x1,Geodata(j,1)];
                y1=[y1,Geodata(j,2)];
                
            end
        end
        plot(x1,y1, '.','Color', colorstring(i)) 
        hold on    
        
        
        
         end
    end
    
    
    
    plot(sx,sy,'o', 'Color', [0.8, 0.8, 0.7]);
a = [1:length(sx)]'; b = num2str(a); c = cellstr(b);
dx = 0.1; dy = 0.1;
text(sx+dx, sy+dy, c, 'Color', [0.8, 0.8, 0.7], 'fontsize', 22, 'fontweight', 'bold');


    hold off


end