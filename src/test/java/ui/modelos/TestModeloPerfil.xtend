package ui.modelos

import org.junit.jupiter.api.Test
import org.junit.jupiter.api.Assertions
import org.junit.jupiter.api.BeforeEach

class TestModeloPerfil extends DatosModelos {

	@BeforeEach
	override void init() {
		super.init()

		this.modeloLogin = new ModeloLogin
		this.loginUsuario

		this.modeloPerfil = new ModeloPerfil
	}

	@Test
	def void testSaldoActual() {
		Assertions.assertEquals(15000.0, usuario1.saldo, 1.0e-2)
	}

	@Test
	def void testAgregarSaldo() {
		this.modeloPerfil.saldoAgregado = 10000.0
		this.modeloPerfil.agregarSaldo()
		Assertions.assertEquals(25000.0, usuario1.saldo, 1.0e-2)
	}

	@Test
	def void testListaDeUsuarios() {
		Assertions.assertEquals(2, this.modeloPerfil.listaDeUsuarios.size)
	}

//	@Test
//	def void testListaDeUsuariosRepo() {
//		Assertions.assertEquals(3, repoUsuario.lista.size)
//	}
	@Test
	def void testListaDeAmigos() {
		Assertions.assertEquals(0, this.modeloPerfil.listaDeAmigos.size)
	}

	@Test
	def void testAgregar1amigo() {
		this.modeloPerfil.usuarioSeleccionado = repoUsuario.buscarPor("Clemente", "12345")
		this.modeloPerfil.agregar

		Assertions.assertEquals(1, this.modeloPerfil.listaDeAmigos.size)
	}

	@Test
	def void testAgregarDebeQuitarUnUsuarioDeListaDeUsuario() {
		this.modeloPerfil.usuarioSeleccionado = repoUsuario.buscarPor("Clemente", "12345")
		this.modeloPerfil.agregar

		Assertions.assertEquals(1, this.modeloPerfil.listaDeUsuarios.size)
	}

	@Test
	def void testAgregar2Amigos() {
		this.modeloPerfil.usuarioSeleccionado = repoUsuario.buscarPor("Clemente", "12345")
		this.modeloPerfil.agregar
		this.modeloPerfil.usuarioSeleccionado = repoUsuario.buscarPor("Ursula", "12345")
		this.modeloPerfil.agregar

		Assertions.assertEquals(2, this.modeloPerfil.listaDeAmigos.size)
	}

	@Test
	def void testAgregarDeberiaQuitarDosUsuariosDeListaDeUsuarios() {
		this.modeloPerfil.usuarioSeleccionado = repoUsuario.buscarPor("Clemente", "12345")
		this.modeloPerfil.agregar
		this.modeloPerfil.usuarioSeleccionado = repoUsuario.buscarPor("Ursula", "12345")
		this.modeloPerfil.agregar
		Assertions.assertEquals(0, this.modeloPerfil.listaDeUsuarios.size)
	}

	@Test
	def void testQuitar1amigo() {
		this.modeloPerfil.usuarioSeleccionado = repoUsuario.buscarPor("Clemente", "12345")
		this.modeloPerfil.agregar
		this.modeloPerfil.usuarioSeleccionado = repoUsuario.buscarPor("Ursula", "12345")
		this.modeloPerfil.agregar
		this.modeloPerfil.usuarioSeleccionado = repoUsuario.buscarPor("Clemente", "12345")
		this.modeloPerfil.quitar
		Assertions.assertEquals(1, this.modeloPerfil.listaDeAmigos.size)
	}

	@Test
	def void testQuitarListaDeUsuario() {
		this.modeloPerfil.usuarioSeleccionado = repoUsuario.buscarPor("Clemente", "12345")
		this.modeloPerfil.agregar
		this.modeloPerfil.usuarioSeleccionado = repoUsuario.buscarPor("Ursula", "12345")
		this.modeloPerfil.agregar
		this.modeloPerfil.usuarioSeleccionado = repoUsuario.buscarPor("Clemente", "12345")
		this.modeloPerfil.quitar
		Assertions.assertEquals(1, this.modeloPerfil.listaDeUsuarios.size)
	}
}
