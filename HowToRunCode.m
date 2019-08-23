%How to run code

%Run the following

Secondaryschooldatareadin %Read in the secondary school data
load('pd.mat') %Select which data set you want
weights %Select what weighting you want applied
[Xbest,Ybest,fbest,fintial]=Localsearchfn(XI,YI,x,y,pd,w1,w2,p1,p2,p3,Cv,sx,sy,k, 1)
%Run the local search set k equal to the number of iterations desired.

%Results 

resultsoutput %obtain the breakdown of objective functions
% plotcatchment(Xbest, Geodata) %plot convex hull representation
% plotcatchmentpoints(Xbest, Geodata) %Plot point representation
