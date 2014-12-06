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

function allData = getAllData()

if exist('allData.mat','file') == 2
    load 'allData.mat';
    disp('Za³adowano lokaln¹ bazê');
    return
end
localData = dir('images');
if numel(localData) <= 2
    disp('Folder pusty - pobieram zdjecia ...');
    urlwrite('http://peipa.essex.ac.uk/pix/mias/all-mias.tar.gz','all-mias.tar.gz');
    untar('all-mias.tar.gz','images');
    delete('all-mias.tar.gz');
else
    disp('Folder nie jest pusty');
end

cd('images')
localData = ls('mdb*');
allData = [];
for i = 1:length(localData)
    sourceName = localData(i,:);
    objectName = sourceName(1:6);

    allData(i).image = imread(sourceName);
    allData(i).name = objectName;   
end
cd('../')

disp('£adowanie zdjêæ zakoñczone');
save('allData.mat','allData');

return

