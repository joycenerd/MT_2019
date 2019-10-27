% read in image and construct matrix
folder="./my_src2";

if ~isfolder(folder)
    errorMessage=sprintf('Error: The following folder does not exist:\n%s',folder);
    uiwait(warndlg(errorMessage));
    return;
end

pattern=fullfile(folder,'*.jpeg');
img=dir(pattern);
fname=fullfile(folder,img(1).name);
img_info=imread(fname);
[row,col,channels]=size(img_info);
mat=zeros(row*col*channels,2);

for i=1:2
    fname=fullfile(folder,img(i).name);
    img_info=imread(fname);
    vec=img_info(:);
    mat(:,i)=im2double(vec);
end


% calcualte the weighted mean as output image
weight=[0.45,0.55];
weight=weight(:);
out_vec=mat*weight;
out_img=reshape(out_vec,row,col,channels);

fname="./output/my_composition_2";
imwrite(out_img,strcat(fname,'.bmp'));