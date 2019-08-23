function C=classcap(XC,pd,Cv)
%% Calculate the class capacities for S1, these are dependant on how many
%students are in the shcools already and if this number plus the maximum s1
%capacity exceeds the total school capacity

C=zeros(20,14);

for i=1:20
    for yr=1:14
        studentnos=0;
        for j=1:length(XC)
            if XC(j,yr)==i
                studentnos=studentnos+sum(pd(yr,2:6,j));
            end
        end
        if Cv(2,i)-studentnos<0 %If full capacity already exceeded S1 capacity=0
            C(i,yr)=0;
        elseif Cv(2,i)-studentnos<Cv(1,i)
            C(i,yr)=floor((Cv(2,i)-studentnos)/20);
        else
            C(i,yr)=floor(Cv(1,i))/20;
        end
    end
end






end