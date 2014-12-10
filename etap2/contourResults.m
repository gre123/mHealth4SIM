%Autorzy projektu:
%
%Agata Paciorek
%Piotr Knop
%Grzegorz Bylina
%
%Funkcja do obrysowywania znalezionych anomalii
% @return processed - lista/macierz struktur o polach:
    % image - ca³y obraz
    % name - nazwa obrazu

function contouredData = contourResults(processedData)
disp('Kolorowanie wyników');
dataSize = numel(processedData);
[x,y] = size(processedData(1,1).image);
empt = logical(zeros(x,y));
contouredData = repmat(struct('image',empt,'name',''),1,dataSize);
st = strel('disk',7);
first = true;
for k=1:dataSize
    img = processedData(1,k).image;
    img2 = imdilate(img,st);
    img2(img==1) = 0;
    contouredData(1,k).image = img2;
    contouredData(1,k).name = processedData(1,k).name;
    outStr = [num2str(k/dataSize*100,'%0.2f') '%%'];
    out = outStr;
    if ~first
        out = [repmat('\b',1,lenOut) out];
    end
    lenOut = length(outStr)-1;
    fprintf(out);
    first = false;
    end
end