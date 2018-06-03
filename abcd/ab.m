I = imread('C:\Users\Harry\Desktop\Harry\query.jpg');
c1=[];
d1=[];

 median_filtering_Image = customfilter(I); %Uses Noise Removal
%  subplot(3,3,2); %divides figure into rectangular panes
% 
%  imshow(median_filtering_Image); %show image 
%  title('Noise Removed'); %image name

%Binary Image Conversion
binary_picture = im2bw(median_filtering_Image, 0.2); %Convert into Black and White
%  subplot(3,3,3); %divides figure into rectangular panes
% 
%  imshow(binary_picture); %show image 
%  title('Binary Image'); %image name

%Create morphological structuring element
se1 = strel('disk', 2); %creates a flat, disk-shaped structure,
postOpenImage_1 = imopen(binary_picture, se1);
%  subplot(3, 3, 4); %divides figure into rectangular panes
%  
%  imshow(postOpenImage_1); %show image
%  title('Opening Image'); %image name

%Create morphological structuring element
se2 = strel('disk', 8); %creates a flat, disk-shaped structure,
postOpenImage_2 = imopen(binary_picture, se2);
inverted = ones(size(binary_picture));

%Creates Inverted Picture
invertedImage_1 = inverted - postOpenImage_1;
invertedImage_2 = inverted - postOpenImage_2;
%  subplot(3,3,5); %divides figure into rectangular panes
% % 
% imshow(invertedImage_1); %show image
%  title('Inverted Picture'); %image name

 [a1,b1]= gaborWavelet(invertedImage_1);
 c1=[c1;a1,b1];
  waveletMoments_1 = waveletTransform(invertedImage_1);
  d1=[d1;waveletMoments_1];
 
image_folder = 'C:\Users\Harry\Desktop\Harry\Images'; 

filenames = dir(fullfile(image_folder, '*.jpg'));  
 total_images = numel(filenames);   
c=[];
d=[];
 for n = 1:total_images
  full_name= fullfile(image_folder, filenames(n).name);         
our_images = imread(full_name);

%Noise Removal Section

median_filtering_Image = customfilter(our_images); %Uses Noise Removal
% subplot(3,3,2); %divides figure into rectangular panes
% figure(n);
% % imshow(median_filtering_Image); %show image 
% title('Noise Removed'); %image name

%Binary Image Conversion
binary_picture = im2bw(median_filtering_Image, 0.2); %Convert into Black and White
% subplot(3,3,3); %divides figure into rectangular panes
% figure(n);
% % imshow(binary_picture); %show image 
% title('Binary Image'); %image name

%Create morphological structuring element
se1 = strel('disk', 2); %creates a flat, disk-shaped structure,
postOpenImage_1 = imopen(binary_picture, se1);
% subplot(3, 3, 4); %divides figure into rectangular panes
% figure(n);
% % imshow(postOpenImage_1); %show image
% title('Opening Image'); %image name

%Create morphological structuring element
se2 = strel('disk', 8); %creates a flat, disk-shaped structure,
postOpenImage_2 = imopen(binary_picture, se2);
inverted = ones(size(binary_picture));

%Creates Inverted Picture
invertedImage_1 = inverted - postOpenImage_1;
invertedImage_2 = inverted - postOpenImage_2;
% subplot(3,3,5); %divides figure into rectangular panes
% figure(n);
% % imshow(invertedImage_1); %show image
% title('Inverted Picture'); %image name

 [a,b]= gaborWavelet(invertedImage_1);
 c=[c;a,b];
  waveletMoments_1 = waveletTransform(invertedImage_1);
  d=[d;waveletMoments_1];
 end
 
 % compute manhattan distance
manhattan = [];
for k = 1:size(c, 1)
%     manhattan(k) = sum( abs(dataset(k, :) - queryImageFeatureVector) );
    % ralative manhattan distance
    x = sum( abs(c(k, :) - c1) ./ ( 1 + c(k, :) + c1) );
    manhattan= [manhattan;x,k]
    
end


 
 % sort them according to smallest distance
%  sortrows(manhattan);
 sortedImgs =  sortrows(manhattan);
% 
 % clear axes
%  arrayfun(@cla, findall(0, 'type', 'axes'));

 % display query image
 
% h =[];
%  h(1) = subplot(3,3,4);
%  h(2) = subplot(3,3,5);

 subplot(3,3,2);
 imshow(I);
 title('query');
for i=1:3
add=strcat('C:\Users\Harry\Desktop\Harry\Images\',int2str(sortedImgs(i+1,2,1)),'.jpg');
img=imread(add);
%    image(img,'Parent',h(i));
subplot(3,3,i+3);
imshow(img);
title(sortedImgs(i,2));
end
%    