object pdepLibre{
    var usuarios =[]
    method reducirPuntosAMorosos(){
        self.reducirPuntosAUsuarios(self.usuariosMorosos())

    }

    method usuariosMorosos(){
        return usuarios.filter({unUsuario => unUsuario.esMoroso()})
    }

    method reducirPuntosAUsuarios(unosUsuarios){
        unosUsuarios.forEach({unUsuario => unUsuario.sumarPuntos(-1000)})
    }
}