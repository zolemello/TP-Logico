%Base De Conocimiento (trabajaPara en el punto 3 parte 1). 


%pareja(Persona, Persona)
pareja(marsellus,mia).
pareja(pumkin,honeyBunny).
pareja(bernardo,bianca).
pareja(bernardo,charo).


% personaje(Nombre, Ocupacion)
personaje(pumkin,ladron([estacionesDeServicio,licorerias])).
personaje(honeyBunny,ladron([licorerias,estacionesDeServicio])).
personaje(vincent,mafioso(maton)).
personaje(jules,mafioso(maton)).
personaje(marsellus,mafioso(capo)).
personaje(winston,mafioso(resuelveProblemas)).
personaje(mia,actriz([foxForceFive])).
personaje(butch,boxeador).
personaje(bernardo,mafioso(cerebro)).
personaje(bianca,actriz([elPadrino1])).
personaje(elVendedor,vender([humo,iphone])).
personaje(jimmie,vender([auto])).

% encargo ( Solicitante , Encargado , Tarea ).
% las tareas pueden ser cuidar ( Protegido ), ayudar ( Ayudado ), buscar(Buscado,Lugar)
encargo(marsellus,vincent,cuidar(mia)).
encargo(vincent,elVendedor,cuidar(mia)).
encargo(marsellus,winston,ayudar(jules)).
encargo(marsellus,winston,ayudar(vincent)).
encargo(marsellus,vincent,buscar(butch,losAngeles)).
encargo(bernardo,vincent,buscar(jules,fuerteApache)).
encargo(bernardo,winston,buscar(jules,sanMartin)).
encargo(bernardo,winston,buscar(jules,lugano)).


amigo(vincent , jules ).
amigo(jules , jimmie ).
amigo(vincent , elVendedor ).

% PARTE 1/

% Punto 1/

saleCon(Quien, Cual):- 
   pareja(Quien, Cual).
   
saleCon(Quien,Cual):-
   pareja(Cual,Quien).



% Punto 3/
%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus,vincent).
trabajaPara(marsellus,jules).
trabajaPara(marsellus,winston).

trabajaPara(Alguien,bernardo):-
  trabajaPara(marsellus,Alguien),
  Alguien \=jules.

trabajaPara(Alguien,george):-
   saleCon(bernardo,Alguien).
   
trabajaPara(Alguien,george):-
   saleCon(Alguien,bernardo).   
   
   
   
% Punto 4/

esFiel(Personaje):-
	saleCon(Personaje, Persona1),
	forall(saleCon(Personaje,Persona2), not(Persona1\=Persona2)).

  
%Punto 5/
-%Es con recursividad. 
acataOrden(Empleador, Alguien):-  %caso base
	trabajaPara(Empleador, Alguien). 

acataOrden(Empleador, Alguien):-    %caso inductivo
	trabajaPara(Empleador, Empleado), 
	acataOrden(Empleado, Alguien).



% PARTE 2/

%Punto1/

esPeligroso(Personaje):-
	personaje(Personaje, Actividad),
	actividadPeligrosa(Actividad).
   
esPeligroso(Personaje):-
  jefePeligroso(Personaje).
  
actividadPeligrosa(mafioso(maton)).

actividadPeligrosa(ladron(Locales)):-
	member(licorerias, Locales).
    
jefePeligroso(Personaje):-
   trabajaPara(Empleador,Personaje),
   esPeligroso(Empleador).
   

%Punto 2

sanCayetano(Persona):-
   personaje(Persona,_),
   tieneCerca(Persona,_),
  forall(tieneCerca(Persona, OtraPersona), encargo( Persona, OtraPersona , _ )).

tieneCerca(Persona, OtraPersona):-
   amigo(Persona, OtraPersona).

tieneCerca(Persona, OtraPersona):-
   amigo(OtraPersona, Persona).

tieneCerca(Persona, OtraPersona):-
   trabajaPara(Persona, OtraPersona).

tieneCerca(Persona, OtraPersona):-
   trabajaPara(OtraPersona, Persona).

 
 
%Punto 3

nivelRespeto(Personaje, Respeto):-
    personaje(Personaje, actriz(Peliculas)),
	length(Peliculas, Cantidad),
	Respeto is Cantidad/10.

nivelRespeto(Personaje, 10):-
    personaje(Personaje, mafioso(resuelveProblemas)).
	
nivelRespeto(Personaje, 20):-
    personaje(Personaje, mafioso(capo)).
	
nivelRespeto(Personaje, 1):-
    personaje(Personaje, mafioso(maton)).
	
nivelRespeto(Personaje, 0):-
    personaje(Personaje, Actividad),
	Actividad\=mafioso(_),
	Actividad\=actriz(_).
	
nivelRespeto(vincent, 15).

%Punto 4

esRespetable(Personaje):-
	nivelRespeto(Personaje, Respeto),
	Respeto > 9.
noRespetable(Personaje):-
	nivelRespeto(Personaje, Respeto),
	Respeto < 9.
respetabilidad(Respetables,_):-
	findall(Personaje, esRespetable(Personaje), Personajes),
	length(Personajes, Respetables).
respetabilidad(_,NoRespetable):-
	findall(Personaje, noRespetable(Personaje), Personajes),
	length(Personajes, NoRespetable).

%Punto 5



