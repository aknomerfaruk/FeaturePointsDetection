function [V, CONT] = processMouth(imgMouth, landcont)

%Gauss Filtresini Uygula
Ig = imgaussfilt(imgMouth);
%A��z g�r�nt�s�n� yeniden boyutland�r
resizemouth = 3;
satir = floor(length(Ig(:,1,1))*resizemouth);
sutun = floor(length(Ig(1,:,1))*resizemouth);
resim = imresize(Ig,[satir,sutun],'bilinear');
%floor her bir eleman� en yak�n tamsay�ya yuvarlar
%imresize(I,[numrow,numcols])

hsv = rgb2hsv(resim);
[h,s,v] = rgb2hsv(resim);
%rgb resmi s�cakl�k baz�nda al�yor

se = strel('disk',5); % 5 yar��apl� bir disk i�erisinde i�lem yapacak
erodedHue = imerode(h,se); % resmin hue b�l�m�n� a��nd�rma i�lemi yapt�
se= strel ('disk',8); % 8 yar��apl� bir disk i�erisinde i�lem
dilatedErodedHue = imdilate(erodedHue,se); %silinmi� g�r�nt� �zerinde 
% geni�letme i�lemi yapt�

bw = im2bw(dilatedErodedHue,graythresh(dilatedErodedHue));
%threshold de�eri i�in dilatedErodedHue thresh de�erini kabul etti

cc = bwconncomp(bw);
stats = regionprops(cc,'Area'); % Alan� se�
idx = find([stats.Area] == max([stats.Area]));
BW6 = ismember(labelmatrix(cc),idx); % conncomp lar�n idx i�inde bulundu�u
%diziyi d�nderir

cannyMouth = edge(BW6,'canny',0.4); %s�n�rlar� 0.4 thresh de�eriyle 
%�izilmi� canny mouth resmi

[V CONT] = detFeaturePoints(cannyMouth, resizemouth, landcont);

end