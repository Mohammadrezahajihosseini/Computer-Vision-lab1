load 'tree.mat'
I = imread('tree.png');
[M, N] = size(I);
subplot(2,3,1)
imagesc(I),colormap gray,title('Original image')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Gaussian (standard deviation=20)%
Gaussian=double(I)+20*randn(size(I));
subplot(2,3,2)
imagesc(Gaussian),colormap gray,title('Gaussian with SD=20 Image')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%salt & pepper (density=20%) %
J = imnoise(I,'salt & pepper',0.2);
subplot(2,3,3)
imagesc(J),colormap gray,title('salt and pepper noise')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Histogram for original image
I=double(I);
subplot(2,3,4)
imhist(uint8(I),256),title('histogram of Original'),ylabel('number of pixels')
ylim([0 700]);

%%Histogram for Gaussian Distribution 
Gsussian=double(Gaussian);
subplot(2,3,5)
imhist(uint8(Gaussian),256),title('histogram of Gaussian'),ylabel('number of pixels')
ylim([0 700]);

%%Histogram for Salt&pepper noise
J=double(J);
subplot(2,3,6)
imhist(uint8(J),256),title('histogram of Salt&pepper'),ylabel('number of pixels')
ylim([0 700]);
%%%%%%%%%%%%%%%%%%%%%%%
%noisy image 
figure
plot(I(50,:),'r'),hold on,plot(Gaussian(50,:),'b')
title('Original image with Gaussian image')
figure
plot(I(50,:),'r'),hold on,plot(J(50,:),'b')
title('Original image with Salt & pepper image')