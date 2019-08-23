function bratio=isbalanced(XC,i,pd,YCi,yr, Xintoi, Xouti)
%% Calculate the ratio of utilisation of the schools

%% For general balance checks:
%Set Xintoi and Xouti as zero.

%% For updating solutions:
%Set XintoY=NX(z) if this postcode is being moved into catchment i
%and Xouti=0, if NX(z) is being moved out of catchment i set Xouti=NX(z)
%and XintoY=0

    %Calculate the number of students
    studentnos=0;
    for j=1:length(XC)
        if XC(j,yr)==i
            studentnos=studentnos+pd(yr,1,j);
        end
    end
    
    if Xintoi~=0
        studentnos=studentnos+pd(yr,1,Xintoi);
    end
    
    if Xouti~=0
        studentnos=studentnos-pd(yr,1,Xouti);
    end
    
    
    
 
    bratio=studentnos/(YCi*20);

end