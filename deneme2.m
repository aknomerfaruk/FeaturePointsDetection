resim=imread('image_0166.jpg'); 
I=imresize(resim, [240 320]);


detector = vision.CascadeObjectDetector(); 
bboxes = step(detector,I);
figure, imshow(I), title('Yüz bulundu');
rectangle('Position',bboxes(1,:),'LineWidth',2,'EdgeColor',[1 1 0]); hold on;

I2=imcrop(I,bboxes);
figure, imshow(I2);title('yüz kýrpýldý');

% yükseklik geniþlik
x=size(I2,1);
y=size(I2,2);

x2=floor(x/2);
h1x=x2; h1y=1;
h2x=x2; h2y=y;

y2=floor(y/2);
w1x=1; w1y=y2;
w2x=x; w2y=y2;

figure;imshow(I2);hold on;plot(h1x,h1y,'ro',h2x,h2y,'ro',w1x,w1y,'ro',w2x,w2y,'ro');

%renk
redA = I2(:,:,1);   % Extract red layer
grayFrame = rgb2gray(I2);  % convert frame to gray
diffFrame=imsubtract(redA, grayFrame); % subtract red and gray frame
bin2Frame = im2bw(diffFrame, 0.07); %convert image to binary
figure, imshow(bin2Frame), title('Detected Face');

figure;imshow(bin2Frame);hold on;plot(h1x,h1y,'ro',h2x,h2y,'ro',w1x,w1y,'ro',w2x,w2y,'ro');

% en bilgisi için
x=bin2Frame(y2,:);
find=14;  % find yönteminden indeksin bulunacak
c1=find; c2=y2;
figure;imshow(bin2Frame);hold on;plot(c1,c2,'ro');