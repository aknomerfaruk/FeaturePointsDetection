function  distance  =  eucDistance(x,y)
% is to calculate the Euclidean distance between points x and y
dif = x - y;
distance = sqrt(dif*transpose(dif) );
end
