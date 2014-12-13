function processed = preprocessingConversionAndKMeanClustering(allData,range1,range2)
dataSize = range2;
if range2 == 0
    dataSize = numel(allData);
end 
cform = makecform('srgb2lab');
for i = range1:dataSize
    currentImage = allData(i).image;
    %Zwiekszanie kontrastu
    allData(i).image = imadjust(currentImage);
    %Medianka
    allData(i).image = medfilt2(allData(i).image,[2 2]);
    allData(i).image(:,:,2) = allData(i).image(:,:,1);
    allData(i).image(:,:,3) = allData(i).image(:,:,1);
    
    %RGB -> Lab
    allData(i).image = applycform(allData(i).image,cform);
    
    %K-mean Clustering
    currentImage = allData(i).image;
    ab = double(currentImage(:,:,2:3));
    nrows = size(ab,1);
    ncols = size(ab,2);
    ab = reshape(ab,nrows*ncols,2);
    nColors = 2;
    % repeat the clustering 3 times to avoid local minima
    [cluster_idx centers] = kmeans(ab,nColors,'start','uniform');
    processed = cluster_idx;
end
return;