package ui.modelos

import dominio.elementos.Usuario
import dominio.repositorios.RepoUsuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException
import dominio.repositorios.Carrito

@Accessors @Observable
class ModeloLogin {
	var RepoUsuario repo

	var String nombre = "Bonifacio"
	var String clave = "12345"

	new() {
		repo = ApplicationContext.instance.getSingleton(RepoUsuario)
	}

	def void loginDeUsuario() {
		this.validacionDeCampos()
		this.buscarUsuario()
	}

	private def validacionDeCampos() {
		if (nombre.equals("")) {
			throw new UserException("Debe ingresar su nombre de usuario")
		}
		if (clave.equals("")) {
			throw new UserException("Debe ingresar su contrase\u00f1a")
		}
	}

	private def void buscarUsuario() {
		var Usuario usuario = repo.buscarPor(nombre, clave)
		ApplicationContext.instance.configureSingleton(Usuario, usuario)
		ApplicationContext.instance.configureSingleton(Carrito,new Carrito(usuario))
	}

	def String getPathImagen() {
		"imagenes/logo.png"
	}
}
