function pwdist=iscompact2(XC, ni, i, x, y)
%%Local compactness measure using distance based measure of all the pairwise 
% distances
pwdist=0;

XCi=find(XC==i);

 for k=1:length(XCi)
     for j=1:length(XCi)
         if k~=j
             %Calculate the scaled distance
             pwdist=pwdist+sqrt((x(XCi(k))-x(XCi(j)))^2+(y(XCi(k))-y(XCi(j)))^2);
         end
     end
     pwdist=pwdist+sqrt((x(XCi(k))-x(ni))^2+(y(XCi(k))-y(ni))^2);
 end

 pwdist=pwdist/(length(XCi)+1)/100000;
 
 %Checked this works!
end