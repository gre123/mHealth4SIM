function processed = getInputDataForSVM(allData, range1, range2)
dataSize = range2;
if range2 == 0
    dataSize = numel(allData);
end 
for i = range1:dataSize
    currentImage = allData(i).image;
    cornerCount = [];
    thresholds = 5:10:100;
    i=0;
    for t = 1:5:100
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
    min(gradient(cornerCount))
end
processed = 0;
return