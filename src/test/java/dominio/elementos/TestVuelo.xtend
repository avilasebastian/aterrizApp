package dominio.elementos

import java.time.LocalDateTime
import java.util.List
import org.junit.jupiter.api.Assertions
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test

class TestVuelo {
	var List<Asiento> asientos = newArrayList
	var List<VueloSimple> vuelosSimples = newArrayList
	var VueloConEscala vueloConEscala

	@BeforeEach
	def void init() {
		asientos.add(new Asiento() => [clase = "Economica"; ventanilla = false])
		asientos.add(new Asiento() => [clase = "Ejecutiva"; ventanilla = false])
		asientos.add(new Asiento() => [clase = "Economica"; ventanilla = true])
		asientos.add(new Asiento() => [clase = "Ejecutiva"; ventanilla = true])
		asientos.add(new Asiento() => [clase = "Primera"; ventanilla = true])

		(0 .. 5).forEach [ i |
			vuelosSimples.add(new VueloSimple() => [
				ciudadOrigen = "ciudad_" + i
				ciudadDestino = "ciudad_" + (i + 1)
				aerolinea = "Aerolineas Pepita"
				avion = "Boing 555"
				horasDeVuelo = i + 1
				partida = LocalDateTime.of(2020, 02, (21 + i), 10, 0, 0)
				precio = 1000.0 + 10 * i
			])
		]

		vuelosSimples.get(0).agregar(asientos.get(0))

		vueloConEscala = new VueloConEscala() => [aerolinea = "Aerolineas Pepita"]
		(0 .. 3).forEach[i|vueloConEscala.agregarEscala(vuelosSimples.get(i))]
	}

	@Test
	def void test_ciudadOrigen() {
		Assertions.assertEquals("ciudad_0", vueloConEscala.ciudadOrigen)
	}

	@Test
	def void test_ciudadDestino() {
		Assertions.assertEquals("ciudad_4", vueloConEscala.ciudadDestino)
	}

	@Test
	def void test_avion() {
		Assertions.assertEquals("Boing 555", vueloConEscala.avion)
	}

	@Test
	def void test_horasDeVuelo() {
		Assertions.assertEquals(76, vueloConEscala.horasDeVuelo)
	}

	@Test
	def void test_precioBase() {
		Assertions.assertEquals(3654.0, vueloConEscala.precio, 1e-2)
	}

	@Test
	def void test_comprobarQueElVueloNoEstaVendido() {
		(0 .. 2).forEach[i|vuelosSimples.get(1).agregar(new Asiento())]

		Assertions.assertFalse(vuelosSimples.get(1).estaVendido())
	}

	@Test
	def void test_comprobarQueElVueloEstaVendido() {
		Assertions.assertTrue(vuelosSimples.get(1).estaVendido())
	}

	@Test
	def void test_listaDeAsientosEconomicosConVentanillaParaElVuelo_0() {
		var List<Asiento> calculado
		var List<Asiento> referencia

		(2 .. 4).forEach[i|vuelosSimples.get(1).agregar(asientos.get(i))]

		calculado = vuelosSimples.get(1).asientosDeClaseYTipo("Economica", true)
		referencia = #[asientos.get(2)]

		Assertions.assertEquals(referencia, calculado)
	}
}