package ui.modelos

import dominio.elementos.Asiento
import dominio.elementos.DatosDeBusqueda
import dominio.elementos.Pasaje
import dominio.elementos.Usuario
import dominio.elementos.Vuelo
import dominio.elementos.VueloSimple
import dominio.repositorios.Carrito
import dominio.repositorios.RepoUsuario
import dominio.repositorios.RepoVuelos
import java.time.LocalDateTime
import java.util.ArrayList
import java.util.HashSet
import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.jupiter.api.BeforeEach
import org.uqbar.commons.applicationContext.ApplicationContext

import static org.mockito.Mockito.mock
import static org.mockito.Mockito.when
import dominio.repositorios.Historial

@Accessors
class DatosModelos {
	var Historial historial
	var RepoUsuario repoUsuario
	var RepoVuelos repoVuelo
	var Carrito carrito

	var ModeloLogin modeloLogin
	var ModeloVuelo modeloVuelo
	var ModeloCarrito modeloCarrito
	var ModeloPerfil modeloPerfil

	var Pasaje pasaje1
	var Pasaje pasaje2
	var Pasaje pasaje3

	var Usuario usuario1
	var Usuario usuario2
	var Usuario usuario3

	var Vuelo vuelo1
	var Vuelo vuelo2

	var Asiento asiento1
	var Asiento asiento2
	var Asiento asiento3
	var Asiento asiento4

	var DatosDeBusqueda dato

	/* init */
	@BeforeEach
	def void init() {
		dato  = new DatosDeBusqueda(0.longValue)
		
		this.crearUsuario()
		this.crearYCargarVuelos()
		this.crearYCargarAsientos()
		this.datosParaModeloCarrito()

		this.crearRepositorios()
		this.cargarBootstrap()
		
		carrito.agregar(pasaje1)
	}

	def crearRepositorios() {
		historial = mockHistorial
		repoUsuario = mockRepoUsuario
		repoVuelo = mockRepoVuelos(dato)
//		carrito = new Carrito
	}

	def cargarBootstrap() {
		ApplicationContext.instance.configureSingleton(Historial, historial)
		ApplicationContext.instance.configureSingleton(RepoUsuario, repoUsuario)
		ApplicationContext.instance.configureSingleton(RepoVuelos, repoVuelo)
		ApplicationContext.instance.configureSingleton(Carrito,new Carrito(usuario1))

		ApplicationContext.instance.configureSingleton("Lista", new ArrayList => [
			add("")
			add("Economica")
			add("Primera")
			add("Ejecutivo")
		])
	}

	def crearUsuario() {
		usuario1 = new Usuario() => [
			it.id_HDB = 1.longValue
			it.nombre = "Bonifacio"
			it.apellido = "Gomez"
			it.edad = 46
			it.saldo = 15000.00

			it.usuarioNombre = "Bonifacio"
			it.clave = "12345"
			it.imagen = "U1"
		]

		usuario2 = new Usuario() => [
			it.id_HDB = 2.longValue
			it.nombre = "Clemente"
			it.apellido = "Lopez"
			it.edad = 34
			it.saldo = 12000.00

			it.usuarioNombre = "Clemente"
			it.clave = "12345"
			it.imagen = "U2"
		]

		usuario3 = new Usuario() => [
			it.id_HDB = 3.longValue
			it.nombre = "Ursula"
			it.apellido = "Campos"
			it.edad = 19
			it.saldo = 5000.00

			it.usuarioNombre = "Ursula"
			it.clave = "12345"
			it.imagen = "U6"
		]

//		repoUsuario.agregar(usuario1)
//		repoUsuario.agregar(usuario2)
//		repoUsuario.agregar(usuario3)
	}

	def crearYCargarVuelos() {
		vuelo1 = new VueloSimple() => [
			it.id_MDB = new ObjectId()
			it.ciudadOrigen = "Buenos Aires"
			it.ciudadDestino = "San Luis"
			it.aerolinea = "ChanchitoVolador"
			it.avion = "Dirigible"
			it.horasDeVuelo = 3
			it.partida = LocalDateTime.now.plusDays(3)
			it.precio = 1300.0
		]

		vuelo2 = new VueloSimple() => [
			it.id_MDB = new ObjectId()
			it.ciudadOrigen = "Santa Fe"
			it.ciudadDestino = "Buenos Aires"
			it.aerolinea = "AeroPepita"
			it.avion = "Comac 001"
			it.horasDeVuelo = 2
			it.partida = LocalDateTime.now.plusDays(1)
			it.precio = 9000.0
		]

//		repoVuelo.agregar(vuelo1)
//		repoVuelo.agregar(vuelo2)
	}

	def crearYCargarAsientos() {
		asiento1 = new Asiento() => [
			it.numeroAsiento = "A01"
			it.ventanilla = true
			it.precio = 2000.0
			it.clase = "Ejecutivo"
		]

		asiento2 = new Asiento() => [
			it.numeroAsiento = "A02"
			it.ventanilla = false
			it.precio = 2000.0
			it.clase = "Ejecutivo"
		]

		asiento3 = new Asiento() => [
			it.numeroAsiento = "B01"
			it.ventanilla = false
			it.precio = 1000.0
			it.clase = "Economico"
		]

		asiento4 = new Asiento() => [
//			it.id_MDB = new ObjectId()
			it.numeroAsiento = "B01"
			it.ventanilla = false
			it.precio = 1000.0
			it.clase = "Economico"
		]

		vuelo1.agregar(asiento1)
		vuelo1.agregar(asiento2)
		vuelo1.agregar(asiento3)
		vuelo2.agregar(asiento4)
	}

	def void datosParaModeloCarrito() {
		pasaje1 = new Pasaje(vuelo1, asiento1, LocalDateTime.now)
		pasaje2 = new Pasaje(vuelo1, asiento2, LocalDateTime.now)
		pasaje3 = new Pasaje(vuelo2, asiento4, LocalDateTime.now)

//		carrito.agregar(pasaje1)
//		repoVuelo.reservar(pasaje1)
	}

	def loginUsuario() {
		this.modeloLogin.nombre = "Bonifacio"
		this.modeloLogin.clave = "12345"
		this.modeloLogin.loginDeUsuario
	}

	def RepoUsuario mockRepoUsuario() {
		val RepoUsuario repoUsuarioTemp = mock(RepoUsuario)

		when(
			repoUsuarioTemp.buscarPor("Bonifacio", "12345")
		).thenReturn(
			usuario1
		)

		when(
			repoUsuarioTemp.buscarPor("Clemente", "12345")
		).thenReturn(
			usuario2
		)

		when(
			repoUsuarioTemp.buscarPor("Ursula", "12345")
		).thenReturn(
			usuario3
		)

		when(
			repoUsuarioTemp.listaDeCandidatos(usuario1)
		).thenReturn(
			new HashSet<Usuario>(#{usuario2, usuario3})
		)

		return repoUsuarioTemp
	}

	def RepoVuelos mockRepoVuelos(DatosDeBusqueda dato) {
		val RepoVuelos repoVuelosTemp = mock(RepoVuelos)
		
		when(
			repoVuelosTemp.buscarPor(dato)
		).thenReturn(
			#[vuelo1, vuelo2]
		)

		return repoVuelosTemp
	}

	def Historial mockHistorial() {
		val Historial repoHistorialTemp = mock(Historial)
		
		return repoHistorialTemp
	}
}
