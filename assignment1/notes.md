Image Composition notes
==

###### tags: `multimedia tech`

## Part1: Compose 3 images to 1 output image

### Step1: Read in the the pond and the wave image and construct the matrix

1. Open image folder
2. read in the image and format each to a vector size of 1003230
3. concatenate all the vectors to a matrix 1003230x2
4. if the pixel value is less than 0.095 then I repace to 0

```matlab=
folder="path of folder";

if ~isfolder(folder)
    msg=sprintf("error message");
    uiwait(warndlg(msg));
    return;
end

pattern=fullfile(folder,"img format");
data=dir(pattern);
mat=zeros(row,col);
fname=fullfile(folder,data.name);
info=imread(fname);
vec=info(:);
mat(row,col)=im2double(vec);
mat(condition)=new_value
```

I replace the value with 0 is because if the value is near 0 then the pixel in my case is probably mostly composed of color black. And color black won't be count into the weighted mean in the next step, so I make that pixel black. This will reduce the discreteness of the output image with black margin of the object.

References:

* [Finding the dimensions of an image](https://www.mathworks.com/matlabcentral/answers/81089-finding-the-dimensions-of-an-image)
* [How do I replace the zeros in a matrix with another integer, or with a pos or neg infinity?](https://www.mathworks.com/matlabcentral/answers/8770-how-do-i-replace-the-zeros-in-a-matrix-with-another-integer-or-with-a-pos-or-neg-infinity)

### Step2: Calculate the weighted mean as the temporary image

1. define the weight vector -> [1,2.5]
2. using the image vector and the weight vector to do matrix multiplication
3. sum up the weights
4. if the value of the wave image is 0 in this pixel then it will all be represented with the pond image.
5. if not then divided by the sum of the weights
6. reshape the output image vector back to the original dimension (1003230 -> 471x710x3)
7. output as the temporary image

```matlab=
w_sum=sum(w);
out=reshape(vec,row,col,channel);
fname="name of outpu file";
imwrite(file,strcat(fname,"type of file"));
```

I originally thought I can try not to use for loop. Cause everybody knows if not using the for loop and uses only matlab defined function can reduce calculation time. But I found out that if calculating weighted mean at the same time ignoring some values in some conditions doesn't have a straightforward way to do so. So I still use for loop to identify the ignoring condition.

Also I try to find a way to ignore all the possible black color by finding the pixel values that are too small (very close to black) in the wave and when doing the composition these pixel will be using pond pixel to represent. And I find this working. The discreteness of the margin in the wave image has been lowered in the temporary output image. 

References:

[find](https://www.mathworks.com/help/matlab/ref/find.html)

### Step3: Read in the lion and the temporary image and construct the matrix

This step is same as **Step1**. The only difference is that this time if the pixel value in the lion image is less than **0.019** than I set it to 0.

### Step4: Calculate the weighted mean and output the image

This step is same as **Step2**.

## Part2: Choose 2 to 3 images by yourself to do image composition - try 1

### Step1: Resise the image

Since not all the images will have the same size so I use online converter to resize the images I want to do composition to the same size (1000x1250).

**This is the converter I use: [picresize](https://picresize.com/)**

### Step2: Change the image type

The image type I find is a bit of different but basically they can just rename it directly cause they are .jpg and .jpeg

### Step3: Read in the images and construct the matrix

This step is same as **Step1 in Part1**

### Step4: Calculate the weighted mean as the output image

This step basically is same as **Step2 in Part1**. The only difference is in this part I only use 2 images so it is easier to choose the weights for the composition. And also the image I choose seems easier to compose together so the output image looks amazing in my point of view.

## Part3: Choose 2 to 3 images by yourself to do image composition - try 2

### Step1: Resize the image

This step is same as **Step1 in Part2**. The only difference is the image size is (1600x900) this time.

### Step2: Change the image type

This step is same as **Step2 in Part2**.

### Step3: Read in the image and construct the matrix

This step is same as **Step3 in Part2**.

### Step4:  Calculate the weighted mean as the output image

This step is same as **Step4 in Part2**. The only difference is the weights I set is different

From the 3 compositions I make I found out that if choosing the images with the same type or the image color is easy to blend (same color series) then the output images will look better. If choosing the image to do composition by myself, I will choose both images with bright color series or both with dark color series. The output effect will be better. In my case **Part2 and Part3 both look better than Part1**, cause the chosen image is different.

