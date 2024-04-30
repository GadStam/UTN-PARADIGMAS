--Se tiene información detallada de la duración en minutos de las llamadas que se llevaron a cabo en un período determinado, discriminadas en horario normal y horario reducido. 
--duracionLlamadas = (("horarioReducido",[20,10,25,15]),(“horarioNormal”,[10,5,8,2,9,10])). 
--Definir la función cuandoHabloMasMinutos, devuelve en que horario se habló más cantidad de minutos, en el de tarifa normal o en el reducido. 
--Main> cuandoHabloMasMinutos 
--horarioReducido” 

type Horas = [Int]
type Horario = String
type DuracionLlamadas = ((Horario, Horas),(Horario, Horas))

duracionLlamadas:: DuracionLlamadas
duracionLlamadas = (("horarioReducido",[20,10,25,15]),("horarioNormal",[10,5,8,2,9,10]))

cuandoHabloMasMinutos:: DuracionLlamadas -> Int
cuandoHabloMasMinutos duracion = 

