function plotstudentdensity(pd,x,y)
    s0=[];
    s1=[];
    s2=[];
    s3=[];
    s4=[];

    for j=1:length(x)
        
        if pd(1,1,j)==0
            s0=[s0,j];
        elseif pd(1,1,j)==1
           s1=[s1,j];
        elseif pd(1,1,j)==2
            s2=[s2,j];
        elseif pd(1,1,j)==3
            s3=[s3,j];
        else
            s4=[s4,j];
        end
        
    end



hold on
scatter(x(s0),y(s0),20,[1,1,0],'filled');
scatter(x(s1),y(s1),20,[1,0.7,0],'filled');
scatter(x(s2),y(s2),20,[1,0.5,0],'filled');
scatter(x(s3),y(s3),20,[1,0.2,0],'filled');
scatter(x(s4),y(s4),20,[0.8,0,0],'filled');
lgd=legend('0','1','2','3','4');
lgd.FontSize = 22;
lgd.Location='southeast';
title(lgd,'Number of S1 students','FontSize',22)
title("Number of S1 students per postcode in 2019",'FontSize',22)
%set(gca,'Color','k')
hold off

end







