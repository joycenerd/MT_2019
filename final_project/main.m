for frame=0:29
    
    morphing1="src/coordinates/morphing1/frame"+frame+".csv";
    morphing2="src/coordinates/morphing2/frame"+frame+".csv";

    [a,b,c,cmesh,trinum]=mesh(morphing1,morphing2,frame+1);
    [atform,btform]=affine(a,b,c,cmesh);

    Aimage=imread("src/morphing1/frame"+frame+".jpg");
    Bimage=imread("src/morphing2/frame"+frame+".jpg");

    Aimage=im2double(Aimage);
    Bimage=im2double(Bimage);

    [rows,cols,channels]=size(Aimage);
    Cimage=zeros(rows,cols,channels);

    for y=1:rows
        for x=1:cols
            tri=getTri(trinum,c,cmesh,x,y);
            if tri~=0
                tform=affine2d(atform(:,:,tri));
                [xa,ya]=transformPointsForward(tform,x,y);
                Aval=interpImg(Aimage,[ya,xa],false);
            
                tform=affine2d(btform(:,:,tri));
                [xb,yb]=transformPointsForward(tform,x,y);
                Bval=interpImg(Bimage,[yb,xb],false);
                Cimage(y,x,1)=Aval(:,:,1)*(30-frame)/31+Bval(:,:,1)*(frame+1)/31;
                Cimage(y,x,2)=Aval(:,:,2)*(30-frame)/31+Bval(:,:,2)*(frame+1)/31;
                Cimage(y,x,3)=Aval(:,:,3)*(30-frame)/31+Bval(:,:,3)*(frame+1)/31;
            end
        end
    end
    
    imwrite(Cimage,"result/frames/frame"+frame+".jpg");
    str=sprintf("frame"+frame+" finished\n");
    disp(str);
end

