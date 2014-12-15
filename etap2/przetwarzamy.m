%Autorzy projektu:
%Agata Paciorek
%Piotr Knop
%Grzegorz Bylina
%
clear all;
clearvars;
clc;

range1 = input('Wprowad� dolny indeks zakresu zdj�� ');
range2 = input('Wprowad� g�rny indeks zakresu zdj�� ');
allData = getAllData();

processedData = processScans(allData,range1,range2);
processedData2 = processScans2(allData,range1,range2);
contouredData = contourResults(processedData,range1,range2);
displayAllColored(allData, contouredData,processedData2,range1,range2);