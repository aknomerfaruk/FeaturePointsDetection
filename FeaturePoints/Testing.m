% read an input image and detect facial regions (face, eyes, mouth, and eyebrows)

clc; clear;

% read the input image
I = imread('face.jpg');
I = imresize(I, [224,224]);

%[imgFace, LeftEye, RightEye, Mouth, LeftEyebrow,  RightEyebrow] = detectFacialRegions(I);
[imgFace, Mouth] = detectFacialRegions(I);
% landmark detection

% landmark setting to Eyes and Mouth (4 and 5)
landconf = 5;


imgMouth = (imgFace(Mouth(1,2):Mouth(1,2)+Mouth(1,4),Mouth(1,1):Mouth(1,1)+Mouth(1,3),:));
[landMouth, MouthCont] = processMouth(imgMouth,landconf);


imshow(imgFace,'InitialMagnification',50); hold on;

%returns Landmarks
showsLandmarks(landMouth,MouthCont,Mouth,landconf);

% returns the coordinates of the landmarks (mouth)
coordMouth = landmarks(landMouth,MouthCont,Mouth,landconf);