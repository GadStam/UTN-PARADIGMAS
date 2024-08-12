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
encargo(marsellus, vincent, ayudar(jules)).
encargo(marsellus, jules, buscar(jules, fuerteApache)).




%--------------1-------------------------------
esPeligroso(Personaje):-
    personaje(Personaje, Ocupacion),
    ocupacionPeligrosa(Ocupacion).

esPeligroso(Personaje):-
    trabajaPara(Personaje, Empleado),
    esPeligroso(Empleado).

ocupacionPeligrosa(mafioso(maton)).

ocupacionPeligrosa(ladron(Robos)):-
    member(licorerias, Robos).

%--------------2-------------------------------
duoTemible(Personaje, OtroPersonaje):-
    sonAmigosOPareja(Personaje, OtroPersonaje),
    esPeligroso(Personaje),
    esPeligroso(OtroPersonaje).

sonAmigosOPareja(Personaje, OtroPersonaje):-
    amigo(Personaje, OtroPersonaje).

sonAmigosOPareja(Personaje, OtroPersonaje):-
    pareja(Personaje, OtroPersonaje).

%--------------3-------------------------------
estaEnProblemas(Personaje):-
    trabajaPara(Jefe, Personaje),
    esPeligroso(Jefe),
    tieneQueCuidarEsposa(Jefe, Personaje).

estaEnProblemas(Personaje):-
    encargo(_, Personaje, buscar(OtroPersonaje, _)),
    esBoxeador(OtroPersonaje).

estaEnProblemas(butch).

esBoxeador(Personaje):-
    personaje(Personaje, boxeador).

tieneQueCuidarEsposa(Jefe, Empleado):-
    pareja(Jefe, Esposa),
    encargo(Jefe, Empleado, cuidar(Esposa)).

%--------------4-------------------------------
sanCayetano(Personaje):-
    esPersonaje(Personaje),
    esCercano(Personaje, _),
    forall(esCercano(Personaje,OtroPersonaje),encargo(Personaje,OtroPersonaje,_)).

esCercano(Personaje, OtroPersonaje):-
    amigo(Personaje, OtroPersonaje).

esCercano(Personaje, OtroPersonaje):-
    trabajaPara(Personaje, OtroPersonaje).

%--------------5-------------------------------
masAtareado(Personaje):-
    esPersonaje(Personaje),
    forall(personaje(OtroPersonaje,_), tieneMasEncargos(Personaje, OtroPersonaje)).

esPersonaje(Personaje):-
    personaje(Personaje, _).

cantidadDeEncargos(Personaje, Cantidad):-
    findall(Encargado, encargo(_, Personaje, Encargado), Encargos),
    length(Encargos, Cantidad).

tieneMasEncargos(Personaje, OtroPersonaje):-
    cantidadDeEncargos(Personaje, Cantidad),
    cantidadDeEncargos(OtroPersonaje, OtraCantidad),
    Cantidad >= OtraCantidad.

%--------------6-------------------------------
personajesRespetables(Personajes):-
    findall(Personaje, esRespetable(Personaje), Personajes).

esRespetable(Personaje):-
    personaje(Personaje, Ocupacion),
    ocupacionRespetable(Ocupacion, NivelDeRespeto),
    NivelDeRespeto > 9.

ocupacionRespetable(actriz(Peliculas), NivelDeRespeto):-
    length(Peliculas, Cantidad),
    NivelDeRespeto is Cantidad / 10.

ocupacionRespetable(mafioso(resuelveProblemas), 10).
ocupacionRespetable(mafioso(maton), 1).
ocupacionRespetable(mafioso(capo), 20).

%--------------7-------------------------------
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

%--------------8-------------------------------

caracteristicas(vincent,  [negro, muchoPelo, tieneCabeza]).
caracteristicas(jules,    [tieneCabeza, muchoPelo]).
caracteristicas(marvin,   [negro]).

duoDiferenciable(Personaje,OtroPersonaje) :-
	caracteristicasDelPersonaje(Personaje,ListaDeCaracteristicas),
	caracteristicasDelPersonaje(OtroPersonaje,ListaDeCaracteristicasDelOtro),
	tieneUnaQueElOtroNo(ListaDeCaracteristicas,ListaDeCaracteristicasDelOtro),
	Personaje \= OtroPersonaje.
	
caracteristicasDelPersonaje(Personaje,ListaDeCaracteristicas) :-
	caracteristicas(Personaje,ListaDeCaracteristicas).

tieneUnaQueElOtroNo(ListaDeCaracteristicas,ListaDeCaracteristicasDelOtro) :-
	member(Caracteristica,ListaDeCaracteristicas),
	not(member(Caracteristica,ListaDeCaracteristicasDelOtro)).




