
/Base De Conocimiento /


%pareja(Persona, Persona)
pareja(marsellus, mia).
pareja(pumkin,    honeyBunny).

%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

% personaje(Nombre, Ocupacion)
personaje ( pumkin , ladron ([ estacionesDeServicio, licorerias ])).
personaje ( honeyBunny , ladron ([ licorerias , estacionesDeServicio ])).
personaje ( vincent , mafioso ( maton )).
personaje ( jules , mafioso ( maton )).
personaje ( marsellus , mafioso ( capo )).
personaje ( winston , mafioso ( resuelveProblemas )).
personaje ( mia , actriz ([ foxForceFive ])).
personaje ( butch , boxeador ).
personaje ( bernardo , mafioso ( cerebro )).
personaje ( bianca , actriz ([ elPadrino1 ])).
personaje ( elVendedor , vender ([ humo, iphone ])).
personaje ( jimmie, vender ([ auto] )).

% encargo ( Solicitante , Encargado , Tarea ).
% las tareas pueden ser cuidar ( Protegido ), ayudar ( Ayudado ),
buscar ( Buscado , Lugar)
encargo ( marsellus , vincent , cuidar ( mia )).
encargo ( vincent , elVendedor , cuidar ( mia )).
encargo ( marsellus , winston , ayudar ( jules )).
encargo ( marsellus , winston , ayudar ( vincent )).
encargo ( marsellus , vincent , buscar ( butch , losAngeles )).
encargo ( bernardo , vincent , buscar ( jules , fuerteApache )).
encargo ( bernardo , winston , buscar ( jules , sanMartin )).
encargo ( bernardo , winston , buscar ( jules , lugano )).


amigo ( vincent , jules ).
amigo ( jules , jimmie ).
amigo ( vincent , elVendedor ).

/PARTE 1/

/Punto 1/

saleCon(Quien, Cual):- 
   pareja(Quien,Cual).
   
saleCon(Quien,Cual):-
   pareja(Cual,Quien).


/Punto 2/

pareja(bernardo,bianca).
pareja(bernardo,charo).

/Punto 3/

trabajaPara(Alguien,bernardo):-
  trabajaPara(marsellus,Alguien).

trabajaPara(Alguien,george):-
   saleCon(bernardo,Alguien).
   
trabajaPara(Alguien,george):-
   saleCon(Alguen,bernardo).   
   
   
   
/Punto 4/

esFiel(Personaje):-
 /con un forall pero no se bien como plantearlo, me confunde la aclaracion del not en el enunciado. /

  
  
  
 /Punto 5/
/Es con recursividad. /



/PARTE 2/

/Punto1/

esPeligroso(Personaje):-
   actividadPeligrosa(Personaje).
   
esPeligroso(Personaje):-
  jefePeligroso(Personaje).
  
actividadPeligrosa(Personaje):-
   personaje ( Personaje , mafioso ( maton )).

actividadPeligrosa(Personaje):-
 personaje ( Personaje , ladron ([ _, licorerias ])).
    
actividadPeligrosa(Personaje):-
 personaje ( Personaje , ladron ([licorerias, _])).
 
jefePeligroso(Personaje):-
   trabajaPara(Empleador,Personaje),
   esPeligroso(Empleador).
   
/Por ahi funciona con recursividad/

