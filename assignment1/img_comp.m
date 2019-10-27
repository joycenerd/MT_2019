% read in pond and wave image and construct matrix
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
    mat(:,i-1)=im2double(vec);
end

mat(mat<0.095)=0;


% calcualte the weighted mean as temporary image
weight=[1,2.5];
weight=weight(:);
out_vec=mat*weight;
w_sum=sum(weight);

for i=1:1003230
    if mat(i,2)==0
        out_vec(i)=mat(i,1);
    else
        out_vec(i)=out_vec(i)/w_sum;
    end
end

out_img=reshape(out_vec,471,710,3);

fname="./tmp/wave_and_pond";
imwrite(out_img,strcat(fname,'.bmp'));


% read in lion and the temporary image and construct matrix
mat=zeros(1003230,2);
fname=fullfile(folder,img(1).name);
img_info=imread(fname);
vec=im2double(img_info(:));
vec(vec<0.019)=0;
mat(:,1)=vec;
mat(:,2)=out_vec;


% calculate the weighted mean as output image
weight=[2,1];
weight=weight(:);
final_vec=mat*weight;
w_sum=sum(weight);

for i=1:1003230
    if mat(i,1)==0
        final_vec(i)=mat(i,2);
    else
        final_vec(i)=final_vec(i)/w_sum;
    end
end

out_img=reshape(final_vec,471,710,3);

fname="./output/sample";
imwrite(out_img,strcat(fname,'.bmp'));
