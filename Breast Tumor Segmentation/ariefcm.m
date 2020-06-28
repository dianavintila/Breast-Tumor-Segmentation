function [logimg,tumour_area] = ariafcm(im)
I=im;
im=rgb2gray(im);
im=imresize(im,[1080 720]);


inpput_image=im;
org_img=im;

I1=im;
im=im2double(im);
j=im;
%%
%mask size 5 x 5
N = 5;
%to retain original size of image even after filtering
im_pad = padarray(j,[floor(N/2) floor(N/2)]);
%sort elements in ascending or descending order to get median
%convert each sliding NxN block of A into a column of B, with no zero padding
%NOTE im_col is not a column matrix it is a rearranged matrix with 2D as in im_pad
im_col = im2col(im_pad,[N N],'sliding');
%sorts each column of im_pad in ascending order still retains 2D
sorted_cols = sort(im_col,1);
%finds median and returns a row martix containing medians for all columns of the input
%B(x,y) returns the element in B at location (x,y); if y is not specified
%it returns the element at position x in column 1; : implies all columns
med_vector = sorted_cols(floor(N*N/2)+1,:);
%convert result to matrix form to get the MEDIAN FILTERED image
out1 = col2im(med_vector,[N N],size(im_pad),'sliding');
%%
% Generate Gaussian mask/kernel
sigma = 2; % Define sigma here; small detects fine features
% one method to create a matrix; ind is a row matrix [-2 -1 0 1 2]
ind = -floor(N/2) : floor(N/2);
% ind=exp(ind);
% create X by repeating ind rowwise and Y by repeating ind columnwise
[X Y] = meshgrid(ind, ind);
% implement Gaussian HP filter formula; h is 5x5
h = exp(-(X.^2 + Y.^2) / (2*sigma*sigma));
% GHPF=1-GLPF
h=1-h;

% Convert filter into a column vector
h = h(:);

% Filter our image
I=out1;
% this conversion is needed because inbuilt command requires compatibility with its arguement;
% bsxfun requires both C and h to be of the same datatype double
% (convert to higher datatype to prevent data loss)
I = im2double(I);
I_pad = padarray(I, [floor(N/2) floor(N/2)]);
C = im2col(I_pad, [N N], 'sliding');
% Binary Singleton Expansion Function C = bsxfun(FUNC,A,B) applies the
% element-by-element binary operation specified by the function to A and B
C_filter = sum(bsxfun(@times, C, h), 1);
% rearranges the row vector B into a matrix of size (MM-M+1)-by-(NN-N+1).
% B must be a vector of size 1-by-(MM-M+1)*(NN-N+1).
out2 = col2im(C_filter, [N N], size(I_pad), 'sliding');
%figure(1)
%subplot(2,2,3);
% imshow(out2,[]), title('Gaussian filtered image');
format long g;
format compact;
fontSize = 24;
%========================================================================

%im = dicomread('i9.dcm');
% normalize the dicom image to 0-255 range for fast processing
max_val = max(max(im));
z = max_val/255;
im = im./z;
% Get the dimensions of the image.
% numberOfColorBands should be = 1.
[rows, columns, numberOfColorBands] = size(im);

% Display the original gray scale image.
% Crop image to get rid of light box surrounding the image
im = im(3:end-3, 4:end-4);
% Threshold to create a binary image
binaryImage = im > 20;
% Get rid of small specks of noise
binaryImage = bwareaopen(binaryImage, 10);
% Display the original gray scale image.

% Seal off the bottom of the head - make the last row white.
binaryImage(end,:) = true;
% Fill the image
binaryImage = imfill(binaryImage, 'holes');
% Erode away 15 layers of pixels.
se = strel('disk', 15, 0);
binaryImage = imerode(binaryImage, se);
% Mask the gray image
finalImage = im; % Initialize.
finalImage(~binaryImage) = 0;
%%
%//Fuzzy c MEANS ALGORITHM
%out2 is double with max value 0.03... out3 is double with max value 255
%so to calculate histogram more accurately in a time efficient manner we
%convert to uint8 with gray level range 0-255
out2=finalImage;

max_val=max(max(out2));
out3=out2.*(205/max_val);
im=uint8(out3);


im=double(im);
[maxX,maxY]=size(im);
IMM=cat(3,im,im);
cc1=8;
cc2=256;

ttFcm=0;
while(ttFcm<15)
    ttFcm=ttFcm+1;
    
    c1=repmat(cc1,maxX,maxY);
    c2=repmat(cc2,maxX,maxY);
    if ttFcm==1
        test1=c1; test2=c2;
    end
    c=cat(3,c1,c2);
    
    ree=repmat(0.000001,maxX,maxY);
    ree1=cat(3,ree,ree);
    
    distance=IMM-c;
    distance=distance.*distance+ree1;
    
    daoShu=1./distance;
    
    daoShu2=daoShu(:,:,1)+daoShu(:,:,2);
    distance1=distance(:,:,1).*daoShu2;
    u1=1./distance1;
    distance2=distance(:,:,2).*daoShu2;
    u2=1./distance2;
    
    ccc1=sum(sum(u1.*u1.*im))/sum(sum(u1.*u1));
    ccc2=sum(sum(u2.*u2.*im))/sum(sum(u2.*u2));
    
    tmpMatrix=[abs(cc1-ccc1)/cc1,abs(cc2-ccc2)/cc2];
    pp=cat(3,u1,u2);
    
    for i=1:maxX
        for j=1:maxY
            if max(pp(i,j,:))==u1(i,j)
                IX2(i,j)=1;
                
            else
                IX2(i,j)=2;
            end
        end
    end
    
    if max(tmpMatrix)<1
        break;
    else
        cc1=ccc1;
        cc2=ccc2;
        
    end
    
    for i=1:maxX
        for j=1:maxY
            if IX2(i,j)==2
                IMMM(i,j)=254;
            else
                IMMM(i,j)=8;
            end
        end
    end
    tostore=uint8(IMMM);
end

IMMM=uint8(IMMM);

%%
% obtaining ROI and NROI
im_bin=im2bw(IMMM);
[r,c]=find(im_bin==1);
rc=[r c];
simg=im;

im=im2uint8(im);
max_val = max(max(simg));
z = max_val/255;
simg = simg./z;
simg=uint8(simg);
orgimg=simg;


for j=1:(numel(rc)/2)
    simg(r(j),c(j))=0;
end
nroi_image=simg;
logimg=imsubtract(orgimg,simg);
roi_image=logimg;
%%
%area calculation
[h,v]=size(im_bin);
number_pixel=(sum(sum(im_bin)));
tumour_area=sqrt(number_pixel)*0.264;
%%
%subjective analysis
var1 = edge(im_bin,'canny');
[rgb]=convertBinImage2RGB(var1);
img=rgb;
img=uint8(img);
R       = img(:, :, 1);
G       = img(:, :, 2);
B       = img(:, :, 3);
isWhite = R == 255 & B == 255 & G == 255;
G(isWhite) = 0;
B(isWhite) = 0;
newImg  = cat(3, R, G, B);

var2 = imfuse(org_img,newImg,'blend');
fuse_image=var2;
end

