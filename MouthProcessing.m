clear;

detector = vision.CascadeObjectDetector(); 
resim=imread('image_0166.jpg');
I=imresize(resim, [240 320]);
bboxes = step(detector,I);
figure, imshow(I), title('Detected Face');
rectangle('Position',bboxes(1,:),'LineWidth',2,'EdgeColor',[1 1 0]); hold on;

I2=imcrop(I,bboxes);
figure, imshow(I2); title('Cropped Face')


% aðýz belirleniyor
MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',50);
%MouthDetect = vision.CascadeObjectDetector('Mouth');
bb2=step(MouthDetect,I2);
figure,imshow(I2); title('mouth');
rectangle('Position',bb2(1,:),'LineWidth',2,'EdgeColor',[1 1 0]); hold on;

agiz=imcrop(I2,bb2); 
figure, imshow(agiz);title('Cropped Mouth');
mLine=edge(agiz(:,:,1),'canny'); % sobel,canny,prewitt,roberts 
figure,imshow(mLine);hold on;

for a = size(agiz,1)
    for s = size(agiz,2)
        [a s] = find(mLine,1,'first');
    end
end 

for l = size(agiz,1)
    for c = size(agiz,2)
        [l, c] = find(mLine,1,'last');
    end
end

RmLine = imrotate(mLine,90);
RmLine1 = imrotate(mLine,270);

figure,imshow(RmLine1);title('rotatedimage2');
figure,imshow(RmLine);title('rotatedimage');

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


pos = [s+bb2(1) a+bb2(2);c+bb2(1) l+bb2(2);
        x+bb2(1) y+bb2(2);d+bb2(1) f+bb2(2)];
landmark = insertMarker(I2,pos);
figure; imshow(landmark); title('bulunan noktalar')
