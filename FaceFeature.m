clear;

detector = vision.CascadeObjectDetector(); 
resim=imread('image_0166.jpg');
I=imresize(resim, [240 320]);
bboxes = step(detector,I);
%figure, imshow(I), title('Detected Face');
rectangle('Position',bboxes(1,:),'LineWidth',2,'EdgeColor',[1 1 0]); hold on;

I2=imcrop(I,bboxes);
figure, imshow(I2);

redA = I2(:,:,1);   % Extract red layer
grayFrame = rgb2gray(I2);  % convert frame to gray
diffFrame=imsubtract(redA, grayFrame); % subtract red and gray frame
bin2Frame = im2bw(diffFrame, 0.07); %convert image to binary
%figure, imshow(bin2Frame), title('Detected Face');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x = floor(size(bin2Frame,1)/2);
y = size(bin2Frame,2);
y2 = floor(size(bin2Frame,2)/2);


%bin2frame in x,y noktasýna ve ardýndaki 4 noktaya bak.

for i=1:size(bin2Frame,2)
    if(bin2Frame(y2,i)==1 && bin2Frame(y2,i+1)==1 && bin2Frame(y2,i+2)==1)
        disp(i);disp('white');yuz_orta1=i;break;
    end
end

for i=size(bin2Frame,2):-1:1
    if(bin2Frame(y2,i)==1 && bin2Frame(y2,i-1)==1 && bin2Frame(y2,i-2)==1)
        disp(i);disp('white');yuz_orta2=i;break;
    end
end

pos = [x y;x 1;yuz_orta1 y2;yuz_orta2 y2];
faceLandmark = insertMarker(I2,pos);
figure, imshow(faceLandmark), title('markedFace');