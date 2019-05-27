detector = vision.CascadeObjectDetector(); 
I=imread('face.jpg');
bboxes = step(detector,I);
%figure, imshow(I), title('Detected Face');
rectangle('Position',bboxes(1,:),'LineWidth',2,'EdgeColor',[1 1 0]); hold on;

I2=imcrop(I,bboxes);
%figure, imshow(I2);

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
%figure, imshow(I3);

redA = I3(:,:,1);   % Extract red layer
grayFrame = rgb2gray(I3);  % convert frame to gray
diffFrame=imsubtract(redA, grayFrame); % subtract red and gray frame
binFrame = im2bw(diffFrame, 0.07); %convert image to binary
figure, imshow(binFrame), title('Detected Eye');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %yüzüzerinde noktalarý bulma
% i1 = size(bin2Frame,1)/2;
% j1 = size(bin2Frame,2);
% l1 = size(bin2Frame,1)/2;
% k1 = 1;
% pos1 = [i1 j1;l1 k1];
% faceLandmark = insertMarker(I2,pos1,'x');
% figure, imshow(faceLandmark), title('markedFace');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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


binFrameThi = binFrame(:,end/2+1:end);
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

binFrameFou = binFrame(end/2:end,1:end/2);
for o = size(binFrame,1)
    for p = size(binFrame,2)
        [o p] = find(~binFrameFou,1,'last')
    end
end

binFrameFiv = binFrame(end/2:end,end/2:end);
for q = size(binFrame,1)
    for w = size(binFrame,2)
        [q w] = find(~binFrameFiv,1,'first')
    end
end

for a = size(binFrame,1)
    for s = size(binFrame,2)
        [a s] = find(~binFrameFiv,1,'last')
    end
end

pos = [p o+size(binFrame,1)/2;c l;j i;g+size(binFrame,2)/2 f;n+size(binFrame,2)/2 m;w+size(binFrame,2)/2 q+size(binFrame,1)/2;s+size(binFrame,2)/2 a+size(binFrame,1)/2 ];

landmark = insertMarker(redA,pos);
%L = eyeLandmarks(binFrame);
imshow(landmark);

%figure; imshow(redA); hold on;plot(p,o+size(binFrame,1)/2,'ro');