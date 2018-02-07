function [ Gruppi ] = DivisioneGruppi(cmlDelta,numeroesemplari)
x=1;
raggiodiazione=5;
NGruppi=x;
Gruppi=zeros(1,numeroesemplari);
Lista=[1:1:numeroesemplari];
while norm(Lista)>0  %-1e-15 %togliere dal loop generale, due KK
    norm(Lista);
    y=0;
    g=1;
    while y==0 %il primo degli esemplari liberi
        
        
        if Lista(1,g)>0
            y=Lista(1,g);
            g=y;
        else
            g=g+1;
        end
    end
    for j=1:numeroesemplari
        if Lista(j)>0
            if cmlDelta(j,g)<=raggiodiazione
                Gruppi(x,j)=1;
            else
                Gruppi(x,j)=0;
            end
        end
    end
    for h=1:numeroesemplari
        if Gruppi(x,h)==1
            Lista(h)=0;
        end
    end
    sommaGruppi=sum(sum(Gruppi));
    if sommaGruppi<numeroesemplari
        x=x+1;
    end
end
% end while, questa sezione ci da la matrice con i gruppi.
%Gruppi

end

