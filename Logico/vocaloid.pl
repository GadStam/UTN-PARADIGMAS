vocaloid(megurineLuka, cancion(nightFever, 4)).
vocaloid(megurineLuka, cancion(foreverYoung, 5)).
vocaloid(hatsuneMiku, cancion(tellYourWorld, 4)).
vocaloid(gumi, cancion(foreverYoung, 4)).
vocaloid(gumi, cancion(tellYourWorld, 5)).
vocaloid(seeU, cancion(novemberRain, 6)).
vocaloid(seeU, cancion(nightFever, 5)).

% ----------------- Punto 1 -----------------

novedoso(Cantante) :- 
    sabeAlMenosDosCanciones(Cantante),
    tiempoTotalCanciones(Cantante, Tiempo),
    Tiempo < 15.
    
sabeAlMenosDosCanciones(Cantante) :-
    vocaloid(Cantante, UnaCancion),
    vocaloid(Cantante, OtraCancion),
    UnaCancion \= OtraCancion.
    
tiempoTotalCanciones(Cantante, TiempoTotal) :-
    findall(TiempoCancion, tiempoDeCancion(Cantante, TiempoCancion), Tiempos), 
    sumlist(Tiempos,TiempoTotal).
    
tiempoDeCancion(Cantante,TiempoCancion):-  
    vocaloid(Cantante,Cancion),
    tiempo(Cancion,TiempoCancion).
    
tiempo(cancion(_, Tiempo), Tiempo).
    

% ----------------- Punto 2 -----------------
esAcelerado(Cantante) :-
    vocaloid(Cantante, _),
    tiempoTotalCanciones(Cantante, TiempoTotal),
    TiempoTotal =< 4.

% ----------------- Punto 3 -----------------

concierto(mikuExpo, estadosUnidos, 2000, gigante(2, 6)).
concierto(magicalMirai, japon, 3000, gigante(3, 10)).
concierto(vocalektVisions, estadosUnidos, 1000, mediano(9)).
concierto(mikuFest, argentina, 100, pequenio(4)).

% ----------------- Punto 4 -----------------
puedeParticiparEn(hatsuneMiku, Concierto):-
    concierto(Concierto, _, _, _).

puedeParticiparEn(Cantante, Concierto):-
    vocaloid(Cantante, _),
    Cantante \= hatsuneMiku,
    concierto(Concierto, _, _, TipoConcierto),
    cumpleRequisitos(Cantante, TipoConcierto).

cumpleRequisitos(Cantante, gigante(CantidadCanciones, Duracion)):-
    tiempoTotalCanciones(Cantante, DuracionTotal),
    cantidadCanciones(Cantante, CantidadCancionesArtista),
    CantidadCancionesArtista >= CantidadCanciones,
    DuracionTotal > Duracion.

cantidadCanciones(Cantante, CantidadCancionesArtista):-
    findall(Cancion, vocaloid(Cantante, Cancion), Canciones),
    length(Canciones, CantidadCancionesArtista).

cumpleRequisitos(Cantante, mediano(Duracion)):-
    tiempoTotalCanciones(Cantante, DuracionTotal),
    DuracionTotal < Duracion.

cumpleRequisitos(Cantante, pequenio(DuracionEspecifica)):-
    findall(TiempoCancion, tiempoDeCancion(Cantante, TiempoCancion), Tiempos), 
    member(DuracionEspecifica, Tiempos).

% ----------------- Punto 5 -----------------
masFamoso(Cantante) :-
    esVocaloid(Cantante),
    forall(vocaloid(OtroCantante, _), tieneMasFama(Cantante, OtroCantante)).

esVocaloid(Cantante) :-
    vocaloid(Cantante, _).

nivelFamoso(Cantante, Nivel) :-
    famaTotal(Cantante, FamaTotal),
    cantidadCanciones(Cantante, Cantidad),
    Nivel is FamaTotal * Cantidad.

famaTotal(Cantante, FamaTotal) :-
    findall(Fama, famaConcierto(Cantante, Fama), CantidadesFama),
    sumlist(CantidadesFama, FamaTotal).

famaConcierto(Cantante, Fama) :-
    puedeParticiparEn(Cantante, Concierto),
    fama(Concierto, Fama).

fama(Concierto, Fama) :-
    concierto(Concierto, _, Fama, _).

tieneMasFama(Cantante, OtroCantante) :-
    nivelFamoso(Cantante, Nivel),
    nivelFamoso(OtroCantante, OtroNivel),
    Nivel >= OtroNivel.

% ----------------- Punto 6 -----------------
conoceA(megurineLuka, hatsuneMiku).
conoceA(megurineLuka, gumi).
conoceA(gumi, seeU).
conoceA(seeU, kaito).

unicoParticipanteEntreConocidos(Cantante,Concierto):- 
    puedeParticiparEn(Cantante, Concierto),
	not((conocido(Cantante, OtroCantante), 
    puedeParticiparEn(OtroCantante, Concierto))).


conocido(Cantante, OtroCantante) :- 
conoceA(Cantante, OtroCantante).


conocido(Cantante, OtroCantante) :- 
conoceA(Cantante, UnCantante), 
conocido(UnCantante, OtroCantante).




    


