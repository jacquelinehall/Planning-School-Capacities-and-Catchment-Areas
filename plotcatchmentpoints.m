function plotcatchment=plotcatchmentpoints(Xbest, Geodata)
%% Plot the catchment areas as point. 
%Use plotcatchmentpoints(XI, Geodata) for the intial solution and
%plotcatchmentpoints(Xbest, Geodata) after running the local search for an
%updated solution found through the local search.

    figure(1); cla;
    for i=1:20
         colorstring = 'bmkgymcybmkrcymbgrckmcykgrkgrcmybgrcmmmbrgryykkcmyggbckmkbygkcgrycygrgrk';
         
         hold on
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
    end


end