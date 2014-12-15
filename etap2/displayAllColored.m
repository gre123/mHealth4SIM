%Autorzy projektu:
%
%Agata Paciorek
%Piotr Knop
%Grzegorz Bylina
%
%Funkcja do wyswietlania


function [] = displayAllColored(allData, contouredData,secondMethodData,range1,range2)
dataSize = range2;
if range2 == 0
    dataSize = numel(contouredData);
end 
for k = range1:dataSize
    img = allData(1,k).image;
    img2 = contouredData(1,k).image;
    R = img;
    R(img2==1) = 255;
    G = img;
    G(img2==1) = 0;
    B = G;
    img3(:,:,1) = R;
    img3(:,:,2) = G;
    img3(:,:,3) = B;
    subplot(2,2,1);
    imshow(allData(1,k).image);
    title(allData(1,k).name);
    subplot(2,2,2);
    imshow(img3);
    subplot(2,2,3);
    imshow(secondMethodData(k).image);
    if ~isempty(secondMethodData(k).boxes)
        for i = 1:size(secondMethodData(k).boxes,2)
            if length(secondMethodData(k).boxes(:,i)) == 4
                rectangle('Position',secondMethodData(k).boxes(:,i),'EdgeColor','r');
            end
        end
    end
    title(secondMethodData(k).name)
    waitforbuttonpress();
end

end