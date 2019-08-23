function schdist=FULLiscompact3(XC, x, y,sx, sy,i)
%%Local compactness measure using distance based measure to the school
%%location of each catchment area
schdist=0;

XCi=find(XC==i); 

for k=1:length(XCi)
         schdist=schdist+sqrt((x(XCi(k))-sx(i))^2+(y(XCi(k))-sy(i))^2);
end

schdist=schdist/(length(XCi)+1)/10;

%Tested should be working
end