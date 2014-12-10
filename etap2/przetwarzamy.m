%Autorzy projektu:
%Agata Paciorek
%Piotr Knop
%Grzegorz Bylina
%
clear all;
clearvars;
clc;

allData = getAllData();

processedData = processScans(allData);

contouredData = contourResults(processedData);

displayAllColored(allData, contouredData);