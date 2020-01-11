function [tri] = getTri(trinum,c,cmesh,x,y)
    for i=1:trinum
        inTri=inside_triangle([x,y],c(cmesh(i,1),:),c(cmesh(i,2),:),c(cmesh(i,3),:));
        if inTri==1
            tri=i;
            break;
        end
    end

    if inTri==0
        tri=0;
    end
end