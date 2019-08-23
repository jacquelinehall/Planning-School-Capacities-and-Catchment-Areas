%Tests to measure the accuracy of each local compactness measure in 
%comparison to the other compactness measures. The average values from each
%compactness test are taken, aswell as the best and worst values. The
%outputs are stored in 3 matrix cv, wcv and bcv respectively, each row
%corresponds to the local search ran on the corresponding row numbers
%compactness measure given below. Each column represents the solutions from
%the local search run against the corresponding columns compactness
%measure. The runtime for the local search ran on each compactness measure
%is also recorded in runtimes.

%Compactness measures in question
%1: Schwartzbergs method
%2: Distance based measure of all the pairwise distances
%3: Distance based measure to the school location of each catchment area

%Define the number of iterations to test over
L=100;

%Matrix to store the count the average different between the compactness
%measure used for the solution and the other compactness measures.
cv=zeros(3);
%Matrix to store the worst value for each compactness measure (worst value
%at a given school)
wcv=zeros(3);
%And best values
bcv=zeros(3);

%Array to store the run time for each compactness measure
runtimes=[0,0,0];

%Iterate over each of the compactness measures
for compacts=1:3
    %Run the number of iterations on local search for each compactness
    %measure and record the time this takes
    tic;
    [Xbest,Ybest,fbest]=Localsearchfn(XI,YI,x,y,pd,w1,w2,p1,p2,C,sx,sy,L, compacts);
    runtimes(compacts)=toc;
    %Set counters for each values to zero
    cvs=[0,0,0];
    temps=[0,0,0];
    %Define benchmarks to measure the worst and best solutions against
    b1=[10,0,0];
    b2=[0,10000,10000];
    for igt=1:20
        temps(1)=FULLiscompact(Xbest, x, y,igt);
        temps(2)=FULLiscompact2(Xbest, x, y, igt);
        temps(3)=FULLiscompact3(Xbest, x, y, sx, sy, igt);
        cvs(1)=cvs(1)+temps(1);
        cvs(2)=cvs(2)+temps(2);
        cvs(3)=cvs(3)+temps(3);
        %Find the worst solutions for the schools
        if temps(1)<b1(1)
            b1(1)=temps(1);
        end
        if temps(2)>b1(2)
            b1(2)=temps(2);
        end
        if temps(3)>b1(3)
            b1(3)=temps(3);
        end
        %Find the best solutions for the schools
        if temps(1)>b2(1)
            b2(1)=temps(1);
        end
        if temps(2)<b2(2)
            b2(2)=temps(2);
        end
        if temps(3)<b2(3)
            b2(3)=temps(3);
        end
    end

    for jgt=1:3
        %Average out each of the values associated with each compactness for
        %all schools
        cv(jgt,compacts)=cvs(jgt)/20;
        %Find the worst solutions for each compactness measure
        wcv(jgt,compacts)=b1(jgt);
        %And the best
        bcv(jgt,compacts)=b2(jgt);
    end

end
%% OUTPUTS

%NOTE: when analsying solutions for first row a higher solution is better,
%and for the other two a lower solution is better and middle element is the
%benchmark.


%Find normalised differences in average and worst compactness measures
%compared to the other ones
cv(1,:)=cv(1,:)/cv(1,1);
cv(2,:)=cv(2,:)/cv(2,2);
cv(3,:)=cv(3,:)/cv(3,3);
cv

wcv(1,:)=wcv(1,:)/wcv(1,1);
wcv(2,:)=wcv(2,:)/wcv(2,2);
wcv(3,:)=wcv(3,:)/wcv(3,3);
wcv

bcv(1,:)=bcv(1,:)/bcv(1,1);
bcv(2,:)=bcv(2,:)/bcv(2,2);
bcv(3,:)=bcv(3,:)/bcv(3,3);
bcv

runtimes


%Second data set pd2

%25 iterations

% cv =
% 
%     1.0000    1.0011    1.0003
%     0.9998    1.0000    0.9998
%     1.0004    1.0007    1.0000
% 
% 
% wcv =
% 
%     1.0000    0.9960    1.0091
%     1.0027    1.0000    1.0039
%     1.0000    1.0000    1.0000
% 
% 
% bcv =
% 
%      1     1     1
%      1     1     1
%      1     1     1
% 
% 
% runtimes =
% 
%   226.8193  297.7945  297.0650


%50 iterations

% cv =
% 
%     1.0000    1.0001    1.0002
%     1.0000    1.0000    1.0002
%     0.9995    0.9993    1.0000
% 
% 
% wcv =
% 
%     1.0000    1.0000    0.9942
%     0.9988    1.0000    0.9961
%     1.0000    1.0000    1.0000
% 
% 
% bcv =
% 
%      1     1     1
%      1     1     1
%      1     1     1
% 
% 
% runtimes =
% 
%   511.0314  520.9484  576.9902



%75 iterations

% 
% cv =
% 
%     1.0000    1.0000    1.0000
%     0.9997    1.0000    0.9998
%     0.9998    1.0006    1.0000
% 
% 
% wcv =
% 
%     1.0000    0.9942    1.0000
%     1.0039    1.0000    1.0027
%     1.0000    1.0000    1.0000
% 
% 
% bcv =
% 
%      1     1     1
%      1     1     1
%      1     1     1
% 
% 
% runtimes =
% 
%   633.7621  788.0094  620.4532






%100 iterations


% cv =
% 
%     1.0000    1.0148    1.0148
%     0.9999    1.0000    1.0000
%     0.9997    1.0000    1.0000
% 
% 
% wcv =
% 
%     1.0000    1.1668    1.1668
%     1.0034    1.0000    1.0000
%     1.0000    1.0000    1.0000
% 
% 
% bcv =
% 
%     1.0000    1.0000    1.0000
%     0.9872    1.0000    1.0000
%     1.0000    1.0000    1.0000
% 
% 
% runtimes =
% 
%    1.0e+03 *
% 
%     0.9249    1.0381    1.0131




















%First data set pd

%25 iterations
% 
% cv =
% 
%     1.0000    0.9987    0.9987
%     1.0001    1.0000    1.0000
%     0.9999    1.0002    1.0000
% 
% 
% wcv =
% 
%     1.0000    0.9998    1.0082
%     1.0026    1.0000    0.9994
%     1.0000    1.0000    1.0000
% 
% 
% bcv =
% 
%      1     1     1
%      1     1     1
%      1     1     1
% 
% 
% runtimes =
% 
%   238.7271  261.0054  281.7821

% 50 iteration results localcompactcomparison
% 
% cv =
% 
%     1.0000    1.0116    1.0104
%     1.0003    1.0000    1.0000
%     0.9993    0.9995    1.0000
% 
% 
% wcv =
% 
%     1.0000    1.1422    1.1422
%     1.0054    1.0000    0.9967
%     1.0000    1.0000    1.0000
% 
% 
% bcv =
% 
%     1.0000    1.0000    1.0000
%     0.9918    1.0000    1.0117
%     1.0000    1.0000    1.0000
% 
% 
% runtimes =
% 
%   542.8744  462.5976  585.9571

%75 its
% cv =
% 
%     1.0000    1.0002    1.0002
%     1.0000    1.0000    1.0000
%     1.0000    1.0000    1.0000
% 
% 
% wcv =
% 
%      1     1     1
%      1     1     1
%      1     1     1
% 
% 
% bcv =
% 
%      1     1     1
%      1     1     1
%      1     1     1
% 
% 
% runtimes =
% 
%   809.7063  868.6887  877.7655


%100 its
% localcompactcomparison
% 
% cv =
% 
%     1.0000    0.9986    0.9986
%     0.9999    1.0000    1.0000
%     0.9995    1.0000    1.0000
% 
% 
% wcv =
% 
%     1.0000    0.9963    0.9963
%     1.0033    1.0000    1.0000
%     1.0000    1.0000    1.0000
% 
% 
% bcv =
% 
%     1.0000    1.0000    1.0000
%     0.9884    1.0000    1.0000
%     1.0000    1.0000    1.0000
% 
% 
% runtimes =
% 
%    1.0e+03 *
% 
%     0.9977    1.0797    1.1044

