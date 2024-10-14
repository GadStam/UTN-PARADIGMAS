object pdpLibre{
    const productos = []
    const usuarios = #{} // Set
    method penalizarMorosos(){
        self.usuariosMorosos().forEach({unUsuario => unUsuario.penalizar()})
    }

    method usuariosMorosos(){
        return usuarios.filter({unUsuario => unUsuario.esMoroso()})
    }

    method eliminarCuponesUsados(){
        usuarios.forEach({unUsuario => unUsuario.eliminarCuponesUsados()})
    }
// forEach para efecto y map para solo obtener
    method nombresDeProductosDeOferta(){
        return productos.map({unProducto => unProducto.nombreEnOferta()})
    }

    method actualizarNivelDeUsuarios(){
        usuarios.forEach({unUsuario => unUsuario.actualizarNivel()})
    }

    


}