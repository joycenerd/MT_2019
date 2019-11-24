MT Assignment2: Image Convolution
==

###### tags: `multimedia tech`

## Part1: Different hsize Gaussian filter

### Step1: Read the image and do zero padding

1. open the folder that the image is in
2. read the image
3. convert the data type to double
4. do zero-padding with `padarray()`

```matlab=
B=padarray(A,padsize,padval,direction);
```

References:

* [Finding the dimensions of an image](https://www.mathworks.com/matlabcentral/answers/81089-finding-the-dimensions-of-an-image)
* [how to make zero padding?](https://www.mathworks.com/matlabcentral/answers/89494-how-to-make-zero-padding)
* [padarray](https://www.mathworks.com/help/images/ref/padarray.html)

### Step2: Gaussian filter with hsize=3x3 and sigma=1

1. create a Gaussian filter with `fspecial()`
2. convolution (**sum of element-wise matrix multiplication**) using for loop sweeping the whole image matrix with a layer of padding as the margin
3. output the resulting convolution image
4. calculate the PSNR between the original image and the image after the convolution using `psnr()`
5. write the psnr result to an array

```matlab=
G=fspecial('gaussian',[row,col],sigma);
res=sum(A.*B,'all');
peaksnr=psnr(A,ref);
```

`fspecial` can create many filters automatically. When using it you need to specify which kind of filter you want, `gaussian` is what I want here. Also the size of filter and sigma.

When doing convolution since I can't use matlab's built-in function, so I will need to go through every pixel and calculate by myself. It's quite easy though. Every 3x3 pixel do element wise matrix multiplication and sum up as the output pixel. 

References:

* [sum](https://www.mathworks.com/help/matlab/ref/sum.html)
* [psnr](https://www.mathworks.com/help/images/ref/psnr.html)

### Step3: Gaussian filter with hsize=5x5 and sigma=1

1. Add one more layer of zero-padding as the margin around the image
3. The rests are the same as **Step2**

Adding one more layer of zero-padding is because hsize is larger this time

### Step4: Gaussian filter with hsize=7x7 and sigma=1

Same as **Step3**

## Part2: Different sigma Gaussian filter

### Step1: Gaussian filter with hsize=3x3 and sigma=1

1. Using the image with only one layer of zero-padding as the margin
2. The rests are the same as **Step2 in Part1**

### Step2: Gaussian filter with hsize=3x3 and sigma=5

Same as **Step1** but remember to change the sigma value in `fspecial()`

### Step3: Gaussian filter with hsize=3x3 and sigma=10

Same as **Step2**

### Step4: Write the whole PSNR table to a CSV file

1. transfrom the PSNR array to a table using `array2table()`
2. name the variable of the table
3. write the table to the CSV file

## Part3: Apply unsharp and edge detecton mask

### Step1: Unsharp mask

1. Use the unsharp mask from the assignment SPEC  $\begin{bmatrix}-1 & -1 & -1 \\ -1 & 8 & -1 \\ -1 & -1 & -1\end{bmatrix}$
2. Doing convolution
3. output the resulting image

### Step2: Edge detection

1. Use the edge detection mask from the lecture slide (**Unit3 p.61**)
2. doing convolution
3. output the resulting image