%Autorzy projektu:
%
%Agata Paciorek
%Piotr Knop
%Grzegorz Bylina
%
%Funkcja do przetwarzania pobranych zdj��
% @return processed - :
    % image - ca�y obraz
    % name - nazwa obrazu

function processed = processScansSVM(allData,range1,range2)
   processed = preprocessingConversionAndKMeanClustering(allData,range1,range2);
   
   %processed = subImaging(allData,range1,range2);
  % [texture,shape] = extractFeatures(allData,range1,range2);
   return;