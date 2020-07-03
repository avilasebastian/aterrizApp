package ui.modelos

import dominio.elementos.Asiento
import dominio.elementos.DatosDeBusqueda
import dominio.elementos.Pasaje
import dominio.elementos.Usuario
import dominio.elementos.Vuelo
import dominio.repositorios.Carrito
import dominio.repositorios.Historial
import dominio.repositorios.RepoVuelos
import java.time.LocalDateTime
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable

import static extension org.uqbar.commons.model.utils.ObservableUtils.firePropertyChanged

@Accessors @Observable
class ModeloVuelo {
	var Historial historial
	var RepoVuelos repoVuelos
	var Carrito carrito

	var List<String> listaDeClases = newArrayList

	var Asiento asientoSeleccionado
	var DatosDeBusqueda datosDeBusqueda
	var Usuario usuario
	var Vuelo vueloSeleccionado
	
	new() {
		historial = ApplicationContext.instance.getSingleton(Historial)
		repoVuelos = ApplicationContext.instance.getSingleton(RepoVuelos)
		carrito = ApplicationContext.instance.getSingleton(Carrito)
		usuario = ApplicationContext.instance.getSingleton(Usuario)

		listaDeClases = ApplicationContext.instance.getSingleton("Lista")

		datosDeBusqueda = new DatosDeBusqueda(usuario.id_HDB)
		datosDeBusqueda.ventanilla = null

		this.actualizarTablas()
		this.actualizarCampoCarrito()
	}

	def List<Vuelo> getListaDeVuelos() {
		var List<Vuelo> listaDeVuelos = newArrayList

		listaDeVuelos = repoVuelos.buscarPor(datosDeBusqueda)
		vueloSeleccionado = listaDeVuelos.head

		return listaDeVuelos
	}

	def notificacion(SimpleWindow<?> window) {
		if (listaDeVuelos.isEmpty) {
			if (datosDeBusqueda.ventanilla === null) {
				window.showInfo("vuelos agotados")
			} else {
				window.showInfo("No hay resultado para esta busqueda")
			}
		}
	}

	@Dependencies("vueloSeleccionado")
	def List<Asiento> getListaDeAsientos() {
		var List<Asiento> listaDeAsientos = newArrayList

		if (vueloSeleccionado !== null) {
			listaDeAsientos = vueloSeleccionado.asientosDeClaseYTipo(
				datosDeBusqueda.clase,
				datosDeBusqueda.ventanilla
			)
		}

		asientoSeleccionado = listaDeAsientos.head
		return listaDeAsientos
	}

	def Integer getCantidadDeItems() {
		carrito.cantidadDeItems()
	}

	def Double getTotalEnElCarrito() {
		carrito.totalEnElCarrito()
	}

	def void buscar() {
		if (datosDeBusqueda.ventanilla === null)
			datosDeBusqueda.ventanilla = false
		this.historial.save(datosDeBusqueda.copia)
		this.actualizarTablas()
	}

	def void limpiarCampos() {
		this.datosDeBusqueda.limpiarCampos()
		this.datosDeBusqueda.ventanilla = null
		this.actualizarTablas()
	}

	def void agregarAlCarrito() {
		var Pasaje pasaje = new Pasaje(
			vueloSeleccionado,
			asientoSeleccionado,
			LocalDateTime.now 
		)
		this.carrito.agregar(pasaje)

		this.actualizarTablas()
		this.actualizarCampoCarrito()
	}

	def void actualizarTablas() {
		this.firePropertyChanged("listaDeVuelos")
		this.firePropertyChanged("listaDeAsientos")
	}

	def void actualizarCampoCarrito() {
		this.firePropertyChanged("cantidadDeItems")
		this.firePropertyChanged("totalEnElCarrito")
	}
}
