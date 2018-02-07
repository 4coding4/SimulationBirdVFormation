function Fr=ForzaCilindro(x,y,r,R,Pos,angolo)%funzione forza cilindro allontana uccelli tipo elettroni

n=100;%coefficiente da variare

distanzadalcentro=sqrt((Pos(1,1)-x)*(Pos(1,1)-x)+(Pos(2,1)-y)*(Pos(2,1)-y));%calcola dist centro in 2D

forzaopposta=[2*(Pos(1,1)-x);2*(Pos(2,1)-y);0];%forza/vettore che spara perpendicolarmente all'opposto della forza in
%arrivo->forza repulsive
forzaopposta=forzaopposta/norm(forzaopposta);


if angolo>=0
    lato=90;%lato destro
else %angolo<0
    lato=-90;%lato sinistro
end
matricerotazione=[cos(lato),-sin(lato),0;sin(lato),cos(lato),0;0,0,1];

forzaperpendicolare=matricerotazione*forzaopposta;

forzacilindro=forzaperpendicolare+forzaopposta;
if(distanzadalcentro>R)%forza inesistente
    Fr=0*forzacilindro;
else
    Fr=n*1/((distanzadalcentro-r)*(distanzadalcentro-r))*forzacilindro; %calcola forza
end