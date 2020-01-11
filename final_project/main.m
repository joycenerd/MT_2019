morphing1="src/coordinates/morphing1/frame0.csv";
morphing2="src/coordinates/morphing2/frame0.csv";

[a,b,c,cmesh,trinum]=mesh(morphing1,morphing2);
[atform,btform]=affine(a,b,c,cmesh);

Aimage=imread("src/morphing1/frame0.jpg");
Bimage=imread("src/morphing2/frame0.jpg");

Aimage=double(Aimage);
Bimage=double(Bimage);

[rows,cols,channels]=size(Aimage);
Cimage=zeros(rows,cols,channels);

for y=1:cols
    for x=1:rows
        tri=getTri(trinum,c,cmesh,x,y);
        if tri~=0
            tform=affine2d(atform(:,:,tri));
            [ya,xa]=transformPointsForward(tform,y,x);
            Aval=interpImg(Aimage,[ya,xa],false);
            
            tform=affine2d(btform(:,:,tri));
            [yb,xb]=transformPointsForward(tform,y,x);
            Bval=interpImg(Bimage,[yb,xb],false);
            Cimage(y,x)=Cimage(y,x)+Aval*.5+Bval*.5;
        end
    end
end

