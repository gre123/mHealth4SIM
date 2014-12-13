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
    figure(1)
    imshow(allData(i).image);
    figure(2)
    
    %K-mean Clustering
    nColors = 3;
    currentImage = double(allData(i).image(:,:,1:2));
    ab = reshape(currentImage,1024*1024,2);
    % repeat the clustering 3 times to avoid local minima
    [cluster_idx] = kmeans(ab,nColors,'emptyaction','singleton');
    nrows = size(currentImage,1);
    ncols = size(currentImage,2);
    pixel_labels = reshape(cluster_idx,nrows,ncols);
    imshow(pixel_labels,[]), title('image labeled by cluster index');
    processed = cluster_idx;
end
return;
