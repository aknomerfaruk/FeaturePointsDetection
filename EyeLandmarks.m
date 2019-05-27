clear;

detector = vision.CascadeObjectDetector(); 
resim=imread('image_0166.jpg');
I=imresize(resim, [240 320]);
bboxes = step(detector,I);
figure, imshow(I), title('Detected Face');
rectangle('Position',bboxes(1,:),'LineWidth',2,'EdgeColor',[1 1 0]); hold on;

I2=imcrop(I,bboxes);
figure, imshow(I2);

redA = I2(:,:,1);   % Extract red layer
grayFrame = rgb2gray(I2);  % convert frame to gray
diffFrame=imsubtract(redA, grayFrame); % subtract red and gray frame
bin2Frame = im2bw(diffFrame, 0.07); %convert image to binary
figure, imshow(bin2Frame), title('Detected Face');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
EyeDetect = vision.CascadeObjectDetector('EyePairBig');
BB=step(EyeDetect,I2);
figure,imshow(I2);
rectangle('Position',BB,'LineWidth',4,'LineStyle','-','EdgeColor','b');
title('Eyes Detection')

I3=imcrop(I2,BB);
figure, imshow(I3);

redA = I3(:,:,1);   % Extract red layer
grayFrame = rgb2gray(I3);  % convert frame to gray
diffFrame=imsubtract(redA, grayFrame); % subtract red and gray frame
binFrame = im2bw(diffFrame, 0.07); %convert image to binary
figure, imshow(binFrame), title('Detected Eye');

for i = size(binFrame,1)
    for j = size(binFrame,2)
        [i j]  = find(~binFrame,1,'first')
    end
end 

binFrameSec = binFrame(:,1:end/2);

for l = size(binFrame,1)
    for c = size(binFrame,2)
        [l c] = find(~binFrameSec,1,'last')
    end
end

RbinFrame = imrotate(binFrameSec,90);

for o = size(binFrame,1)
    for p = size(binFrame,2)
        [o p] = find(~RbinFrame,1,'first')
    end
end

for q = size(binFrame,1)
    for w = size(binFrame,2)
        [q w] = find(~RbinFrame,1,'last')
    end
end

binFrameThi = binFrame(:,end/2:end);
for f = size(binFrame,1)
    for g = size(binFrame,2)
        [f g] = find(~binFrameThi,1,'first')
    end
end

for m = size(binFrameThi,1)
    for n = size(binFrame,2)
        [m n] = find(~binFrameThi,1,'last')
    end
end

RbinFrameThi = imrotate(binFrameThi,90);
for a = size(binFrame,1)
    for s = size(binFrame,2)
        [a s] = find(~RbinFrameThi,1,'first')
    end
end

for x = size(binFrame,1)
    for y = size(binFrame,2)
        [x y] = find(~RbinFrameThi,1,'last')
    end
end


 pos = [c+BB(1) l+BB(2);j+BB(1) i+BB(2);g+size(binFrame,2)/2+BB(1) f+BB(2);
        n+size(binFrame,2)/2+BB(1) m+BB(2);o+BB(1) p+BB(2);q+BB(1) w+BB(2);
        a+size(binFrame,2)/2+BB(1) s+BB(2);x+size(binFrame,2)/2+BB(1) y+BB(2)];
landmark = insertMarker(I2,pos);
imshow(landmark);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%figure, imshow(RbinFrame), title('rotated');
%figure, imshow(RbinFrameThi), title('rotated2');
%figure; imshow(redA); hold on;plot(p,o+size(binFrame,1)/2,'ro');
