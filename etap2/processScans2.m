%Autorzy projektu:
%
%Agata Paciorek
%Piotr Knop
%Grzegorz Bylina
%
%Funkcja do przetwarzania pobranych zdjêæ
% @return processed - :
    % image - ca³y obraz
    % name - nazwa obrazu

function processed = processScans2(allData,range1,range2)
dataSize = range2;
if range2 == 0
    dataSize = numel(allData);
end 
cform = makecform('srgb2lab');
st = strel('disk',7);
for i = range1:dataSize
    currentImage = allData(i).image;
    
     %Zwiekszanie kontrastu
    allData(i).image = imadjust(currentImage,[0.66 0.7],[]);
    %Medianka
    allData(i).image = medfilt2(allData(i).image,[2 2]);
    allData(i).image(:,:,2) = allData(i).image(:,:,1);
    allData(i).image(:,:,3) = allData(i).image(:,:,1);
     
%     %RGB -> Lab
    allData(i).image = applycform(allData(i).image,cform);
    %figure(1)
    %imshow(allData(i).image);
    %figure(2)
    
%     %K-mean Clustering
    nColors = 2;
    currentImage = double(allData(i).image(:,:,1:2));
    ab = reshape(currentImage,1024*1024,2);
    % repeat the clustering 3 times to avoid local minima
    [cluster_idx] = kmeans(ab,nColors,'emptyaction','singleton');
    nrows = size(currentImage,1);
    ncols = size(currentImage,2);
    pixel_labels = reshape(cluster_idx,nrows,ncols);
    %imshow(pixel_labels,[]), title('image labeled by cluster index');
     
%     %regionprops
     STATS = regionprops(pixel_labels,'Image','Area');
     if STATS(1).Area>STATS(2).Area
         ourGoal = STATS(2).Image;
     else
         ourGoal = STATS(1).Image;
     end
     ourGoal = imerode(ourGoal,st);
     ourGoal = imerode(ourGoal,st);
     STATS = regionprops(ourGoal,'Image','Area','BoundingBox');
     %imshow(ourGoal,[]);
     max = 0;
     for m = 1:size(STATS)
         if STATS(m).Area > max
             max = STATS(1).Area;
         end
     end
     w=1;
     boundingBoxes = [];
     for m = 1:size(STATS)
         if STATS(m).Area ~= max
             boundingBoxes(:,w) = STATS(m).BoundingBox;
             w = w+1;
         end
     end
     processed(i).boxes = boundingBoxes;
     processed(i).image = ourGoal;
     processed(i).name = allData(i).name;
        
    
end
return;
