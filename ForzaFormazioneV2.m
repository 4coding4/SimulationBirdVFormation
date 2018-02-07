function [vettore]= ForzaFormazioneV2 (baricentroV,numeroesemplare,numeroesemplari, posizzioneiniziale,angoloV)
% Variabili
delta=20;
velocita=10; %velocita massima raggiunta dal esemplare
larghezzaV=1; %orrizontale, asse x
grandezzaV=2; %verticale, asse y

% angoloV=angoloV*2*pi*(1/360); %converti angolo da sesagesimali a radianti

vettore=zeros(3,1); %matrice vettore
FV=zeros(3,1);
matricerotazione=[cos(angoloV),-sin(angoloV),0 ; sin(angoloV),cos(angoloV),0 ; 0,0,1];
correttore=zeros(3,1);
% posizzioni dello stormo; bisohgna controllare lorientamento della V
X=linspace(-numeroesemplari,numeroesemplari,numeroesemplari);
Y=linspace(-numeroesemplari,numeroesemplari,numeroesemplari);
Z=zeros(1,numeroesemplari);
arrivoV=[ X*larghezzaV ; grandezzaV*-abs(Y) ; Z];
%correzzione del baricentro artificiale con quello del cml

correttore(1,1)=0;
correttore(2,1)=-(2/3)*(Y(1)-Y(numeroesemplari));
correttore(3,1)=0;

puntodiinizioV=baricentroV+(matricerotazione*correttore);

arrivoV=(matricerotazione*arrivoV(:,numeroesemplare))+puntodiinizioV;
%size(arrivoV)
%numeroesemplare
%posizzioneiniziale
FV=arrivoV-posizzioneiniziale;
vettore(:, 1)=FV(:,1).*abs(FV(:,1))*(1/10);
if norm(vettore(:,1))>velocita %se la velocit diventa eccesiva; supera la velocita massima viene ridotta ad essa senza perdere la direzione
    vettore(:,1)=vettore(:,1)/norm(vettore(:,1))*velocita;
end
end