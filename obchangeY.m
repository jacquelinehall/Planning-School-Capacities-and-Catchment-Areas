function delta=obchangeY(NY,z,i,XC,YC,YI,C,w2,p1,p2,pd,yr)
%% Compute the change in the objective from upating YC to be equal to NY(z)
    delta=0;

    %Calculate any changes to the capacity (THESE ARE CHANGES NOT COSTS 
    %FROM INCREASE CAPACITY)
    sigma=0;
    if NY(z)>YC(i,yr)%If capacity is increased add w2
        if NY(z)<YI(i) 
            delta=delta+sigma*(NY(z)-YC(i,yr));
        elseif YC(i,yr)>YI(i)
            delta=delta+w2*(NY(z)-YC(i,yr));
        else
            delta=delta+w2*(NY(z)-YI(i));
        end
    elseif NY(z)<YC(i,yr) %If capacity is reduced minus w2
        %weighted by the reduction up to the capacity
        if YC(i,yr)<YI(i)
            delta=delta-sigma*(YC(i,yr)-NY(z));
        elseif NY(z)<YI(i)
            delta=delta-w2*(YC(i,yr)-YI(i))-sigma*(YI(i)-NY(z));
        elseif NY(z)>YI(i)
            delta=delta-w2*(YC(i,yr)-NY(z));
        end
    end

    
    
    %%Caclulate any changes in penalisation for capacity exceeded
    if YC(i,yr)>=C(i,yr) && NY(z)>YC(i,yr) %If capacity is exceeded further add p1
        delta=delta+p1*(NY(z)-YC(i,yr));
    elseif YC(i,yr)>C(i,yr) && NY(z)<C(i,yr)
        delta=delta-p1*(YC(i,yr)-C(i,yr));
    elseif NY(z)<YC(i,yr) && NY(z)>C(i,yr)%If capacity is reduced minus p1
        %weighted by the reduction up to the capacity
        delta=delta-p1*(YC(i,yr)-NY(z));
    elseif YC(i,yr)<=C(i,yr) && NY(z)>C(i,yr)
        delta=delta+p1*(NY(z)-C(i,yr));
    end

    
        %Calculate any changes to the class sizes exceeded
        ftemp=0;
        for j=1:length(XC)
            if XC(j,yr)==i
                ftemp=ftemp+pd(yr,1,j);
            end
        end
        
        
       
        if (ftemp-20*YC(i,yr))>0  %If currently have too many students in classes
            if NY(z)>YC(i,yr) && (ftemp-20*NY(z))>0 %Capacity increased and 
                %and classrooms still exceeded
                delta=delta-p2*(20*NY(z)-20*YC(i,yr));
            elseif NY(z)>YC(i,yr) && (ftemp-20*NY(z))<=0 %capacity increased
                %and classrooms no longer exceeded
                delta=delta-p2*(ftemp-20*YC(i,yr));
            elseif NY(z)<YC(i,yr) %Capacity reduced 
                delta=delta+p2*(20*YC(i,yr)-20*NY(z));
            end
        elseif (ftemp-20*NY(z))>0 %If classrooms not currently exceeded by 
            %reducing capacity cause them to be
            delta=delta+p2*(ftemp-20*NY(z));
        end
        


end
