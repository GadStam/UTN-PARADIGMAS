%comio(Personaje, Bicho)
comio(pumba, vaquitaSanAntonio(gervasia,3)).
comio(pumba, hormiga(federica)).
comio(pumba, hormiga(tuNoEresLaReina)).
comio(pumba, cucaracha(ginger,15,6)).
comio(pumba, cucaracha(erikElRojo,25,70)).
comio(timon, vaquitaSanAntonio(romualda,4)).
comio(timon, cucaracha(gimeno,12,8)).
comio(timon, cucaracha(cucurucha,12,5)).
comio(simba, vaquitaSanAntonio(remeditos,4)).
comio(simba, hormiga(schwartzenegger)).
comio(simba, hormiga(niato)).
comio(simba, hormiga(lula)).
pesoHormiga(2).
%peso(Personaje, Peso)
peso(pumba, 100).
peso(timon, 50).
peso(simba, 200).

%----1A-----------------
esJugosita(Cucaracha) :-
    comio(_, cucaracha(Cucaracha, _, _)),
    forall(comio(_, cucaracha(OtraCucaracha, _, _)), masGordita(Cucaracha, OtraCucaracha)).

masGordita(Cucaracha, OtraCucaracha) :-
    pesoCucaracha(Cucaracha, Peso),
    pesoCucaracha(OtraCucaracha, OtraPeso),
    Peso >= OtraPeso.

pesoCucaracha(Cucaracha, Peso):-
    comio(_, cucaracha(Cucaracha, _, Peso)).


/*masAtareado(Personaje) :-
	esPersonaje(Personaje),
	forall(personaje(Persona,_),tieneMasTareas(Personaje,Persona)).

tieneMasTareas(Personaje,Persona) :-
	cantidadDeTareasDe(Personaje,CantidadDeTareas),
	cantidadDeTareasDe(Persona,CantidadDeTareasPersona),
	CantidadDeTareas >= CantidadDeTareasPersona.

cantidadDeTareasDe(Personaje, CantidadDeTareas) :-
	findall(Tarea, tieneTarea(Personaje,Tarea),Tareas),
	length(Tareas,CantidadDeTareas).

tieneTarea(Personaje,Tarea) :-
	encargo(_,Personaje,Tarea).*/