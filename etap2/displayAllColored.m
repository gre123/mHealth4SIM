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

function [] = displayAllColored(allData, contouredData)

for k = 1:numel(contouredData)
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
    subplot(1,2,1);
    imshow(allData(1,k).image);
    title(allData(1,k).name);
    subplot(1,2,2);
    imshow(img3);
    waitforbuttonpress();
end

end