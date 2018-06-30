%Base De Conocimiento


%pareja(Persona, Persona)
pareja(marsellus,mia).
pareja(pumkin,honeyBunny).
pareja(bernardo,bianca).
pareja(bernardo,charo).

%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus,vincent).
trabajaPara(marsellus,jules).
trabajaPara(marsellus,winston).

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
acataOrden(Empleador,Empleado):-
    trabajaPara(Empleador,Empleado).
    
acataOrden(Empleador,Empleado2):-
    trabajaPara(Empleador,Empleado1),
    trabajaPara(Empleado1,Empleado2).

%Esta funcion no es recursiva ya que no se llama a si misma. 

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
   
% Por ahi es con recursividad


%Punto 2
%No me muestra quien es esa persona como en el ejemplo, debe estar mal

sanCayetano(Persona):-
  forall(tieneCerca(Persona, OtraPersona), encargo( Persona, OtraPersona , _ )),
  Persona\=OtraPersona.
  
tieneCerca(Persona, OtraPersona):-
   amigo(Persona, OtraPersona).  

tieneCerca(Persona, OtraPersona):-
   amigo(OtraPersona,Persona).
   
tieneCerca(Persona, OtraPersona):-
   trabajaPara(Persona, OtraPersona).
   
tieneCerca(Persona, OtraPersona):-
   trabajaPara(OtraPersona,Persona).
 
 
%Punto 3
%No estaria sabiendo como encatar el de actrices

nivelRespeto(Personaje, 10):-
    personaje(Personaje, mafioso(resuelveProblemas)).
	
nivelRespeto(Personaje, 20):-
    trabajaPara(Personaje, _).
	
nivelRespeto(vincent, 15).

%Punto 4



%Punto 5



