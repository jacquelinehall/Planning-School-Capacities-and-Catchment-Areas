
function [Xbest,Ybest,fbest,fintial]=LocalsearchfnP(XI,YI,x,y,pd,w1,w2,p1,p2,p3,Cv,sx,sy,L, compactmethod)
%This is for primary schools for which the data sets are not included


%%Local search function.
%Inputs:
%XI: initial postcodes in each catchment area
%YI: initial school capacities
%x: x coordinates for postcodes
%y: y coordinates for postcodes
%pd: number of students at each postcode in each year in each school
%w1: weight 1
%w2: weight 2
%p1: penalisation factor 1
%p2: penalisation factor 2
%School capacities
%sx: x coordinates of schools
%sy: y coordinates of schools
%L: Number of iteraions
%compactmethod: Method of compactness to be applied either 1 2 or 3
%corresponidng to the following measures: 
%1: Schwartzbergs method
%2: Distance based measure of all the pairwise distances
%3: Distance based measure to the school location of each catchment area

%Outputs: Best allocation of postcodes in each catchment are Xbest, best
%school capacities Ybest and best objective value fbest found through the local search
%with L iterations.


   %% Make current solution initial solution
    YC=YI; 
    XC=XI;
    
    %define the number of schools
    numberschools=length(YI);


    %Define place to store the best solutions
    Xbest=XI;
    Ybest=YI;
    %find intial capacities for XI
    C=classcap(XI,pd,Cv);
    %Define the initial objective
    fintial=objectivef(XI,YI,XI,YI,C,w1,w2,p1,p2,p3,pd,x,y);

    for k=1:L
        %Update the capacities for S1 in each school 
        C=classcap(XC,pd,Cv);
        deltabest=0;
        deltabest2=0;
        Xbestchange=0;
        Ybestchange=-10;
        %Generate a uniform rv to decide which neighbourhood to search
        u=rand;
        %Neighbourhood for moving postcodes
        if u<0.75
            for i=1:numberschools
                NX=neighbourhoodX1(XC, i, x,y);
                for z=1:length(NX)


                    %Check that compactness is satisfied by introducing the
                    %point in the neighbourhood into the data set. Not
                    %compactness is measured against 0.51 as this is the lowest
                    %ratio any boundary obtains through schwartzbergs
                    %XCtemp=XC(NX(z));
                    %XC(NX(z))=i;

                    %Calculate change to objective from including z

                    delta=obchangeX2(NX,z,i,XC,YC,XI,w1,p2,p3,pd,x,y,sx,sy);

                    if delta<deltabest
                        %Before improved solution can be accepted it must
                        %satisfy all constraints. First check balance as this
                        %is the simpliest constraint to check

                        %----BALANCE CONSTRAINT-------------------------------
                        %Check if the catchment area NX(z) still satisfies the
                        %balance constraint when postcode NX(z) is removed from
                        %the catchment area (affects lower limit). Next check
                        % if the catchment area i still satisfies balance after
                        %post code NX(z) is move into the catchment area (upper
                        % limit).
                        j1=XC(NX(z));
                        if isbalanced(XC,j1,pd,YC(j1),0,NX(z))>0 && isbalanced(XC,i,pd,YC(i),NX(z),0)<1000000000000000000000
                            %If balance constraints satisfied move check
                            %compactness

                            %----COMPACTNESS CONSTRAINTS---------------------------
                            %There are multiple approaches to compactness
                            %constraints that can be taken these are listed below
                            %and can be included in the code. Note: only one should
                            %be applied at a time, hence the one desired
                            %should be entered into compactmethod.
                            %------------------------------------------------------
                            if compactmethod==1
                                %---| 1 | Geometric approach: comment out below:
                                 %Primary schools below
                                if iscompact(XC, NX(z),i, x,y)>0%.72 %Initial solution 
                                %was 0.73 so set range as no more than 5% worse than
                                %intial compactness.
                                    deltabest=delta;
                                    Xbestindex=NX(z);
                                    Xbestchange=i;
                                end
                            elseif compactmethod==2
                                %---| 2 | Pairwise distance based:comment out below:
                                if iscompact2(XC, NX(z),i, x, y)<5 %Initial solution 
                                %was 4.3 so set range as no more than 5% worse than
                                %intial compactness.
                                    deltabest=delta;
                                    Xbestindex=NX(z);
                                    Xbestchange=i;
                                end
                            elseif compactmethod==3
                                %---| 3 | School distance based:comment out below:
                                if iscompact3(XC, NX(z),i, x, y,sx,sy)<160 %Initial 
                                %solution was 159 so set range as no more than 5% worse
                                %than intial compactness. 
                                    deltabest=delta;
                                    Xbestindex=NX(z);
                                    Xbestchange=i;
                                end
                            end
                        end
                    end 
                end
            end
            if Xbestchange>0
                %Update best found X solution if an improvement has been found
                Xbest(Xbestindex)=Xbestchange;
            end
        else %Look at neighbourhood for updating capacities
            for i=1:numberschools
                NY=neighbourhoodY1(YC, i);
                for z=1:length(NY)
                    %Caclulate change to objective from changing capacity for
                    %school i from YC(i) to NY(z)
                    delta=obchangeY2(NY,z,i,XC,YC,YI,C,w2,p1,p2,pd);
                    if delta<deltabest2
                        %Check balance constraint holds
                        if isbalanced(XC,i,pd,NY(z),0,0)>0 && isbalanced(XC,i,pd,NY(z),0,0)<300000000

                            deltabest2=delta;
                            Ybestindex=i;
                            Ybestchange=NY(z);
                        end
                    end
                end
            end
            if Ybestchange~=-10
                %Update best found Y solution if an improvement has been found
                Ybest(Ybestindex)=Ybestchange;
            end
        end
        %Update for the next iteration with the best found solution
        XC=Xbest;
        YC=Ybest;
    end
    %Calculate the final objective
    fbest=objectivef(Xbest,Ybest,XI,YI,C,w1,w2,p1,p2,p3,pd,x,y);
    
    
end