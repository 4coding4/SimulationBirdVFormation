function [forza]=forzaRepulsiva(pos,k,a)

pos_a=pos{a}(:,k);
forza=[0;0;0];
for i=1:length(pos)
    if (i~=a)
        vettore=pos{i}(:,k)-pos_a;
        distanza=norm(vettore);
        if distanza<5
            versore=-vettore/distanza;
            valoreForza=1/distanza^2;
            forza=0.15*valoreForza*versore;
        end
    end
end


forza;