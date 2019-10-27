% read in image and construct matrix
folder="./src";

if ~isfolder(folder)
    errorMessage=sprintf('Error: The following folder does not exist:\n%s',folder);
    uiwait(warndlg(errorMessage));
    return;
end

pattern=fullfile(folder,'*.bmp');
img=dir(pattern);
mat=zeros(1003230,2);

for i=2:3
    fname=fullfile(folder,img(i).name);
    img_info=imread(fname);
    vec=img_info(:);
    mat(:,i)=im2double(vec);
end

mat(mat<0.04)=0;


% calcualte the weighted mean as output image
weight=[2,3];
weight=weight(:);
out_vec=mat*weight;

for i=1:1003230
    idx=find(mat(i,:));
    w_sum=sum(weight(idx));
    out_vec(i)=out_vec(i)/w_sum;
end

out_img=reshape(out_vec,471,710,3);

fname="./tmp/wave_and_pond";
imwrite(out_img,strcat(fname,'.bmp'));