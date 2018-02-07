close all
clear all

%VideoCapture
writerObj = VideoWriter('videoTest.mp4','MPEG-4');
writerObj.FrameRate = 1;
%writerObj.Height=1920;
%writerObj.Width=1080;
%writerObj.getProfiles
open(writerObj);



FFN=1;
FFCil=1;
FFR=1;
FFCm=1;
FFV=1;
FFRepulsiva=1;

numeroesemplari=35;
branchimezzi=3;
branchi=branchimezzi*2+1;
dimensionemondo=110;
tempoFinale=50;
npt=301;
deltaT=tempoFinale/(npt-1);
delta=1;
%velocita=10;
nido=[0;140;140];
xcil=[-20,20,0,-20,20];%x centro cilindro
ycil=[-10,-10,20,50,50];%y centro cilindro
rcil=[2,2,2,2,2];%raggio cilindro
Rcil=[6,6,6,6,6];%raggio cilindro cominciano forze repulsive
puntodivista=2;%visuale dall'alto 2D->2, in 3D->3


% inizializza le celle
for a=1:numeroesemplari
    pos{a}=zeros(3,npt);
end
% mette la posizione iniziale

esemplariPerBranco=numeroesemplari/branchi;
a=0;
for b=-branchimezzi:branchimezzi
    for aCiclo=1:esemplariPerBranco;
        a=a+1;
        pos{a}(:,1)=randn(3,1)*delta+[b*30;-50;0];
    end
end



% for a=1:numeroesemplari
%    
%     shiftEsemplari=(numeroesemplari-1)/2+1;
%     
%     un branco iniziale
%     
%     pos{a}(:,1)=randn(3,1)*delta-[30;0;0];
%     
%     2 branchi iniziali
%     
%      if a<numeroesemplari/2
%          pos{a}(:,1)=randn(3,1)*delta+[-15;-30;0];
%      else
%          pos{a}(:,1)=randn(3,1)*delta+[15;-30;0];
%      end
%      
%      3 branchi
%      
%      if a<=numeroesemplari/3
%          pos{a}(:,1)=randn(3,1)*delta+[-30;-30;0];
%      elseif a>numeroesemplari/3 && a<=2*numeroesemplari/3
%          pos{a}(:,1)=randn(3,1)*delta+[0;-30;0];
%      else a>2*numeroesemplari/3
%          pos{a}(:,1)=randn(3,1)*delta+[30;-30;0];
%      end
%      
%      
%      
%          if a-shiftEsemplari>b*numeroesemplari/branchi && a-shiftEsemplari<(b+1)*numeroesemplari/branchi
%              
%          end
%      end
%      
%              
%     
% end





disp('Inizia la simulazione')
tic

% initia la simulatione
for k=2:npt
    %calcolaree il centro di massa (CM)
    
        %cm=CM(pos,k-1);
      
        cmlDelta=zeros(numeroesemplari,numeroesemplari);
        for j=1:numeroesemplari
            cml(:,j)=CML(pos,k-1,j);
        end
        %cml
        clear j
        for a=1:numeroesemplari
            %calcolare il centro di massa locale (CML)
            for j=1:numeroesemplari
                cmlDelta(j,a)=norm(cml(:,a)-cml(:,j));
            end
        end
    
    for a=1:numeroesemplari
        
        if (FFV==1)
        
        Gruppi=DivisioneGruppiMarco(cmlDelta,numeroesemplari);
        
        
        puntoV=zeros(3,numeroesemplari);
        esemplariPerGruppo=sum(Gruppi,2);
        % esemplariPerGruppo e un array lungo numero di gruppi
        % esemplariPerGruppo(i) e il numero di esemplari nel gruppo i?
        appartenenza=zeros(numeroesemplari,1);
        
        numeroDiGruppi=size(Gruppi,1);
        numerazioneLocale=zeros(numeroesemplari,1);
        
        for j=1:numeroDiGruppi
            
            gruppo=Gruppi(j,:);
            cmlMedioDelGruppo=(cml*gruppo')/esemplariPerGruppo(j);
            
            puntoV=puntoV+cmlMedioDelGruppo*gruppo;
            
            dove=find(gruppo>0.5);
            appartenenza(dove)=j;
            
            numerazioneLocale(dove)=[1:esemplariPerGruppo(j)];
            
        end
        % dove iniyia la V
        % quanti esemplari ci sono nella V
        
    end    
        if (FFN==1)
            forzaN=forzaVersoNido(pos{a}(:,k-1),nido);
        else
            forzaN=zeros(3,1);
        end
        forzacil=[0;0;0];
        if (FFCil==1)
            for numCil=1:length(xcil)
            centrocilnido=[nido(1,1)-xcil(numCil);nido(2,1)-ycil(numCil); 0];
            indnido=[nido(1,1)-pos{a}(1,k-1);nido(2,1)-pos{a}(2,k-1); 0];
            vecProd=cross(centrocilnido,indnido);
            prodottoscalare=centrocilnido(1,1)*indnido(1,1)+centrocilnido(2,1)*indnido(2,1);
            angolo=acos(prodottoscalare/(norm(centrocilnido)*norm(indnido)));
            if (vecProd(3)>0)
                segno=1;
            else
                segno=-1;
            end
            forzacil=forzacil+ForzaCilindro(xcil(numCil),ycil(numCil),rcil(numCil),Rcil(numCil),pos{a}(:,k-1),segno*angolo);%collega i 2 file, le variabili possono essere con nomi diversi
            end
        end
        if (FFR==1)
            forzaR=forzaRandom(pos{a}(:,k-1));
        else
            forzaR=zeros(3,1);
        end
        if (FFCm==1)
            %calcolare il centro di massa locale (CML)
            cmll=CML(pos,k-1,a);
            forzaC=forzaCM(pos{a}(:,k-1),cmll);
        else
            forzaC=zeros(3,1);
        end
     
        if (FFRepulsiva==1)
            forzaRepul=forzaRepulsiva(pos,k-1,a);
        else
            forzaRepul=zeros(3,1);
        end
        
        forzaParziale=forzaN+forzacil+forzaR+forzaC+forzaRepul;
          
        if (FFV==1)
            vettoreZ=[0;1;0];
            angoloV=acos((forzaParziale(1,1)*vettoreZ(1,1)+forzaParziale(2,1)*vettoreZ(2,1)+forzaParziale(3,1)*vettoreZ(3,1))/(norm(forzaParziale)*norm(vettoreZ)));
            if forzaParziale(1,1)>0
                angoloV=2*pi-angoloV;
            end
            forzaV=ForzaFormazioneV2(puntoV(:,a),numerazioneLocale(a),esemplariPerGruppo(appartenenza(a)),pos{a}(:,k-1),angoloV);
        else
            forzaV=zeros(3,1);
        end
        forzaTotale=forzaParziale+forzaV;
        pos{a}(:,k)=pos{a}(:,k-1)+deltaT*forzaTotale;
    end
end
toc
disp('fine simulazione')

%grafica cilindro

%generi angoli circonferenza e copi all'infinito

theta=linspace(0,2*pi,50);%terzo num punti,circonferenza


if (verticalview==1)
    hcilindri=2*dimensionemondo+1;
else
    hcilindri=10;%<------------------------------------Parametro di overflow
end

zcirconferenza=[-dimensionemondo:hcilindri:+dimensionemondo];
for esemCil=1:length(xcil)
xcirconferenza{esemCil}=rcil(esemCil)*cos(theta)+xcil(esemCil);
ycirconferenza{esemCil}=rcil(esemCil)*sin(theta)+ycil(esemCil);

xForzacirconferenza{esemCil}=Rcil(esemCil)*cos(theta)+xcil(esemCil);
yForzacirconferenza{esemCil}=Rcil(esemCil)*sin(theta)+ycil(esemCil);


end
% se e lento aumentare il passo
% se non ci sono abbastanza punti per disegnare il cilindro, diminuire il
% passo


toc
disp('fine pre grafica')

%VideoCapture
figure('Position',[1 1 1440 900]);% da attivare per settare la risoluzione. Attenzione e buggato, la dimensione e strana

for k=1:1:npt
    
     plot3(pos{1}(1,k),pos{1}(2,k),pos{1}(3,k),'*');
     
     hold on
     for a=2:numeroesemplari
         plot3(pos{a}(1,k),pos{a}(2,k),pos{a}(3,k),'*');
     end
     xlim([-dimensionemondo,dimensionemondo]);
     ylim([-dimensionemondo,dimensionemondo]);
     zlim([-dimensionemondo,dimensionemondo]);
     title(num2str(k))
     
     plot3(nido(1),nido(2),nido(3),'^');
     
     for e=1:length(zcirconferenza)
         for esemCil=1:length(xcil)
         plot3(xcirconferenza{esemCil},ycirconferenza{esemCil},zcirconferenza(e)*ones(size(xcirconferenza{esemCil})),'k');%stampa il cilindro in 3 dimensioni. il size(...) e una conversione
         plot3(xForzacirconferenza{esemCil},yForzacirconferenza{esemCil},zcirconferenza(e)*ones(size(xcirconferenza{esemCil})),'r');%stampa il cilindro in 3 dimensioni. il size(...) e una conversione
         end
     end
         
    view(puntodivista)%cambiare prospettiva durante la grafica
     
    %VideoCapture
    set(gcf,'Color',[0.8 0.8 0.8]);%parametri impostano colore RGB attorno simulazione (grigio 0.8x3, blu chiaro 0.2 0.6 0.8, blu + scuro 0.2 0.4 0.8)
    frame=getframe(gcf);
    writeVideo(writerObj,frame);
     
     pause(0.00001)
     hold off
end
%VideoCapture
close(writerObj);%termina filmato