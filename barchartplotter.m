%plot barchat over the years

%Initialise the current capacity plan as the initial plan.
for yr=1:14
        YC(:,yr)=YI(1,:); 
        XC(:,yr)=XI(:,1);
    end

bargraph=bar((Ybest-YC)','stacked');
xlabel('Years after 2018','fontsize', 22);
ylabel('Number of capacity increases in each school', 'fontsize', 22);
legend(bargraph, {'1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20'});
set(gca,'FontSize',22)

%Note bar graph is built from bottom up so number 1 is at the bottom ect




