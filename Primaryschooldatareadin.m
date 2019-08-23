%% Secondary school data read-in

%%Read in the data from the postcode data set
Geodata = xlsread("PrimaryPostcodeGeo.csv");
[~,txtData]  = xlsread('PrimaryPostcodeGeo.csv', 'F:F');
postcodes=txtData(2:length(txtData),:);

%Read in the school names
[~,Schools]  =xlsread("Primary_Projections_2018_11_08_PUBLISHED.xlsx", 'Projection_Summary','AD:AD');




%Create empty vector to store the current achool cacpacities in class
%numbers
YI=zeros(1,length(Schools));

%Read in the total student numbers for P1 and the whole school
%Cv is now a vector as the primary schools do not have a capacity
%specifically for P1, so only the total capacity is stored.
Cv=xlsread("Primary_Projections_2018_11_08_PUBLISHED.xlsx", 'Projection_Summary','AG:AG');
Cv=Cv';
for sch=1:72 %Iterate over the schools (sheet names in excel file)
      YI(1,sch)=ceil(xlsread('Primary_Projections_2018_11_08_PUBLISHED.xlsx',Schools{sch},'C64')/20);
end


%Define initial the postcode allocations
XI=Geodata(:,5);
for j=1:length(Geodata)
    if XI(j)==73
        XI(j)=12;
    elseif XI(j)==74
        XI(j)=55;
    elseif XI(j)==75
        XI(j)=71;
    end
end

% Read in the school postcode coordinates 
sx=[];
sy=[];

%General
% sx=xlsread("PrimaryLocations.csv", 'C:C');
% sy=xlsread("PrimaryLocations.csv", 'D:D');
%Quicker for primary schools
sx=xlsread("PrimaryLocations.csv", 'C2:C74');
sy=xlsread("PrimaryLocations.csv", 'D2:D74');


%Define the weights and penalisation factors, the first component given is
%the scaling factor and the seond is the weight. (note: p1 and p2 do not
%have a weight as we aim to get these objectives to zero).
%Scaling= number of postcodes
w1=(10/length(XI))*(1/3);
%Scaling= number of classes
w2=((1/sum(YI))/2)*(1/3);
%Scaling = large 
p1=((1/sum(YI))/2)*(1/3);
p2=10000;
%Scaling = initial global compactness 
p3=(1/3782088)*(1/3);

%Get the coordinates of every postcode
x=[];
y=[];
for j=1:length(Geodata)
        x=[x,Geodata(j,1)];
        y=[y,Geodata(j,2)];
end