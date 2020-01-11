function [a,b,c,cmesh,trinum] = mesh(file1,file2,frame)
    a=csvread(file1);
    b=csvread(file2);

    %amesh=delaunay(a(:,1),a(:,2));
    %bmesh=delaunay(b(:,1),b(:,2));

    rowsz=min(length(a),length(b));
    c=zeros(rowsz,2);

    for i=1:rowsz
        c(i,1)=a(i,1)+(b(i,1)-a(i,1))*frame/31;
        c(i,2)=a(i,2)+(b(i,2)-a(i,2))*frame/31;
    end

    cmesh=delaunay(c(:,1),c(:,2));
    trinum=length(cmesh);
end