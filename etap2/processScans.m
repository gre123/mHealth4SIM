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

function processed = processScans(allData,range1,range2)
disp('Przetwarzanie zdjêæ');
dataSize = range2;
if range2 == 0
    dataSize = numel(allData);
end 
[x,y] = size(allData(1,1).image);
empt = logical(zeros(x,y));
processed = repmat(struct('image',empt,'name',''),1,dataSize);
first = true;
st = strel('disk',7);
for k=range1:dataSize
    img = allData(1,k).image;
    %wyznaczanie lewego i prawego pustego brzegu
    left_x = 0;
    right_x = x;
    temp_y = 0;
    cont = true;
    while cont && temp_y<y
        temp_y=temp_y+1;
        while cont && left_x<x
            left_x = left_x+1;
            if img(temp_y,left_x) > 20
                cont = false;
            end
        end
        if cont
            left_x = 0;
        end
    end
    temp_y = 0;
    cont = true;
    while cont && temp_y<y
        temp_y=temp_y+1;
        while cont && right_x>1
            right_x = right_x-1;
            if img(temp_y,right_x) > 20
                cont = false;
            end
        end
        if cont
            right_x = x;
        end
    end
    img_cut = img(:,left_x:right_x);
    thr = entropyYen(img_cut)/255;
    if (thr < 130 / 255 ) 
        thr = 130 / 255;
    end
    [x_c,y_c] = size(img_cut);
    img2 = im2bw(img_cut, thr);
    img2 = imopen(img2,st);
    img3 = logical(zeros(x_c,y_c));
    
    %zaznaczanie elementów brzegowych
    for j=1:x_c
        for i=[1,y_c]
            if img2(j,i)>0
                img3(j,i) = 1;
            end
        end
    end
    for j=[1,x_c]
        for i=1:y_c
            if img2(j,i)>0
                img3(j,i) = 1;
            end
        end
    end
    
    %rekonstrukcja brzegu
    changes = true;
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
    img4 = zeros(x,y);
    img4(:,left_x:right_x) = img2;
    img4 = imopen(img4,st);
    img4 = imdilate(img4,st);
    processed(1,k).image = logical(img4);
    processed(1,k).name = allData(1,k).name;
    %pasek postêpu
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