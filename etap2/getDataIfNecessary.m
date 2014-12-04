%Autorzy projektu:

%Agata Paciorek
%Piotr Knop
%Grzegorz Bylina
%
%Skrypt/funkcja do �ci�gania zdj�� z bazy

function [dest] = getDataIfNecessary()

server = ftp('figment.csee.usf.edu');
pasv(server);
dataMode(server)
mkdir('images');
cd(server,'pub/DDSM/cases/cancers/cancer_01/case0001');
dest = dir(server);
for i = 1:numel(dest)
    d = dest(i);
    name = d.name;
    spl = textscan(name,'%s','Delimiter','.');
    if strcmp(spl{1,1}(end),'LJPEG')
        mget(server,name,'images');
    end
end
close(server);

return