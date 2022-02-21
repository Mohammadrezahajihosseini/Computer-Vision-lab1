load 'tree.mat'
I = imread('tree.png');
[M, N] = size(I);

%Moving Avreage filter for 3*3 
K3=ones(3,3)/9;
out3=conv2(I,K3,'same');
subplot(2,2,1),imagesc(out3),colormap gray,title('smoothing by averaging 3*3')

%Moving Avreage filter for 7*7
K7=ones(7,7)/49;
out7=conv2(I,K7,'same');
subplot(2,2,2)
imagesc(out7),colormap gray,title('smoothing by averaging7*7')

%Histogram for 3*3
out3=double(out3);
subplot(2,2,3)
imhist(uint8(out3),256),title('histogram of Moving Avreage filter for 3*3'),ylabel('number of pixels')
ylim([0 400]);

%Histogram for 7*7
out7=double(out7);
subplot(2,2,4)
imhist(uint8(out7),256),title('histogram of Moving Avreage filter for 7*7'),ylabel('number of pixels')
ylim([0 400]);

%Display with command surf();
figure
surf(out3)
title('Display removing noise by comd. surf 3*3')
figure
surf(out7)
title('Display removing noise by comd. surf 7*7')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%low-pass Gaussian filter
% Getting Fourier Transform of the input_image
% using MATLAB library function fft2 (2D fast fourier transform)  
FT_img = fft2(double(I));

% Assign Cut-off Frequency  
D0 = 30;

% Designing filter
u = 0:(M-1);
idx = find(u>M/2);
u(idx) = u(idx)-M;
v = 0:(N-1);
idy = find(v>N/2);
v(idy) = v(idy)-N;
% MATLAB library function meshgrid(v, u) returns
% 2D grid which contains the coordinates of vectors
% v and u. Matrix V with each row is a copy 
% of v, and matrix U with each column is a copy of u
[V, U] = meshgrid(v, u);
  
% Calculating Euclidean Distance
D = sqrt(U.^2+V.^2);
  
% Comparing with the cut-off frequency and 
% determining the filtering mask
H = double(D <= D0);
% Convolution between the Fourier Transformed
% image and the mask
g = H.*FT_img;
  
% Getting the resultant image by Inverse Fourier Transform
% of the convoluted image using MATLAB library function 
% ifft2 (2D inverse fast fourier transform)  
output_image = real(ifft2(double(g)));
  
% Displaying Input Image and Output Image
figure
imshow(output_image, [ ]);
title('low pass Gaussian filter')
figure
subplot(1,2,1)
imagesc(output_image);
title('low pass Gaussian filter with comd. imagesc()')


%Histogram for low pass gaussian filter 
subplot(1,2,2)
imhist(uint8(output_image),256),title('histogram of low pass Gaussian filter '),ylabel('number of pixels')
ylim([0 400]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Median filter
Median = medfilt2(I);
figure
imshow(Median);
title('image of Median filter with comd. imagesc()')
figure
subplot(1,2,1)
imagesc(Median)
title('image of Median filter ')
subplot(1,2,2)
imhist(uint8(Median),256),title('histogram of Median filter '),ylabel('number of pixels')
ylim([0 800]);
figure
surf(Median)
title('Median filter with Surf()')

figure
imagesc(I),colormap gray,title('Original image')

