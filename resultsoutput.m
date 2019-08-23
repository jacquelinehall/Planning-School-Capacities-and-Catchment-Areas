%reults run to obtain sections of the results

%Best found solution
XC=Xbest;
YC=Ybest;

% %Intial
%     for yr=1:14
%         YC(:,yr)=YI(1,:);  
%         XC(:,yr)=XI(:,1);
%     end


numberschools=length(YI);


f1=0;
for yr=1:14
    f1=f1+sum(XC(:,yr)~=XI);
end

%% Calculate f2
%Define the weighting on decreasing capacitiy as sigma
sigma=0; %Note: sigma is scaled by the penalisation factor in the final 
%objective
f2=0;
for yr=1:14
    for i=1:20
        if YC(i,yr)>YI(i)
            f2=f2+YC(i,yr)-YI(i);
        else
            f2=f2-sigma*(YI(i)-YC(i,yr));
        end
    end
end

%% Calculate f4


f4=0;
for yr=1:14
    for i=1:20
        ftemp=0;
        for j=1:length(XC)
            if XC(j,yr)==i
                ftemp=ftemp+pd(yr,1,j);
            end
        end
        if (ftemp-20*YC(i,yr))>0
           f4=f4+ftemp-20*YC(i,yr);
        end
    end
end



%% Calculate f5 overlap penalisation (global compactness)

f5=0;


for yr=1:14
    for i=1:20
        %Collect all the polyshapes for the catchment areas
        psi=catchmentbd(XC, i, x, y,yr);
        ps(i)=psi;
    end

    %Calculate the total sum of area of overlap (note this is divided by 2 for 
    %duplicate counting).
    for i=1:20
        for j=1:20
            if i~=j
                f5=f5+area(intersect(ps(i),ps(j)))/2;
            end
        end
    end
end

%% Complete objective function
f=w1*f1+w2*f2+p2*f4+p3*f5;


f1
f2

f4
f5
f



 