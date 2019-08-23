function NY=neighbourhoodY1(YC, i,yr)
%Assume neighbourhood for capacitiy is +/-2 for each school
    NY=[];
    if YC(i,yr)>1
        mincap=YC(i,yr)-1;
    else
        mincap=0;
    end
    maxcap=YC(i,yr)+10;
    for p=mincap:maxcap
        NY=[NY,p];
    end
end