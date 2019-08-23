function delta=obchangeY2(NY,z,i,XC,YC,YI,C,w2,p1,p2,pd)
%% Compute the change in the objective from upating YC to be equal to NY(z)
    delta=0;
  
    %Calculate any changes to the capacity (THESE ARE CHANGES NOT COSTS 
    %FROM INCREASE CAPACITY)
    sigma=0;
    if NY(z)>YC(i)%If capacity is increased add w2
        if NY(z)<YI(i) 
            delta=delta+sigma*(NY(z)-YC(i));
        elseif YC(i)>YI(i)
            delta=delta+w2*(NY(z)-YC(i));
        else
            delta=delta+w2*(NY(z)-YI(i));
        end
    elseif NY(z)<YC(i) %If capacity is reduced minus w2
        %weighted by the reduction up to the capacity
        if YC(i)<YI(i)
            delta=delta-sigma*(YC(i)-NY(z));
        elseif NY(z)<YI(i) && YC(i)>YI(i)
            delta=delta-w2*(YC(i)-YI(i))-sigma*(YI(i)-NY(z));
        elseif NY(z)>YI(i)%&&YC(i)>YI(i)
            delta=delta-w2*(YC(i)-NY(z));
        end
    end


    %%Caclulate any changes in penalisation for capacity exceeded
    if YC(i)>=C(i) && NY(z)>YC(i) %If capacity is exceeded further add p1
        delta=delta+p1*(NY(z)-YC(i));
    elseif YC(i)>C(i) && NY(z)<C(i)
        delta=delta-p1*(YC(i)-C(i));
    elseif NY(z)<YC(i) && NY(z)>C(i)%If capacity is reduced minus p1
        %weighted by the reduction up to the capacity
        delta=delta-p1*(YC(i)-NY(z));
        %ADDED IN 13/08/19
        %vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    elseif YC(i)<=C(i) && NY(z)>C(i)
        delta=delta+p1*(NY(z)-C(i));
    end
    
    
    %Class sizes

        %Calculate any changes to the class sizes exceeded
        ftemp=0;
        for j=1:length(XC)
            if XC(j)==i
                ftemp=ftemp+pd(1,1,j);
            end
        end
        
       
        if (ftemp-20*YC(i))>0  %If currently have too many students in classes
            if NY(z)>YC(i) && (ftemp-20*NY(z))>0 %Capacity increased and 
                %and classrooms still exceeded
                delta=delta-p2*(20*NY(z)-20*YC(i));
            elseif NY(z)>YC(i) && (ftemp-20*NY(z))<=0 %capacity increased
                %and classrooms no longer exceeded
                delta=delta-p2*(ftemp-20*YC(z)); %THIS WAS OTHER WAY AROUND DOES THIS FIX IT?!?!!
            elseif NY(z)<YC(i) %Capacity reduced 
                delta=delta+p2*(20*YC(i)-20*NY(z)); %double check me if still not working
            end
        elseif (ftemp-20*NY(z))>0 %If classrooms not currently exceeded but 
            %reducing capacity cause them to be
            delta=delta+p2*(ftemp-20*NY(z));
        end


end
