package ui.modelos

import org.junit.jupiter.api.Assertions
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test

class TestModeloVuelo extends DatosModelos {

	@BeforeEach
	override void init() {
		super.init()

		this.modeloLogin = new ModeloLogin
		this.loginUsuario

		this.modeloVuelo = new ModeloVuelo
		this.modeloVuelo.datosDeBusqueda = dato
	}

	@Test
	def void testCantidadDeItems() {
		Assertions.assertEquals(1, this.modeloVuelo.cantidadDeItems)
	}

	@Test
	def void testGetListaDeAsientosVuelo1() {
		this.modeloVuelo.vueloSeleccionado = vuelo1
		Assertions.assertEquals(2, this.modeloVuelo.getListaDeAsientos.size)
	}

	@Test
	def void testGetListaDeAsientosVuelo2() {
		this.modeloVuelo.vueloSeleccionado = vuelo2
		Assertions.assertEquals(1, this.modeloVuelo.getListaDeAsientos.size)
	}

	@Test
	def void testGetListaDeVuelos() {
		Assertions.assertEquals(2, this.modeloVuelo.getListaDeVuelos.size)
	}

	@Test
	def void testAgregarAlCarrito() {
		this.modeloVuelo.vueloSeleccionado = vuelo1
		this.modeloVuelo.asientoSeleccionado = asiento2
		this.modeloVuelo.agregarAlCarrito()
		Assertions.assertEquals(2, this.modeloVuelo.carrito.cantidadDeItems)
	}

	@Test
	def void testAgregarAlCarritoLeQuitoUnAsientoAVuelo1() {
		this.modeloVuelo.vueloSeleccionado = vuelo1
		this.modeloVuelo.asientoSeleccionado = asiento2
		this.modeloVuelo.agregarAlCarrito()
		Assertions.assertEquals(3, vuelo1.asientos.size)
		Assertions.assertEquals(2, carrito.lista.size)
	}
}
