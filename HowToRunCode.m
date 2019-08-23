%How to run code

%Note for all weightings p1 must be set equal to zero and p3=w3, F3 is to
%be ignored and F4=F3, F5=F4 in the dissertation notation.



%For LOCAL SEARCH ONLY
%Run the following parameters
load('Cv.mat')
load('Geodata.mat')
load('sx.mat')
load('sy.mat')
load('x.mat')
load('XI.mat')
load('y.mat')
load('YI.mat')

%Keep all files from either data generation, single year local search or 
%multi year local search in one folder



load('pd.mat') %Select which data set you want pd2 is also and option



%For local search
weights %Select what weighting you want applied

%For multi year
[Xbest,Ybest,fbest,fintial]=Localsearchfn(XI,YI,x,y,pd,w1,w2,p1,p2,p3,Cv,sx,sy,k, 1)


%For single year
% [Xbest,Ybest,fbest,fintial]=LocalsearchfnS(XI,YI,x,y,pd,w1,w2,p1,p2,p3,Cv,sx,sy,k, 1)


%Run the local search set k equal to the number of iterations desired.

%Results 

resultsoutput %obtain the breakdown of objective functions
% plotcatchment(Xbest, Geodata) %plot convex hull representation
% plotcatchmentpoints(Xbest, Geodata) %Plot point representation



%For DATA GENERATION ONLY-------------------------------
%Results stored in pd

% load('m.mat')
% load('num.mat')
% load('Schools.mat')
% load('txtData.mat')
% load('postcodes.mat')
% load('pd.mat')
% 
% PopGenMultiYr

