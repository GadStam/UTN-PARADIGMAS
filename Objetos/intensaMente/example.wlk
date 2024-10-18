import emociones.*

class Persona{
  var nivelFelicidad = 1000
  var emocionDominante

  var recuerdosDelDia = #{}
  var recuerdoCentral

  method vivirEvento(unRecuerdo){
		recuerdosDelDia.add(unRecuerdo)
  }

  method asentarEvento(unRecuerdo){
    unRecuerdo.asentar(self)
  }

  method cambiarEmocionDominate(nuevaEmocion){
    emocionDominante = nuevaEmocion
  }

  method setRecuerdoCentral(unRecuerdo){
    recuerdoCentral = recuerdosDelDia[0]
  }

}

class Recuerdo{
  var emocionDominante
  var descricpcion
  var fecha

  method asentar(persona){
    if (emocionDominante == alegria && persona.nivelFelicidad > 500){
      persona.
    }

  }
}