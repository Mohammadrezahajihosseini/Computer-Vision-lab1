load 'tree.mat'
I = imread('tree.png');
[M, N] = size(I);
subplot(2,2,1),imagesc(I),colormap gray,title('Original image')

%Linear filters use filters with a spatial support of 7x7 pixels
F7=ones(7,7)/49;
subplot(2,2,2)
outc=conv2(I,F7,'same');
imagesc(outc),colormap gray,title('smoothing by averaging')
subplot(2,2,3),imagesc(I - uint8(outc)),title('Original image-Smoothed image')
subplot(2,2,4),imagesc(I+(I - uint8(outc))),title('Original image+detail = sharpened image')

%Display by surf()
figure
surf(I - uint8(outc)),title('Original image-Smoothed image')
figure
surf(I+(I - uint8(outc))),title('Original image+detail = sharpened image')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%uses an 7-by-7 filter.
filterSize = [7 7];
padSize = (filterSize-1)/2;
Apad = padarray(I, padSize, 'replicate','both');

%Compute the integral image of the padded input image
intA = integralImage(Apad);

%Filter the integral image
B = integralBoxFilter(intA, filterSize);

%Filter the integral image
figure,subplot(2,2,1),imshow(I),title('Original Image')
subplot(2,2,2),imshow(B,[]),title('Filtered Image by Blurred with a box filter 7*7')
final=B,[];
subplot(2,2,[3,4]),surf(final),title('Filtered Image by Blurred with a box filter 7*7');

