package extensiones

import java.time.LocalDateTime
import org.junit.jupiter.api.Assertions
import org.junit.jupiter.api.Test
import org.uqbar.commons.model.exceptions.UserException

class TestLocalDateTimeTransformer {
	var LocalDateTimeTransformer referencia = new LocalDateTimeTransformer(LocalDateTime.now)

	@Test
	def void test_leerfecha() {
		var LocalDateTime fecha = referencia.viewToModel("28/07/1983")

		Assertions.assertEquals(LocalDateTime.of(1983, 07, 28, 0, 0), fecha)
	}

	@Test
	def void test_escribirFecha() {
		var String fecha = referencia.modelToView(LocalDateTime.of(1983, 07, 28, 3, 30))

		Assertions.assertEquals("28/07/1983 - 03:30", fecha)
	}

	@Test
	def void test_leerFechaConError() {
		Assertions.assertThrows(UserException, [referencia.viewToModel("calabaza")], "321")
	}
}
