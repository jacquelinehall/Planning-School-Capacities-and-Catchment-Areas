function plotyearlystudentdensity(pd1,x,y)


    s0=[];
    s1=[];
    s2=[];
    s3=[];
    s4=[];
    s5=[];
    s6=[];
    s7=[];
    s8=[];

    for j=1:length(x)
        
        if pd1(j)==0
            s0=[s0,j];
        elseif pd1(j)==1
           s1=[s1,j];
        elseif pd1(j)==2
            s2=[s2,j];
        elseif pd1(j)==3
            s3=[s3,j];
       elseif pd1(j)==4
           s4=[s4,j];
        elseif pd1(j)==5
            s5=[s5,j];
        elseif pd1(j)==6
            s6=[s6,j];
        elseif pd1(j)==7
            s7=[s7,j];
        else
            s8=[s8,j];
        end
         
    end



hold on
scatter(x(s0),y(s0),20,[1,1,0.5],'filled');
scatter(x(s1),y(s1),20,[1,0.8,0],'filled');
scatter(x(s2),y(s2),20,[1,0.6,0],'filled');
scatter(x(s3),y(s3),20,[1,0.4,0],'filled');
scatter(x(s4),y(s4),20,[1,0.2,0],'filled');
scatter(x(s5),y(s5),20,[0.8,0.2,0],'filled');
scatter(x(s6),y(s6),20,[0.6,0.2,0],'filled');
scatter(x(s7),y(s7),20,[0.4,0.2,0],'filled');
scatter(x(s8),y(s8),20,[0.2,0,0],'filled');
lgd=legend('0','1','2','3','4','5','6','7','8');
lgd.FontSize = 22;
lgd.Location='southwest';
%title(lgd,'Number of S1 students','FontSize',22)
title("S1 students per postcode in 2019",'FontSize',22)
%title("P1 students per postcode in 2019",'FontSize',22)
%set(gca,'Color','k')
hold off

end
