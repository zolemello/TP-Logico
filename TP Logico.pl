%Base De Conocimiento (trabajaPara en el punto 3 parte 1). 


%pareja(Persona, Persona)
pareja(marsellus,mia).
pareja(pumkin,honeyBunny).
pareja(bernardo,bianca). %Punto 2 parte 1
pareja(bernardo,charo). %Punto 2 parte 1


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
-%Es recursivo ya que la funcion se llama a si misma.
acataOrden(Empleador, Alguien):-  %caso base
	trabajaPara(Empleador, Alguien). 

acataOrden(Empleador, Alguien):-    %caso inductivo
	trabajaPara(Empleador, Empleado), 
	acataOrden(Empleado, Alguien).



% PARTE 2/

%Punto1/
esPeligroso(Personaje):-
   actividadPeligrosa(Personaje).

esPeligroso(Personaje):-
  jefePeligroso(Personaje).

actividadPeligrosa(Personaje):-
   personaje(Personaje,mafioso( maton )).

actividadPeligrosa(Personaje):-
 personaje(Personaje,ladron([ _, licorerias ])).

actividadPeligrosa(Personaje):-
 personaje(Personaje,ladron([licorerias, _])).

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

nivelRespeto(Personaje,Nivel):-
   personaje(Personaje,actriz(Lista)),
   length(Lista,Largo),
   Nivel is Largo/10.

nivelRespeto(Personaje, 10):-
    personaje(Personaje, mafioso(resuelveProblemas)).
	
nivelRespeto(Personaje, 20):-
    personaje(Personaje, mafioso(capo)).
	
nivelRespeto(vincent, 15).



%Punto 4

personajeRespetable(Personaje):-
   personaje(Personaje,_),
   nivelRespeto(Personaje,Nivel),
   Nivel>=9.
personajeNoRespetable(Personaje):-
   personaje(Personaje,_),
   nivelRespeto(Personaje,Nivel),
   Nivel<9.
personajeNoRespetable(Personaje):-
   personaje(Personaje,_),
   not(nivelRespeto(Personaje,_)).

	
respetabilidad(Respetable,NoRespetable):-
   findall(Personaje,personajeRespetable(Personaje),ListaPersonajes),
   length(ListaPersonajes,Respetable),
   findall(Personaje,personajeNoRespetable(Personaje),ListaPersonajesNoRespetables),
   length(ListaPersonajesNoRespetables,NoRespetable).

%Punto 5

masAtareado(Quien):-
   personaje(Quien,_),
   cantidadEncargos(Quien,Cantidad),
   forall(cantidadEncargos(_,CantidadEncargos),Cantidad>=CantidadEncargos).

cantidadEncargos(Quien,Cantidad):-
   personaje(Quien,_),
   findall(Quien,encargo(_,Quien,_),Encargos),
   length(Encargos,Cantidad).


