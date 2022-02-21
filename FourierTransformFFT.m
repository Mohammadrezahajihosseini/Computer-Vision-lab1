load 'tree.mat'
I = imread('tree.png');
Dobim = double(I);
[M, N] = size(I);
subplot(2,2,1)
imagesc(I),colormap gray,title('Original image')

%Apply the Fourier Transform (FFT) on images
F=fft2(double(I));
S=fftshift(F);
L=log2(S);
A=abs(L);
log = conv2(Dobim,A);
subplot(2,2,2)
imagesc(log)
title('Log')

%display the magnitude of the transformed low-pass Gaussian filter (spatial support of
%101x101 pixels with sigma=5);
o =ones(3,3)/9;
h = fspecial('gaussian',101,5);
i1 = filter2(o,h,'same');
LPF = conv2(Dobim,i1);
subplot(2,2,3)
imagesc(LPF);
title('Low pass Gaussian')

%display the magnitude of the transformed sharpening filter(the filter has a
%spatial support of 7x7 pixels, copy it in the middle of a zeros image of 101x101 pixels).

% create sharpening filter of size 7x7 
filter7 = zeros(7,7);
filter7(4, 4) = 1;
filterS=2*filter7-ones(7,7)/49;
% create empty image of size 101x101
i2=zeros(101,101);
i2(51, 51) = 1;
i2 = filter2(filterS,i2,'same'); %copy filterS in middle of image 
subplot(2,2,4)
sharpened = conv2(Dobim,i2);
imagesc(sharpened)
title('Sharpened Image');
