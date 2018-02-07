function [forza]=forzaVersoNido(posizioneEsemplare,posizioneNido)

    vettore=posizioneNido-posizioneEsemplare;
    
    distanza=norm(vettore);
    
    versore=vettore/distanza;
    
    %valoreForza=distanza
    
    valoreForza=distanza^(1/3);
    %valoreForza=1
    
    forza=valoreForza*versore;

end