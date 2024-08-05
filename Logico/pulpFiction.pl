personaje(pumkin, ladron([licorerias, estacionesDeServicio])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent, mafioso(maton)).
personaje(jules, mafioso(maton)).
personaje(marsellus, mafioso(capo)).
personaje(marsellus, mafioso(maton)).
personaje(winston, mafioso(resuelveProblemas)).
personaje(mia, actriz([foxForceFive])).
personaje(butch, boxeador).

pareja(marsellus, mia).
pareja(pumkin, honeyBunny).

%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).

%encargo(Solicitante, Encargado, Tarea). 
%las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)


/* -------------------- punto 1 ----------------------- */

esPeligroso(Personaje) :-
    personaje(Personaje, Actividad),
    actividadPeligrosa(Actividad),
    tieneEmpleadoPeligroso(Personaje).

actividadPeligrosa(mafioso(maton)).
actividadPeligrosa(ladron(Lugares)) :-
    member(licorerias, Lugares).

tieneEmpleadoPeligroso(Personaje) :-
    trabajaPara(Personaje, Empleado),
    personaje(Empleado, ActividadEmpleado),
    actividadPeligrosa(ActividadEmpleado).

/* -------------------- punto 2 ----------------------- */

duoTemible(Personaje, OtroPersonaje) :-
    sonAmigosOPareja(Personaje, OtroPersonaje),
    esPeligroso(Personaje),
    esPeligroso(OtroPersonaje).

sonAmigosOPareja(Personaje, OtroPersonaje) :-
    amigo(Personaje, OtroPersonaje),
    amigo(OtroPersonaje, Personaje).

sonAmigosOPareja(Personaje, OtroPersonaje) :-
    pareja(Personaje, OtroPersonaje),
    pareja(OtroPersonaje, Personaje).

/* -------------------- punto 3 ----------------------- */

%encargo(Solicitante, Encargado, Tarea). 
%las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent, cuidar(mia)).
encargo(vincent, elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).

estaEnproblemas(butch).

estaEnproblemas(Personaje):-
    esJefePeligroso(Personaje, Jefe),
    tieneQueCuidarEsposa(Personaje, Jefe).

estaEnproblemas(Personaje):-
    encargo(_, Personaje, buscar(Buscado, _)),
    personaje(Buscado, boxeador).
    

esJefePeligroso(Personaje, Jefe):-
    trabajaPara(Jefe, Personaje),
    esPeligroso(Jefe).

tieneQueCuidarEsposa(Personaje, Jefe):-
    pareja(Jefe, Esposa),
    encargo(Jefe, Personaje, cuidar(Esposa)).

/* -------------------- punto 4 ----------------------- */
sanCayetano(Personaje):-
    encargo(Personaje, _, _),
    forall(encargo(Personaje, Empleado, _), esAmigoOEmpleado(Personaje, Empleado)).

/* Pregunta para entender */
/*se hace asi*/
esAmigoOEmpleado(Personaje, OtroPersonaje):-
    amigo(Personaje, OtroPersonaje).

esAmigoOEmpleado(Personaje, OtroPersonaje):-
    trabajaPara(Personaje, OtroPersonaje).
/* o asi */

/*----- | --------- | --------------------*/

/* -------------------- punto 5 ----------------------- */
masAtareado(Personaje):-
    encargo(_, Personaje, _),
    cantidadDeEncargos(Personaje, Cantidad),
    forall((cantidadDeEncargos(OtroPersonaje, OtraCantidad), Personaje \= OtroPersonaje), Cantidad > OtraCantidad).


cantidadDeEncargos(Personaje, Cantidad):-
    findall(Encargo, encargo(_, Personaje, Encargo), Encargos),
    length(Encargos, Cantidad).

/* -------------------- punto 6 ----------------------- */
nivelDeRespeto(Personaje, Nivel):-
    personaje(Personaje, Actividad),
    nivelDeRespetoDeActividad(Actividad, Nivel).

nivelDeRespetoDeActividad(mafioso(capo), 20).
nivelDeRespetoDeActividad(mafioso(resuelveProblemas), 10).
nivelDeRespetoDeActividad(mafioso(maton), 1).

nivelDeRespetoDeActividad(actriz(Peliculas), Nivel):-
    length(Peliculas, Cantidad),
    Nivel is Cantidad / 10.

/* -------------------- punto 7 ----------------------- */
hartoDe(Personaje, OtroPersonaje):-
    personaje(Personaje, _),
    personaje(OtroPersonaje, _),
    Personaje \= OtroPersonaje,
    interactuaOesAmigo(Personaje, OtroPersonaje).

interactuaOesAmigo(Personaje, OtroPersonaje):-
    forall(encargo(Personaje, OtroPersonaje, _), true).

interactuaOesAmigo(Personaje, OtroPersonaje):-
    amigo(Personaje, OtroPersonaje).

/* -------------------- punto 8 ----------------------- */
caracteristicas(vincent, [negro, muchoPelo, tieneCabeza]).
caracteristicas(jules, [tieneCabeza, muchoPelo]).
caracteristicas(marvin, [negro]).

duoDiferenciable(Personaje, OtroPersonaje):-
    sonAmigosOPareja(Personaje, OtroPersonaje),
    caracteristicas(Personaje, ListaCaracteristicasPersonaje),
    caracteristicas(OtroPersonaje, ListaCaracteristicasOtroPersonaje).

    

 









    





