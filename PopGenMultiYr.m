%% Code to generate a random postcode allocation of students in each school
%year for the years 2019-3032, based upon the predicted number of students
%in each school and their associated current catchment areas.

%MAKE SURE TO CHANGE SEED FOR MULTIPLE DATA SETS

% %% Read in the data from the two data sets
% num = xlsread("SecondaryPostcodeGeo.csv");
% [~,txtData]  = xlsread('SecondaryPostcodeGeo.csv', 'F:F');
% postcodes=txtData(2:length(txtData),:);
% 
% %Store the names of the school sheets to use, note these need to be
% %included in the excel sheet for the code to work and read all sheets from
% %the file
% [~,Schools]  =xlsread("Secondary_Projections_2018_11_08_PUBLISHED.xlsx", 'Projection Summary','V:V');
% 
% %Create empty 3D array to store all the different school years projections 
% %for each school each year.
% m=zeros(14,6,20);
% 
% for sch=1:20 %Iterate over the schools (sheet names in excel file)
%     if sch==12 %The 12th school ' JAMESG' has slightly changed position of graph
%           m(:,:,sch)=xlsread('Secondary_Projections_2018_11_08_PUBLISHED.xlsx',Schools{sch},'T41:Y54');
%     else
%         m(:,:,sch)=xlsread('Secondary_Projections_2018_11_08_PUBLISHED.xlsx',Schools{sch},'R41:W54');
%     end
% end

%% Determine the start and end index for each school, this will give us the
% postcodes in each schools catchment area
startid=[];
endid=[];
%Define a counter x
x=1;
%NOTE: start id and end id relative to the cell number therefore index has 
%to be -1 later on due to the cells starting at 2
startid=[startid,2];

for i=1:length(postcodes)
        if num(i,7)~=x
            endid=[endid,i-1];
            startid=[startid,i];
            x=x+1;
        end
end
endid=[endid,i];

%For each school number of postcodes is endid(i)-startid(i)+1
%School 21 is the same as school 4 and
%School 22 is the same as 18

%Calculate number of postcodes for each school
p=[];
for i=1:20
    if i==4
        p=[p,endid(i)-startid(i)+1+endid(21)-startid(21)+1];
    elseif i==18
        p=[p,endid(i)-startid(i)+1+endid(22)-startid(22)+1];
    else;
        p=[p,endid(i)-startid(i)+1];
    end
end

%% %% Generate the postcode distribution for the 20 schools over all years

%3D array of postcode density for each year and each year group within the
%school
pd=zeros(14,6,length(postcodes));




for yr=1:14 %iterate over every year
    if yr==1 %If in the first year we need to generate the postcode 
        %locations for all students
        s1=6;
    else
        %If not in the first year (2019) all the students already have
        %postcode allocations, so need to look at changes to the numbers
        %and if there is an increase add new postcodes, if a decrease
        %remove old postcodes. NOTE ASSUMPTION: assumption that the any
        %increase in capactity is only new comers and ny decrease is only
        %drop outs.
        s1=1;
        %Update the older years
        for k=2:6 %Iterate over remaining school years
            %Ratio to ensure no more than this amount of students occur at any postcode
            ratio=m(yr,k,i)/p(i)*5+10;
            for i=1:20 %Iterate over schools
                %Special cases
                if k==4
                    pd(yr,k,startid(i):endid(i))=pd(yr-1,k-1,startid(i):endid(i));
                    pd(yr,k,startid(21):endid(21))=pd(yr-1,k-1,startid(21):endid(21));
                elseif i==18
                    pd(yr,k,startid(i):endid(i))=pd(yr-1,k-1,startid(i):endid(i));
                    pd(yr,k,startid(22):endid(22))=pd(yr-1,k-1,startid(22):endid(22));
                else %Standard case
                    pd(yr,k,startid(i):endid(i))=pd(yr-1,k-1,startid(i):endid(i));
                end
                %If there is changes in the student numbers being carried
                %over from the previous year
                if m(yr,k,i)~=m(yr-1,k-1,i)
                     if m(yr,k,i)>m(yr-1,k-1,i) 
                        %new students
                        changefactor=1;
                     else
                        %Dropouts
                        changefactor=-1;
                     end
                     studentchange=m(yr,k,i)-m(yr-1,k-1,i);
                     students=0;
                      if i==4
                            while students~=studentchange
                                u=round(p(i)*rand);
                                if startid(i)+u<endid(i)+changefactor
                                    if pd(yr,k,startid(i)+u-1)+changefactor>=0 && pd(yr,k,startid(i)+u-1)+changefactor<ratio
                                        pd(yr,k,startid(i)+u-1)=pd(yr,k,startid(i)+u-1)+changefactor;
                                        students=students+changefactor; 
                                    end
                                else
                                    if pd(yr,k,startid(21)+u-endid(i)-1)+changefactor>=0 && pd(yr,k,startid(21)+u-endid(i)-1)+changefactor<ratio
                                        pd(yr,k,startid(i)+startid(21)+u-endid(i)-2)=pd(yr,k,startid(i)+startid(21)+u-endid(i)-2)+changefactor;
                                        students=students+changefactor; 
                                    end 
                                end
                            end
                        elseif i==18
                            while students~=studentchange
                                        u=round(p(i)*rand);
                                if startid(i)+u<endid(i)+changefactor
                                    if pd(yr,k,startid(i)+u-1)+changefactor>=0 && pd(yr,k,startid(i)+u-1)+changefactor<ratio
                                        pd(yr,k,startid(i)+u-1)=pd(yr,k,startid(i)+u-1)+changefactor;
                                        students=students+changefactor; 
                                    end
                                else
                                    if pd(yr,k,startid(22)+u-endid(i)-1)+changefactor>=0 && pd(yr,k,startid(22)+u-endid(i)-1)+changefactor<ratio
                                        pd(yr,k,startid(i)+startid(22)+u-endid(i)-2)=pd(yr,k,startid(i)+startid(22)+u-endid(i)-2)+changefactor;
                                        students=students+changefactor; 
                                    end 
                                end
                            end
                        else %General loop for the normal data set
                            while students~=studentchange
                                u=round(p(i)*rand);
                                if pd(yr,k,startid(i)+u-1)+changefactor>=0 && pd(yr,k,startid(i)+u-1)+changefactor<ratio
                                    pd(yr,k,startid(i)+u-1)=pd(yr,k,startid(i)+u-1)+changefactor;
                                    students=students+changefactor; 
                                end
                            end
                      end
                end
            end
        end
    end
    
    %Generate postcode data for new students (S1) or all students in 2019
    for k=1:s1 %Iterate over each school year    
    %Iterate over each school
        %Ratio to ensure no more than this amount of students occur at any postcode
        ratio=m(yr,k,i)/p(i)*5+10;
        for i=1:20
            %Intiialise number of students as zero
            students=0;
            if i==4 %& startid(i)
                while students~=m(yr,k,i)
                    u=round(p(i)*rand);
                    if startid(i)+u<endid(i)+1
                        if pd(yr,k,startid(i)+u-1)+1<ratio
                            pd(yr,k,startid(i)+u-1)=pd(yr,k,startid(i)+u-1)+1;
                            students=students+1; 
                        end
                    else
                        if pd(yr,k,startid(21)+u-endid(i)-1)+1<ratio
                            pd(yr,k,startid(i)+startid(21)+u-endid(i)-2)=pd(yr,k,startid(i)+startid(21)+u-endid(i)-2)+1;
                            students=students+1; 
                        end 
                    end
                end
            elseif i==18
                while students~=m(yr,k,i)
                            u=round(p(i)*rand);
                    if startid(i)+u<endid(i)+1
                        if pd(yr,k,startid(i)+u-1)+1<ratio
                            pd(yr,k,startid(i)+u-1)=pd(yr,k,startid(i)+u-1)+1;
                            students=students+1; 
                        end
                    else
                        if pd(yr,k,startid(22)+u-endid(i)-1)+1<ratio
                            pd(yr,k,startid(i)+startid(22)+u-endid(i)-2)=pd(yr,k,startid(i)+startid(22)+u-endid(i)-2)+1;
                            students=students+1; 
                        end 
                    end
                end
            else %General loop for the normal data set
                while students~=m(yr,k,i)
                    u=round(p(i)*rand);
                    if pd(yr,k,startid(i)+u-1)+1<ratio
                        pd(yr,k,startid(i)+u-1)=pd(yr,k,startid(i)+u-1)+1;
                        students=students+1; 
                    end
                end
            end
        end
    end 
end

%Fix any negatives
pd(pd<0)=0;
