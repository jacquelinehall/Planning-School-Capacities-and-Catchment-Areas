function delta=obchangeX(NX,z,i,XC,YC,XI,w1,p2,p3,pd,x,y,sx,sy,yr)
%% Compute the change in the objective from including NX(z) in the current 
%%solution XC
    delta=0;
    %%Caclulate any changes to the catchment areas incured by moving NX(z) into
    %the catchment area for i.
    
    %Check if the current allocation of NX(z) is equal to that in the
    %initial solution, if so the weight w1 is added from including NX(z) in
    %the solution as the postcode is being moved from the intial solution
    %to a different cacthment area.
    if XC(NX(z),yr)==XI(NX(z))
        delta=delta+w1;
    elseif XI(NX(z))==i %Check if the intial solution has allocation of 
        %NX(z) in i (as the change beging made)-> improvement to objective
        delta=delta-w1;
    end

    
    
    %%Calculate any extra penalisation from moving postcode to
    %school i due to the classroom sizes
    %First check if the catchment area NX(z) is being moved into is
    %affected (more students in the classrooms)
    ftemp=0; %Calculate the current utilisation of classrooms.
    for j=1:length(XC)
        if XC(j,yr)==i
            ftemp=ftemp+pd(yr,1,j);
        end
    end   
    if ((ftemp-20*YC(i,yr))>0) %If classrooms are maxed introduce penalisation
        %to the additional students as a result from moving the postcode.
        delta=delta+p2*pd(yr,1,NX(z));
    elseif ((ftemp-20*YC(i,yr))<=0) && ((ftemp+pd(yr,1,NX(z))-20*YC(i,yr))>0)
        delta=delta+p2*((ftemp+pd(yr,1,NX(z))-20*YC(i,yr)));
    end
 

   %Next check any penalisation reductions from moving the postcode out of
   %its current catchment area.
    ftemp=0;
    for j=1:length(XC)
        if XC(j,yr)==XC(NX(z),yr)
            ftemp=ftemp+pd(yr,1,j);
        end
    end                
    if ((ftemp-20*YC(XC(NX(z),yr),yr))>0)
        delta=delta-p2*(min(pd(yr,1,NX(z)),ftemp-20*YC(XC(NX(z),yr),yr)));
    end
    
   
    %% Overlap penalisation estimation
    
    %%Method one: distance from school
    %Use an approximation for the overlap penalisation, if it is in the
    %polygon already we give it a penalisation of 0 otherwise it is
    %proportional to the distance from the school.
    
    ps=catchmentbd(XC, i, x, y,yr);
    if isinterior(ps, [x(NX(z)),y(NX(z))])>0
        %Update the change with the distance and a relevant caling factor!
        delta=delta+p3*sqrt((x(NX(z))-sx(i))^2+(y(NX(z))-sy(i))^2)/100;
    end
    
    %Method two: same method but penalisation of distance from closest 
    %point.
    
%     ps=catchmentbd(XC, i, x, y);
%     if isinterior(ps, [x(NX(z)),y(NX(z))])>0
%         smallestdist=1000000; %Set intiial distance to be high
%         for j=1:length(XC)
%             if XC(j,yr)==i
%                 if sqrt((x(NX(z))-x(XC(j,yr)))^2+(y(NX(z))-y(XC(j,yr)))^2)<smallestdist
%                     smallestdist=sqrt((x(NX(z))-x(XC(j,yr)))^2+(y(NX(z))-y(XC(j,yr)))^2);
%                     %Find the distance to the closest point inside i to
%                     %postcode with index NX(z).
%                 end
%             end
%         end  
%         %Update delta with the smallest distance penalisation adding an
%         %appropriate scaling factor (10)
%         delta=delta+10*smallestdist;
%     end
    

end