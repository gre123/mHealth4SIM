function processed = getInputDataForSVM(allData, range1, range2)
dataSize = range2;
if range2 == 0
    dataSize = numel(allData);
end 
for i = range1:dataSize
    currentImage = allData(i).image;
    cornerCount = [];
    thresholds = 10:15:100;
    i=0;
    for t = thresholds
        i=i+1;
        binaryImage = im2bw(currentImage, t/100);
        corners = corner(binaryImage,1000);
        cornerCount(i) = length(corners(:,1));
    end
    figure(1);
    plot(thresholds, cornerCount);
    grid;
    figure(2)
    plot(thresholds, gradient(cornerCount))
    grid;
    [c,w] = min(gradient(cornerCount));
    processed.optimThreshold = thresholds(w);
    binaryImage = im2bw(currentImage, processed.optimThreshold/100);
    corners = corner(binaryImage,1000);
    cornersSize = length(corners(:,1));
    for c = 1:cornersSize
        cornersIntensity(c) = currentImage(corners(c,1),corners(c,2));
    end
    processed.cornersIntensity = cornersIntensity;
end

return