function [atform,btform] = affine(a,b,c,cmesh)
    len=length(cmesh);

    atform=zeros(3,3,len);
    for x=1:len
        moving=[a(cmesh(x,1),:);a(cmesh(x,2),:);a(cmesh(x,3),:)];
        fixed=[c(cmesh(x,1),:);c(cmesh(x,2),:);c(cmesh(x,3),:)];
        tform=fitgeotrans(moving,fixed,'affine');
        atform(:,:,x)=invert(tform).T;
    end

    btform=zeros(3,3,len);
    for x=1:len
        moving=[b(cmesh(x,1),:);b(cmesh(x,2),:);b(cmesh(x,3),:)];
        fixed=[c(cmesh(x,1),:);c(cmesh(x,2),:);c(cmesh(x,3),:)];
        tform=fitgeotrans(moving,fixed,'affine');
        btform(:,:,x)=invert(tform).T;
    end
end