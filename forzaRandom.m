function [forza]=forzaRandom(posizioneEsemplare)

    vettore=randn(3,1);
    
    distanza=norm(vettore);
    
    versore=vettore/distanza;

    
    % testare diversi approcci, mettere una funzione
    valoreForza=0.25;
    
    forza=valoreForza*versore;
end