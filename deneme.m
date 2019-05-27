
%resim=imread('face.jpg'); % face.jpg
clear;
resim=imread('image_0358.jpg'); 
I=imresize(resim, [240 320]);


detector = vision.CascadeObjectDetector(); 
bboxes = step(detector,I);
%figure, imshow(I), title('Yüz bulundu');
rectangle('Position',bboxes(1,:),'LineWidth',2,'EdgeColor',[1 1 0]); hold on;

I2=imcrop(I,bboxes);
%figure, imshow(I2);title('yüz kýrpýldý');

% aðýz belirleniyor
MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',50);
%MouthDetect = vision.CascadeObjectDetector('Mouth');
bboxes2=step(MouthDetect,I2);
%figure,imshow(I2); title('aðýz bulundu');
rectangle('Position',bboxes2(1,:),'LineWidth',2,'EdgeColor',[1 1 0]); hold on;



agiz=imcrop(I2,bboxes2); 
%figure, imshow(agiz);title('aðýz kýrpýldý');
mLine=edge(agiz(:,:,1),'canny'); % sobel,canny,prewitt,roberts 
figure,imshow(mLine); title('mouth canny');
rgbagiz = rgb2gray(agiz);
% subplot(1,2,1); imshow(agiz);
% subplot(1,2,2); imshow(mouth_canny);



for a = size(agiz,1)
    for s = size(agiz,2)
        [a s] = find(mLine,1,'first');
    end
end 

for l = size(agiz,1)
    for c = size(agiz,2) 
    [l c] = find(mLine,1,'last');
    end
end

RmLine = imrotate(mLine,90);
RmLine1 = imrotate(mLine,270);
figure,imshow(RmLine1);title('rotatedimage2');
%figure,imshow(RmLine);title('rotatedimage');
for x = size(agiz,1)
    for y = size(agiz,2)
        [x y] = find(RmLine1,1,'first');
    end
end 

for d = size(agiz,1)
    for f = size(agiz,2)
        [d f] = find(RmLine,1,'last');
    end
end 
pos = [s a;c l;x y;d f];
landmark = insertMarker(rgbagiz,pos);
figure; imshow(landmark); title('bulunan noktalar')
