package ui.modelos

import dominio.elementos.Usuario
import org.junit.jupiter.api.Assertions
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.uqbar.commons.applicationContext.ApplicationContext

class TestModeloLogin extends DatosModelos {

	@BeforeEach
	override void init() {
		super.init()

		this.modeloLogin = new ModeloLogin
		this.loginUsuario
	}

	@Test
	def void testLoginDeUsuario() {
		Assertions.assertEquals(usuario1, ApplicationContext.instance.getSingleton(Usuario))
	}
}
