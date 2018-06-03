function C = customfilter(P)
filter_A=zeros(size(P)+2);
C=zeros(size(P));
        for x=1:size(P,1)
            for y=1:size(P,2)
                filter_A(x+1,y+1)=P(x,y);
            end
        end        
for i= 1:size(filter_A,1)-2
    for j=1:size(filter_A,2)-2
        window=zeros(9,1);
        inc=1;
        for x=1:3
            for y=1:3
                window(inc)=filter_A(i+x-1,j+y-1);
                inc=inc+1;
            end
        end    
        med=sort(window);
        C(i,j)=med(5);       
    end
end
C=uint8(C);
end 
