package dominio.elementos

import java.util.List
import org.junit.jupiter.api.Assertions
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test

class TestUsuario {
	var List<Usuario> usuarios = newArrayList

	@BeforeEach
	def void init() {
		(0 .. 1).forEach [ i |
			usuarios.add(new Usuario => [
				nombre = "usuario_" + i
				apellido = "Usuario_" + i
				edad = 99 + i
				usuarioNombre = "usuarioNombre_" + i
				clave = "XYZ_" + i
			])
		]
	}

	@Test
	def void test_agregarseASiMismoComoAmigo() {
		usuarios.get(0).agregarAmigo(usuarios.get(0))
		Assertions.assertEquals(#{}, usuarios.get(0).amigos)
	}

	@Test
	def void test_agregarAUnAmigo() {
		usuarios.get(0).agregarAmigo(usuarios.get(1))
		Assertions.assertEquals(#{usuarios.get(1)}, usuarios.get(0).amigos)
	}
}