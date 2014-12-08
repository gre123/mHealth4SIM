%Autorzy projektu:
%
%Agata Paciorek
%Piotr Knop
%Grzegorz Bylina
%
%Funkcja do przetwarzania pobranych zdjêæ
% @return processed - lista/macierz struktur o polach:
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
    thr = entropyYen(img)/255;
    if (thr < 130 / 255 ) 
        thr = 130 / 255;
    end
    img2 = im2bw(img, thr);
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
    st = strel('disk',7);
    while changes
        imgn = imdilate(img3,st);
        imgn(img2==0) = 0;
        if imgn == img3
            changes = false;
        end
        img3 = imgn;
    end
    %odjêcie elementów brzegowych od obrazu
    img2(img3==1) = 0;
    img2 = logical(img2);
    %otwarcie obrazu w celu usuniêcia zanieczyszczeñ
    img4 = imopen(img2,st);
    img4 = imdilate(img4,st);
    img4(img2==0) = 0;
    processed(1,k).image = logical(img4);
    processed(1,k).name = allData(1,k).name;
    outStr = [num2str(k/dataSize*100,'%0.2f') '%%'];
    out = outStr;
    if ~first
        out = [repmat('\b',1,lenOut) out];
    end
    lenOut = length(outStr)-1;
    fprintf(out);
    first = false;
end

return