%Autorzy projektu:

%Agata Paciorek
%Piotr Knop
%Grzegorz Bylina
%
%Skrypt/funkcja do �ci�gania zdj�� z bazy

function [] = getDataIfNecessary()

server = ftp('figment.csee.usf.edu');
mget(server,'/pub/DDSM/cases/cancers/cancer_01/case0001');
close(server);
return