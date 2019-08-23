%% Secondary school data read-in

%%Read in the data from the postcode data set
Geodata = xlsread("SecondaryPostcodeGeo.csv");
[~,txtData]  = xlsread('SecondaryPostcodeGeo.csv', 'F:F');
postcodes=txtData(2:length(txtData),:);

%Read in the school names
[~,Schools]  =xlsread("Secondary_Projections_2018_11_08_PUBLISHED.xlsx", 'Projection Summary','V:V');

%Create empty matrix to store the school capacities for S1 and total school
Cv=zeros(2,20);
%Create empty vector to store the current school cacpacities in class
%numbers
YI=zeros(1,20);

for sch=1:20 %Iterate over the schools (sheet names in excel file)
   %Read in the total student numbers for S1 and the whole school
   Cv(1,sch)=xlsread('Secondary_Projections_2018_11_08_PUBLISHED.xlsx',Schools{sch},'C7');
   Cv(2,sch)=xlsread('Secondary_Projections_2018_11_08_PUBLISHED.xlsx',Schools{sch},'C6');
   if sch==12 %The 12th school ' JAMESG' has slightly changed position of graph
       YI(1,sch)=ceil(xlsread('Secondary_Projections_2018_11_08_PUBLISHED.xlsx',Schools{sch},'T18')/20);
   else
       YI(1,sch)=ceil(xlsread('Secondary_Projections_2018_11_08_PUBLISHED.xlsx',Schools{sch},'R18')/20);
   end
end

%Define initial the postcode allocations
XI=Geodata(:,7);
for j=1:length(Geodata)
    if XI(j)==21
        XI(j)=4;
    elseif XI(j)==22
        XI(j)=18;
    end
end

% Read in the school postcode coordinates 
sx=[];
sy=[];

%General
% sx=xlsread("SecondaryLocations.csv", 'C:C');
% sy=xlsread("SecondaryLocations.csv", 'D:D');
%Quicker for secondary schools
sx=xlsread("SecondaryLocations.csv", 'C2:C21');
sy=xlsread("SecondaryLocations.csv", 'D2:D21');


%Get the coordinates of every postcode
x=[];
y=[];
for j=1:length(Geodata)
        x=[x,Geodata(j,3)];
        y=[y,Geodata(j,4)];
end
