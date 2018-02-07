function [forza]=forzaCM(posizioneEsemplare,CM)

eps=1e-8;
%simulazione utilizza questa funzione

    vettore=CM-posizioneEsemplare;
    
    distanza=norm(vettore);
    
    if (distanza<eps)
        forza=[0;0;0];
    else
        versore=vettore/distanza;
        valoreForza=0.25*distanza;
        forza=valoreForza*versore;
    end
    
end

    