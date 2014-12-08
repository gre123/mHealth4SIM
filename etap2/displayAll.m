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

function [] = displayAll(allData, processedData)

for i = 1:numel(processedData)
subplot(1,2,1);
imshow(allData(1,i).image);
title(allData(1,i).name);
subplot(1,2,2);
imshow(processedData(1,i).image);
waitforbuttonpress();
end

end