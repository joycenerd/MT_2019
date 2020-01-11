function [atform,btform] = affine(a,b,c,cmesh)
    len=length(cmesh);

    atform=zeros(3,3,len);
    for x=1:len
        fixed=[a(cmesh(x,1),:);a(cmesh(x,2),:);a(cmesh(x,3),:)];
        moving=[c(cmesh(x,1),:);c(cmesh(x,2),:);c(cmesh(x,3),:)];
        atform(:,:,x)=fitgeotrans(moving,fixed,'NonreflectiveSimilarity').T;
    end

    btform=zeros(3,3,len);
    for x=1:len
        fixed=[b(cmesh(x,1),:);b(cmesh(x,2),:);b(cmesh(x,3),:)];
        moving=[c(cmesh(x,1),:);c(cmesh(x,2),:);c(cmesh(x,3),:)];
        %sprintf("%d  %d %d\n",cmesh(x,1),cmesh(x,2),cmesh(x,3))
        %disp(fixed);
        %disp(moving);
        btform(:,:,x)=fitgeotrans(moving,fixed,'NonreflectiveSimilarity').T;
    end
end