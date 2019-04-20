function [redA, binFrame] = EyeLandmarks(landmark)

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

end
