function [V, CONT] = processMouth(imgMouth, landcont)

%Gauss Filtresini Uygula
Ig = imgaussfilt(imgMouth);
%Aðýz görüntüsünü yeniden boyutlandýr
resizemouth = 3;
satir = floor(length(Ig(:,1,1))*resizemouth);
sutun = floor(length(Ig(1,:,1))*resizemouth);
resim = imresize(Ig,[satir,sutun],'bilinear');
%floor her bir elemaný en yakýn tamsayýya yuvarlar
%imresize(I,[numrow,numcols])

hsv = rgb2hsv(resim);
[h,s,v] = rgb2hsv(resim);
%rgb resmi sýcaklýk bazýnda alýyor

se = strel('disk',5); % 5 yarýçaplý bir disk içerisinde iþlem yapacak
erodedHue = imerode(h,se); % resmin hue bölümünü aþýndýrma iþlemi yaptý
se= strel ('disk',8); % 8 yarýçaplý bir disk içerisinde iþlem
dilatedErodedHue = imdilate(erodedHue,se); %silinmiþ görüntü üzerinde 
% geniþletme iþlemi yaptý

bw = im2bw(dilatedErodedHue,graythresh(dilatedErodedHue));
%threshold deðeri için dilatedErodedHue thresh deðerini kabul etti

cc = bwconncomp(bw);
stats = regionprops(cc,'Area'); % Alaný seç
idx = find([stats.Area] == max([stats.Area]));
BW6 = ismember(labelmatrix(cc),idx); % conncomp larýn idx içinde bulunduðu
%diziyi dönderir

cannyMouth = edge(BW6,'canny',0.4); %sýnýrlarý 0.4 thresh deðeriyle 
%çizilmiþ canny mouth resmi

[V CONT] = detFeaturePoints(cannyMouth, resizemouth, landcont);

end