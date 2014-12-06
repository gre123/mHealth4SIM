%Autorzy projektu:
%
%Agata Paciorek
%Piotr Knop
%Grzegorz Bylina
%
%Funkcja do œci¹gania i/lub ³adowania zdjêæ z http://peipa.essex.ac.uk/pix/mias
% @return allData - lista/macierz struktur o polach:
    % image - ca³y obraz
    % name - nazwa obrazu

function processed = processScans(allData)
disp('Przetwarzanie zdjêæ');
dataSize = numel(allData);
[x,y] = size(allData(1,1).image);
empt = logical(zeros(x,y));
processed = repmat(struct('image',empt,'name',''),1,dataSize);
first = true;
for k=1:dataSize
    img = allData(1,k).image;
    img2 = im2bw(img, entropyYen(img)/255);
    img3 = logical(zeros(x,y));
    
    %zaznaczanie elementów brzegowych
    for j=1:x
        for i=[1,y]
            if img2(j,i)>0
                img3(j,i) = 1;
            end
        end
    end
    for j=[1,x]
        for i=1:y
            if img2(j,i)>0
                img3(j,i) = 1;
            end
        end
    end
    
    %rekonstrukcja brzegu
    changes = true;
    st = strel('disk',9);
    while changes
        imgn = imdilate(img3,st);
        imgn(img2==0) = 0;
        if imgn == img3
            changes = false;
        end
        img3 = imgn;
    end
    img2(img3==1) = 0;
    processed(1,k).image = logical(img2);
    processed(1,k).name = allData(1,k).name;
    out = [num2str(k/dataSize*100,'%0.2f') '%%'];
    if ~first
        out = [repmat('\b',1,length(out)-1) out];
    end
    fprintf(out);
    first = false;
end

return