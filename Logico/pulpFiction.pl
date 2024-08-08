personaje(pumkin,     ladron([licorerias, estacionesDeServicio])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent,    mafioso(maton)).
personaje(jules,      mafioso(maton)).
personaje(marsellus,  mafioso(capo)).
personaje(winston,    mafioso(resuelveProblemas)).
personaje(mia,        actriz([foxForceFive])).
personaje(butch,      boxeador).

pareja(marsellus, mia).
pareja(pumkin,    honeyBunny).

%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).

%encargo(Solicitante, Encargado, Tarea). 
%las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).



%etc

%---- punto 1 --------

espeligroso(Personaje):-
    actividadPeligrosa(Personaje).

espeligroso(Personaje):-
    trabajaPara(Personaje, Empleado),
    espeligroso(Empleado).

actividadPeligrosa(Personaje):-
    personaje(Personaje, mafioso(maton)).

actividadPeligrosa(Personaje):-
    personaje(Personaje, ladron(Lugares)),
    member(licorerias, Lugares).

% ---- punto 2 ---------
duoTemible(Personaje, OtroPersonaje):-
    sonParejaoAmigo(Personaje, OtroPersonaje),
    espeligroso(Personaje),
    espeligroso(OtroPersonaje).

sonParejaoAmigo(Personaje, OtroPersonaje):-
    pareja(Personaje, OtroPersonaje).

sonParejaoAmigo(Personaje, OtroPersonaje):-
    amigo(Personaje, OtroPersonaje).

% ---- punto 3 ---------
estaEnProblemas(Personaje):-
    tieneJefePeligroso(Personaje, Jefe),
    pareja(Jefe, Esposa),
    encargo(Jefe, Personaje, cuidar(Esposa)).

tieneJefePeligroso(Personaje, Jefe):-
    trabajaPara(Jefe, Personaje),
    espeligroso(Jefe).

estaEnProblemas(Personaje):-
    encargo(_, Personaje, buscar(OtroPersonaje, _)),
    esBoxeador(OtroPersonaje).

esBoxeador(Personaje):-
    personaje(Personaje, boxeador).

% ---- punto 4 ---------
sanCayetano(Personaje):-
    cercanoA(Personaje, _),
    forall(cercanoA(Personaje, OtroPersonaje), (encargo(Personaje, OtroPersonaje, _))).

cercanoA(Personaje, OtroPersonaje):-
    amigo(Personaje, OtroPersonaje).

cercanoA(Personaje, OtroPersonaje):-
    trabajaPara(Personaje, OtroPersonaje).

% ---- punto 5 ---------
masAtareado(Personaje):-
    encargo(_, Personaje, _),
    cantidadDeEncargos(Personaje, Cantidad),
    forall((cantidadDeEncargos(OtroPersonaje, OtraCantidad), Personaje \= OtroPersonaje), Cantidad >= OtraCantidad).

cantidadDeEncargos(Personaje, Cantidad):-
    findall(Encargo, encargo(_, Personaje, Encargo), Encargos),
    length(Encargos, Cantidad).

% ---- punto 6 ---------

personajesrespetables(Personajes):-
    findall(Personaje, esRespetable(Personaje), Personajes).

esRespetable(Personaje):-
    personaje(Personaje, Actividad),
    actividadRespetable(Actividad, Nivel),
    Nivel > 9.

    actividadRespetable(mafioso(resuelveProblemas), 10).
    actividadRespetable(mafioso(maton), 1).
    actividadRespetable(mafioso(capo), 20).
    actividadRespetable(actriz(Peliculas), Nivel):-
        length(Peliculas, Cantidad),
        Nivel is Cantidad / 10.

% ---- punto 7 --------

esPersonaje(Personaje) :-
    personaje(Personaje,_).

hartoDe(PersonajeHarto,Personaje) :-
	sonPersonajes(PersonajeHarto,Personaje),
	tieneAlgunaTarea(PersonajeHarto),
	forall(tareaDe(PersonajeHarto,Tarea),ayudaAPersonaje(Personaje,Tarea)).
	
sonPersonajes(PersonajeHarto,Persona) :-
	esPersonaje(PersonajeHarto),
	esPersonaje(Persona),
	PersonajeHarto \= Persona.

tieneAlgunaTarea(PersonajeHarto) :-
	encargo(_,PersonajeHarto,_).

tareaDe(PersonajeHarto,Tarea) :-
	esPersonaje(PersonajeHarto),
	encargo(_,PersonajeHarto,Tarea).

ayudaAPersonaje(Personaje,Tarea) :-
	aQuienAyuda(Tarea,Personaje).

ayudaAPersonaje(Personaje,Tarea) :-
	amigo(Personaje,Amigo),
	ayudaAPersonaje(Amigo,Tarea).
	
aQuienAyuda(cuidar(Cuidado),Cuidado).
aQuienAyuda(ayudar(Persona),Persona).
aQuienAyuda(buscar(Buscado,_),Buscado).

% ---- punto 8 --------
caracteristicas(vincent,  [negro, muchoPelo, tieneCabeza]).
caracteristicas(jules,    [tieneCabeza, muchoPelo]).
caracteristicas(marvin,   [negro]).

duoDiferenciable(Personaje,OtroPersonaje):-
    sonParejaoAmigo(Personaje, OtroPersonaje),
	caracteristicasDelPersonaje(Personaje,ListaDeCaracteristicas),
	caracteristicasDelPersonaje(OtroPersonaje,ListaDeCaracteristicasDelOtro),
	tieneUnaQueElOtroNo(ListaDeCaracteristicas,ListaDeCaracteristicasDelOtro),
	Personaje \= OtroPersonaje.
	
caracteristicasDelPersonaje(Personaje,ListaDeCaracteristicas) :-
	caracteristicas(Personaje,ListaDeCaracteristicas).
tieneUnaQueElOtroNo(ListaDeCaracteristicas,ListaDeCaracteristicasDelOtro) :-
	member(Caracteristica,ListaDeCaracteristicas),
	not(member(Caracteristica,ListaDeCaracteristicasDelOtro)).
    
    



    





