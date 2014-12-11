%Autorzy projektu:
%
%Agata Paciorek
%Piotr Knop
%Grzegorz Bylina
%
%Funkcja do przetwarzania pobranych zdjêæ
% @return processed - :
    % image - ca³y obraz
    % name - nazwa obrazu

function processed = processScansSVM(allData,range1,range2)
   processed = 0;
   getInputDataForSVM(allData,range1,range2);
   return;