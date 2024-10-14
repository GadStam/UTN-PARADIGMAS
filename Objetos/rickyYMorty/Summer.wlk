import Rick.*
import Beth.*
class Summer inherits Beth{

    override method irseDeAventurasCon(unRick){
        if(self.esLunes()){
            super(unRick)
        }else{
            throw new Exception(message = "No es lunes, no se puede ir de aventuras")
        } 
    }

    method esLunes(){
        return new Date().dayOfWeek() == "monday"
    }

   
}