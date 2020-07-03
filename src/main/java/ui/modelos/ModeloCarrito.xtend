package ui.modelos

import dominio.elementos.Pasaje
import dominio.elementos.Usuario
import dominio.repositorios.Carrito
import dominio.repositorios.RepoVuelos
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable

import static extension org.uqbar.commons.model.utils.ObservableUtils.firePropertyChanged
import dominio.repositorios.RepoUsuario

@Accessors @Observable
class ModeloCarrito {
	var Usuario usuario
	var Carrito carrito
	var RepoVuelos repoVuelos
	var RepoUsuario repoUsuario
	var Pasaje pasajeSeleccionado

	new() {
		this.usuario = ApplicationContext.instance.getSingleton(Usuario)
		this.carrito = ApplicationContext.instance.getSingleton(Carrito)
		this.repoVuelos = ApplicationContext.instance.getSingleton(RepoVuelos)
		this.repoUsuario = ApplicationContext.instance.getSingleton(RepoUsuario)
	}

	@Dependencies("carrito")
	def Double getTotalEnElCarrito() {
		carrito.totalEnElCarrito()
	}

	def void comprar() {
		usuario.validarSaldo(carrito.totalEnElCarrito)
		carrito.asientoCompra( repoVuelos, repoUsuario)
		this.firePropertyChanged("carrito")
	}

	def eliminarUnPasajeDelCarrito() {
		carrito.quitar(pasajeSeleccionado)
		pasajeSeleccionado = carrito.lista.head

		this.firePropertyChanged("carrito")
	}

	def void limpiarCarrito() {
		carrito.limpiar()
		this.firePropertyChanged("carrito")
	}
	
	@Dependencies("carrito")
	def getListaCarrito(){
		carrito.lista
	}
}
