function NY=neighbourhoodY1(YC, i)
%Assume neighbourhood for capacitiy is +/-2 for each school
    NY=[];
    if YC(i)>1
        mincap=YC(i)-1;
    else
        mincap=0;
    end
    maxcap=YC(i)+2;
    for p=mincap:maxcap
        NY=[NY,p];
    end
end