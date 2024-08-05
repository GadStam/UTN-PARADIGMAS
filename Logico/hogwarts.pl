/*Tenemos que registrar en nuestra base de conocimientos qué características tienen los distintos magos que ingresaron a Hogwarts, el status de sangre que tiene cada mago y en qué casa odiaría quedar. Actualmente sabemos que:

Harry es sangre mestiza, y se caracteriza por ser corajudo, amistoso, orgulloso e inteligente. Odiaría que el sombrero lo mande a Slytherin.
Draco es sangre pura, y se caracteriza por ser inteligente y orgulloso, pero no es corajudo ni amistoso. Odiaría que el sombrero lo mande a Hufflepuff.
Hermione es sangre impura, y se caracteriza por ser inteligente, orgullosa y responsable. No hay ninguna casa a la que odiaría ir*/

sangre(harry, mestiza).
caracter(harry, corajudo).
caracter(harry, amistoso).
caracter(harry, orgulloso).
caracter(harry, inteligente).
odiariaIrA(harry, slytherin).

sangre(draco, pura).
caracter(draco, inteligente).
caracter(draco, orgulloso).
odiariaIrA(draco, hufflepuff).

sangre(hermione, impura).
caracter(hermione, inteligente).
caracter(hermione, orgulloso).
caracter(hermione, responsable).

casa(gryffindor, [corajudo]).
casa(slytherin, [orgulloso, inteligente]).
casa(ravenclaw, [inteligente, responsable]).
casa(hufflepuff, [amistoso]).

/*Saber si una casa permite entrar a un mago, lo cual se cumple para cualquier mago y cualquier casa excepto en el caso de Slytherin, que no permite entrar a magos de sangre impura.*/

permiteEntrar(slytherin, Mago):-
    sangre(Mago, Sangre),
    Sangre \= impura.

permiteEntrar(Casa, _):-
    casa(Casa, _),
    Casa \= slytherin.


/*Saber si un mago tiene el carácter apropiado para una casa, lo cual se cumple para cualquier mago si sus características incluyen todo lo que se busca para los integrantes de esa casa, independientemente de si la casa le permite la entrada.*/
caracterApropiado(Casa, Mago):-
    casa(Casa, Caracteristicas),
    forall(member(Caracteristica, Caracteristicas), caracter(Mago, Caracteristica)).

seleccion(gryffindor, hermione).

seleccion(Casa, Mago):-
    permiteEntrar(Casa, Mago),
    caracterApropiado(Casa, Mago),
    not(odiariaIrA(Mago, Casa)).

    /*cadenaDeAmistades(Magos):-
        forall(member(Mago, Magos), esAmistoso(Mago)),
        forall(member(Mago, Magos), member(OtroMago, Magos), mismaCasa(Mago, OtroMago)).*/

esAmistoso(Mago):-
    caracter(Mago, amistoso).

mismaCasa(Mago, OtroMago):-
    seleccion(Casa, Mago),
    seleccion(Casa, OtroMago),
    Mago \= OtroMago.
        


    
