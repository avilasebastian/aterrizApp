package dominio.elementos

import org.junit.jupiter.api.Assertions
import org.junit.jupiter.api.Test

class TestAsiento {
	var Asiento asiento1E = new Asiento => [clase = "Economica" ventanilla = true]

	@Test
	def void testEsDeClaseYTipo1() {
		Assertions.assertTrue(asiento1E.esDeClaseYTipo("Economica", true))
	}

	@Test
	def void testEsDeClaseYTipo2() {
		Assertions.assertFalse(asiento1E.esDeClaseYTipo("Economica", false))
	}

	@Test
	def void testEsDeClaseYTipo3() {
		Assertions.assertFalse(asiento1E.esDeClaseYTipo("", false))
	}

	@Test
	def void testEsDeClaseYTipo4() {
		Assertions.assertTrue(asiento1E.esDeClaseYTipo("", true))
	}
}