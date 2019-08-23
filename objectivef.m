function f=objectivef(XC,YC,XI,YI,C,w1,w2,p1,p2,p3,pd,x,y)
%% Objective function

%Load in pd(1,1,:) for S1 2019 so we have the number of students coming from each
%postcode

%define the number of schools
numberschools=length(YI);


%% Calculate f1
f1=sum(XC~=XI);

%% Calculate f2
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

%% Calculate f3
f3=0;
for i=1:numberschools
    if YC(i)>C(i)
        f3=f3+(YC(i)-C(i));
    end
end


%% Calculate f4

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




%% Calculate f5 overlap penalisation (global compactness)

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

%Point based appracoh to global compactness
% %TAKES TOO LONG TO RUN!
% %Calculate the total sum of points in overlap (note this is divided by 2 for 
% %duplicate counting).
% for i=1:20
%     for j=1:20
%         if i~=j
%             for k=1:length(x)
%                 if isinterior(intersect(ps(i),ps(j)),[x(k),y(k)])==1
%                    f5=f5+1/2;
%                 end
%             end
%         end
%     end
% end


%% Complete objective function
f=w1*f1+w2*f2+p1*f3+p2*f4+p3*f5;

end