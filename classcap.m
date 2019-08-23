function C=classcap(XC,pd,Cv)
%% Calculate the class capacities for S1 or P1, these are dependant on how many
%students are in the shcools already and if this number plus the maximum s1
%capacity exceeds the total school capacity



[sn,sm]=size(Cv);
if sn==1 %Primary school data
    C=zeros(1,sm);
        for i=1:72
            studentnos=0;
            for j=1:length(XC)
                if XC(j)==i
                    studentnos=studentnos+sum(pd(1,2:7,j));
                end
            end

            if Cv(1,i)-studentnos>0
                %Class sizes for primary school are approx 20?
                C(1,i)=ceil((Cv(1,i)-studentnos)/20); %changed from floor to ciel?
            else
                 C(1,i)=0;
            end
        
        end

else %Secondary school data
C=zeros(1,20);
    for i=1:20
        studentnos=0;
        for j=1:length(XC)
            if XC(j)==i
                studentnos=studentnos+sum(pd(1,2:6,j));
            end
        end
        if Cv(2,i)-studentnos<Cv(1,i) && Cv(2,i)-studentnos>0
            C(1,i)=floor((Cv(2,i)-studentnos)/20);
        elseif Cv(2,i)-studentnos<0
            C(1,i)=0;
        else
            C(1,i)=floor(Cv(1,i))/20;
        end

    end
end






end