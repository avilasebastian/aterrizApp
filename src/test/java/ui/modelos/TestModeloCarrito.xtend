package ui.modelos

import org.junit.jupiter.api.Assertions
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.uqbar.commons.model.exceptions.UserException

class TestModeloCarrito extends DatosModelos {

	@BeforeEach
	override void init() {
		super.init()

		this.modeloLogin = new ModeloLogin
		this.loginUsuario

		this.modeloCarrito = new ModeloCarrito
	}

	@Test
	def void testTotalEnElCarrito1Item() {
		Assertions.assertEquals(3300.0, modeloCarrito.getTotalEnElCarrito, 1.0e-2)
	}

	@Test
	def void testTotalEnElCarrito2Items() {
		this.modeloCarrito.carrito.agregar(pasaje2)

		Assertions.assertEquals(6600.0, this.modeloCarrito.getTotalEnElCarrito, 1.0e-2)
	}

	@Test
	def void testTotalEnElCarrito1ItemsVuelo2() {
		this.modeloCarrito.carrito.agregar(pasaje3) /*3300*1+10000*1.15 */

		Assertions.assertEquals(14800.0, this.modeloCarrito.getTotalEnElCarrito, 1.0e-2)
	}

	@Test
	def void testDevolverVuelos() {
		this.modeloCarrito.pasajeSeleccionado = pasaje1
		this.modeloCarrito.eliminarUnPasajeDelCarrito()

		Assertions.assertFalse(carrito.lista.contains(pasaje1))
	}

//	@Test
//	def void testDevolverVuelos() {
//		Assertions.assertTrue(repoVuelo.lista.contains(vuelo1))
//		Assertions.assertFalse(vuelo1.asientos.contains(asiento1))
//
//		this.modeloCarrito.pasajeSeleccionado = pasaje1
//		this.modeloCarrito.eliminarUnPasajeDelCarrito()
//
//		Assertions.assertTrue(repoVuelo.lista.contains(vuelo1))
//		Assertions.assertTrue(vuelo1.asientos.contains(asiento1))
//	}

	@Test
	def void TestLongitudDelCarritoIgualA1() {
		Assertions.assertEquals(1, this.modeloCarrito.carrito.cantidadDeItems())
	}

	@Test
	def void TestLongitudDelCarritoIgualA2() {
		this.modeloCarrito.carrito.agregar(pasaje2)
		Assertions.assertEquals(2, this.modeloCarrito.carrito.cantidadDeItems())
	}

	@Test
	def void testEliminarUnpasaje() {
		this.modeloCarrito.carrito.agregar(pasaje2)
		this.modeloCarrito.pasajeSeleccionado = pasaje1
		this.modeloCarrito.eliminarUnPasajeDelCarrito()
		Assertions.assertEquals(1, this.modeloCarrito.carrito.cantidadDeItems())
	}

	@Test
	def void testLimpiarCarrito() {
		this.modeloCarrito.carrito.agregar(pasaje2)
		this.modeloCarrito.carrito.agregar(pasaje3)
		this.modeloCarrito.limpiarCarrito()
		Assertions.assertEquals(0, this.modeloCarrito.carrito.cantidadDeItems(), 0)
	}

	@Test
	def void testComprarElCarritoDebeQuedarVacio() {
		this.modeloCarrito.comprar()
		Assertions.assertEquals(0, this.modeloCarrito.carrito.cantidadDeItems(), 0)
	}

	@Test
	def void testComprarElUsuarioDebeTener1Reserva() {
		this.modeloCarrito.comprar()
		Assertions.assertEquals(1, usuario1.reservas.size(), 0)
	}

	@Test
	def void testComprarElUsuarioDebeTener3Reserva() {
		this.modeloCarrito.carrito.agregar(pasaje2)
		this.modeloCarrito.carrito.agregar(pasaje3)

		Assertions.assertThrows(UserException, [this.modeloCarrito.comprar()])
	// Saldo insuficiente
	}
}
