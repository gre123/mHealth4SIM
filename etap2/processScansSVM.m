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
   processed = 0;
   getInputDataForSVM(allData,range1,range2);
   return;