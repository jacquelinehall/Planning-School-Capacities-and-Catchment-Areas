%Results copy for Initial solution


w1=(10/length(XI))*(0.8);
%Scaling= number of classes
w2=(1/sum(YI))*(0.1);
%Scaling = large 
p1=1;
p2=1;
%Scaling = initial global compactness MIGHT BE TOO SMALL CANT SEE ANY
%CHANGE IN MAIN OBJECTIVE
p3=(1/9191800)*(0.1);


YC=YI;
XC=XI;
C=classcap(XC,pd,Cv);

numberschools=length(YI);


% Calculate f1
f1=sum(XC~=XI);

% Calculate f2
%Define the weighting on decreasing capacitiy as sigma
sigma=0; %DIVIDE SIGMA BY w2 ALWAYS!!!!!! AS IT IS MULTIPLED IN THE END!!!!
%SIGMA NOTE ^^^^^^
f2=0;
for i=1:numberschools
    if YC(i)>YI(i)
        f2=f2+YC(i)-YI(i);
    else
        f2=f2-sigma*(YI(i)-YC(i));
    end
end

% Calculate f3
f3=0;
for i=1:numberschools
    if YC(i)>C(i)
        f3=f3+(YC(i)-C(i));
    end
end


% Calculate f4

%NOTE this is using the 2019 prediction numbers for S11 in pd

f4=0;
for i=1:numberschools
    ftemp=0;
    for j=1:length(XC)
        if XC(j)==i
            ftemp=ftemp+pd(1,1,j);
        end
    end
    if (ftemp-20*YC(i))>0
       f4=f4+ftemp-20*YC(i);
    end
end




% Calculate f5 overlap penalisation (global compactness)

f5=0;


for i=1:numberschools
    %Collect all the polyshapes for the catchment areas
    psi=catchmentbd(XC, i, x, y);
    ps(i)=psi;
end


%Calculate the total sum of area of overlap (note this is divided by 2 for 
%duplicate counting).
for i=1:numberschools
    for j=1:numberschools
        if i~=j
            f5=f5+area(intersect(ps(i),ps(j)))/2;
        end
    end
end

f=w1*f1+w2*f2+p1*f3+p2*f4+p3*f5
f1
f2
f3
f4
f5

%plotcatchmentpoints(Xbest, Geodata,numberschools)
%for the convex hull representation
%plotcatchment(Xbest, Geodata,numberschools)