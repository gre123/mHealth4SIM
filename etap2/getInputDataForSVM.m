function processed = getInputDataForSVM(allData, range1, range2)
dataSize = range2;
if range2 == 0
    dataSize = numel(allData);
end 
for i = range1:dataSize
    currentImage = allData(i).image;
    cornerCount = [];
    thresholds = 1:100;
    for t = 1:100
        binaryImage = im2bw(currentImage, t/100);
        corners = corner(binaryImage);
        cornerCount(t) = length(corners(:,1));
    end
    %imshow(cornerCount);
end

processed = 0;
return