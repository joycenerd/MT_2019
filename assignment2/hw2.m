% Open the image and do zero padding
folder="./src";
if ~isfolder(folder)
    error_message=sprintf("Error: The following folder does not exist:\n%s",folder);
    uiwait(warndlg(error_message));
    return;
end
pattern=fullfile(folder,'*.jpg');
file=dir(pattern);
fname=fullfile(folder,file(1).name);
image=imread(fname);
[rows,cols,channels]=size(image);
image=im2double(image);
image_pad1=padarray(image,[1,1],0,'both');
peaksnr_T=strings(6,2);


% Gaussian filter with hsize=3*3 and sigma=1
G=fspecial('gaussian',[3,3],1);
img_conv=zeros([rows,cols,channels]);

for channel=1:channels
    for row=1:rows
        for col=1:cols
            img_conv(row,col,channel)=sum(image_pad1(row:row+2,col:col+2,channel).*G,'all');
        end
    end
end

fname="./result/hsize/hsize_3x3.jpg";
imwrite(img_conv,fname);

peaksnr=psnr(image,img_conv);
peaksnr_T(1,:)={"hsize=3x3",peaksnr};


% Gaussian filter with hsize=5*5 and sigma=1
G=fspecial('gaussian',[5,5],1);
image_pad2=padarray(image_pad1,[1,1],0,'both');
img_conv=zeros([rows,cols,channels]);

for channel=1:channels
    for row=1:rows
        for col=1:cols
            img_conv(row,col,channel)=sum(image_pad2(row:row+4,col:col+4,channel).*G,'all');
        end
    end
end

fname="./result/hsize/hsize_5x5.jpg";
imwrite(img_conv,fname);

peaksnr=psnr(image,img_conv);
peaksnr_T(2,:)={"hsize=5x5",peaksnr};


% Gaussian filter with hsize=7*7 and sigma=1
G=fspecial('gaussian',[7,7],1);
image_pad3=padarray(image_pad2,[1,1],0,'both');
img_conv=zeros([rows,cols,channels]);

for channel=1:channels
    for row=1:rows
        for col=1:cols
            img_conv(row,col,channel)=sum(image_pad3(row:row+6,col:col+6,channel).*G,'all');
        end
    end
end

fname="./result/hsize/hsize_7x7.jpg";
imwrite(img_conv,fname);

peaksnr=psnr(image,img_conv);
peaksnr_T(3,:)={"hsize=7x7",peaksnr};


% Gaussian filter with hsize=3*3 and sigma=1
G=fspecial('gaussian',[3,3],1);
img_conv=zeros([rows,cols,channels]);

for channel=1:channels
    for row=1:rows
        for col=1:cols
            img_conv(row,col,channel)=sum(image_pad1(row:row+2,col:col+2,channel).*G,'all');
        end
    end
end

fname="./result/sigma/sigma_1.jpg";
imwrite(img_conv,fname);

peaksnr=psnr(image,img_conv);
peaksnr_T(4,:)={"sigma=1",peaksnr};


% Gaussina filter with hsize=3*3 and sigma=5
G=fspecial('gaussian',[3,3],5);
img_conv=zeros([rows,cols,channels]);

for channel=1:channels
    for row=1:rows
        for col=1:cols
            img_conv(row,col,channel)=sum(image_pad1(row:row+2,col:col+2,channel).*G,'all');
        end
    end
end

fname="./result/sigma/sigma_5.jpg";
imwrite(img_conv,fname);

peaksnr=psnr(image,img_conv);
peaksnr_T(5,:)={"sigma=5",peaksnr};


% Gaussian filter with hsize=3*3 and sigma=10
G=fspecial('gaussian',[3,3],10);
img_conv=zeros([rows,cols,channels]);

for channel=1:channels
    for row=1:rows
        for col=1:cols
            img_conv(row,col,channel)=sum(image_pad1(row:row+2,col:col+2,channel).*G,'all');
        end
    end
end

fname="./result/sigma/sigma_10.jpg";
imwrite(img_conv,fname);

peaksnr=psnr(image,img_conv);
peaksnr_T(6,:)={"sigma=10",peaksnr};


% Write the whole psnr table to csv file
peaksnr_T=array2table(peaksnr_T);
peaksnr_T.Properties.VariableNames={'TEST_ITEM','PSNR_VAL'};
writetable(peaksnr_T,"./result/psnr.csv");


% Unsharp mask
unsharp=([-1,-1,-1;-1,8,-1;-1,-1,-1]);
img_conv=zeros([rows,cols,channels]);

for channel=1:channel
    for row=1:rows
        for col=1:cols
            img_conv(row,col,channel)=sum(image_pad1(row:row+2,col:col+2,channel).*unsharp,'all');
        end
    end
end

fname="./result/unsharp.jpg";
imwrite(img_conv,fname);


% edge detection
edge_detection=([1,1,1;0,0,0;-1,-1,-1]);
img_conv=zeros([rows,cols,channels]);

for channel=1:channel
    for row=1:rows
        for col=1:cols
            img_conv(row,col,channel)=sum(image_pad1(row:row+2,col:col+2,channel).*edge_detection,'all');
        end
    end
end

fname="./result/edge_detection.jpg";
imwrite(img_conv,fname);
