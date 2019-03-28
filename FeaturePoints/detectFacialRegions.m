function  [imgFace, Mouth] = detectFacialRegions(I)

%To Detect Face
YuzBul = vision.CascadeObjectDetector;
Face = step(YuzBul,I);
imgFace = I(Face(1,2):Face(1,2)+Face(1,4),Face(1,1):Face(1,1)+Face(1,3),:);
 
%To Detect Mouth
AgizBulucu = vision.CascadeObjectDetector('Mouth');
findMouth=step(AgizBulucu,imgFace);
orderMouth= sortrows(findMouth,2);
posMouth = size(findMouth,1);
Mouth = orderMouth(posMouth,:);

end