package ui.aplicacion

import dominio.elementos.Asiento
import dominio.elementos.Pasaje
import dominio.elementos.Usuario
import dominio.elementos.VueloConEscala
import dominio.elementos.VueloSimple
import dominio.repositorios.RepoUsuario
import dominio.repositorios.RepoVuelos
import java.time.LocalDateTime
import java.util.List
import javax.persistence.EntityManager
import org.mongodb.morphia.Datastore

class BootstrapUp {
	var RepoUsuario repoUsuario
	var RepoVuelos repoVuelo

	new(EntityManager entityManager, Datastore datastore) {
		this.repoUsuario = new RepoUsuario(entityManager)
		this.repoVuelo = new RepoVuelos(datastore)
	}

	def void cargarBaseDeDatos() {
		var Boolean repoUsuarioVacio = repoUsuario.buscarTodo.isEmpty
		var Boolean repoVueloVacio = repoVuelo.buscarTodo.isEmpty

		if(repoUsuarioVacio && repoVueloVacio) {
			this.cargarDatos()
		} else if(repoUsuarioVacio == !repoVueloVacio) { // !xor
			throw new RuntimeException("Existen incossistencias en las bases")
		} else {
			println('''	Base de datos cargada ''')
		}
	}

	private def void cargarDatos() {
		val List<Usuario> usuarios = newArrayList
		val List<VueloSimple> vuelos = newArrayList
		val List<Asiento> asientos = newArrayList

		val VueloConEscala escala = new VueloConEscala()
		val LocalDateTime ahora = LocalDateTime.now

		usuarios => [
			add(new Usuario() => [
				it.nombre = "Bonifacio"
				it.apellido = "Gomez"
				it.edad = 46
				it.saldo = 15000.00

				it.usuarioNombre = "Bonifacio"
				it.clave = "12345"
				it.imagen = "U1"
			])

			add(new Usuario() => [
				it.nombre = "Clemente"
				it.apellido = "Lopez"
				it.edad = 34
				it.saldo = 12000.00

				it.usuarioNombre = "Clemente"
				it.clave = "12345"
				it.imagen = "U2"
			])

			add(new Usuario() => [
				it.nombre = "Dalmacio"
				it.apellido = "Martinez"
				it.edad = 44
				it.saldo = 8000.00

				it.usuarioNombre = "Dalmacio"
				it.clave = "12345"
				it.imagen = "U3"
			])

			add(new Usuario() => [
				it.nombre = "Emeterio"
				it.apellido = "Garcia"
				it.edad = 25
				it.saldo = 25000.00

				it.usuarioNombre = "Emeterio"
				it.clave = "12345"
				it.imagen = "U4"
			])

			add(new Usuario() => [
				it.nombre = "Taciana"
				it.apellido = "Moyano"
				it.edad = 27
				it.saldo = 35000.00

				it.usuarioNombre = "Taciana"
				it.clave = "12345"
				it.imagen = "U5"
			])

			add(new Usuario() => [
				it.nombre = "Ursula"
				it.apellido = "Campos"
				it.edad = 19
				it.saldo = 5000.00

				it.usuarioNombre = "Ursula"
				it.clave = "12345"
				it.imagen = "U6"
			])

			add(new Usuario() => [
				it.nombre = "Valentina"
				it.apellido = "Soto"
				it.edad = 23
				it.saldo = 15000.00

				it.usuarioNombre = "Valentina"
				it.clave = "12345"
				it.imagen = "U7"
			])

			add(new Usuario() => [
				it.nombre = "Zeferina"
				it.apellido = "Chávez"
				it.edad = 23
				it.saldo = 23000.00

				it.usuarioNombre = "Zeferina"
				it.clave = "12345"
				it.imagen = "U8"
			])
		]

		vuelos => [
			add(new VueloSimple() => [
				it.ciudadOrigen = "Buenos Aires"
				it.ciudadDestino = "Parana"
				it.aerolinea = "AeroPepita"
				it.avion = "Comac 001"
				it.horasDeVuelo = 1
				it.partida = ahora
				it.precio = 1000.0
			])

			add(new VueloSimple() => [
				it.ciudadOrigen = "Parana"
				it.ciudadDestino = "Buenos Aires"
				it.aerolinea = "AeroPepita"
				it.avion = "Comac 010"
				it.horasDeVuelo = 1
				it.partida = ahora
				it.precio = 1000.0
			])

			add(new VueloSimple() => [
				it.ciudadOrigen = "Buenos Aires"
				it.ciudadDestino = "Santa Fe"
				it.aerolinea = "AeroPepita"
				it.avion = "Comac 001"
				it.horasDeVuelo = 2
				it.partida = ahora.plusDays(1)
				it.precio = 1100.0
			])

			add(new VueloSimple() => [
				it.ciudadOrigen = "Santa Fe"
				it.ciudadDestino = "Buenos Aires"
				it.aerolinea = "AeroPepita"
				it.avion = "Comac 001"
				it.horasDeVuelo = 2
				it.partida = ahora.plusDays(1)
				it.precio = 1100.0
			])

			add(new VueloSimple() => [
				it.ciudadOrigen = "Buenos Aires"
				it.ciudadDestino = "Cordoba"
				it.aerolinea = "DodainLlegaVolando"
				it.avion = "Alas de tela"
				it.horasDeVuelo = 3
				it.partida = ahora.plusDays(2)
				it.precio = 1200.0
			])

			add(new VueloSimple() => [
				it.ciudadOrigen = "Cordoba"
				it.ciudadDestino = "Buenos Aires"
				it.aerolinea = "DodainLlegaVolando"
				it.avion = "Alas de tela"
				it.horasDeVuelo = 3
				it.partida = ahora.plusDays(2)
				it.precio = 1200.0
			])

			add(new VueloSimple() => [
				it.ciudadOrigen = "Buenos Aires"
				it.ciudadDestino = "San Luis"
				it.aerolinea = "ChanchitoVolador"
				it.avion = "Dirigible"
				it.horasDeVuelo = 3
				it.partida = ahora.plusDays(3)
				it.precio = 1300.0
			])

			add(new VueloSimple() => [
				it.ciudadOrigen = "San Luis"
				it.ciudadDestino = "Buenos Aires"
				it.aerolinea = "ChanchitoVolador"
				it.avion = "Dirigible"
				it.horasDeVuelo = 3
				it.partida = ahora.plusDays(3)
				it.precio = 1300.0
			])

			add(new VueloSimple() => [
				it.ciudadOrigen = "Santa Fe"
				it.ciudadDestino = "Cordoba"
				it.aerolinea = "ChanchitoVolador"
				it.avion = "Dirigible"
				it.horasDeVuelo = 3
				it.partida = ahora.plusDays(4)
				it.precio = 1400.0
			])
		]

		(0 .. 19).forEach [ i |
			asientos => [
				add(new Asiento() => [
					it.numeroAsiento = "V" + i + "AEC"
					it.ventanilla = false
					it.precio = 1000.0
					it.clase = "Economica"
				])
			]
		]

		(0 .. 19).forEach [ i |
			asientos => [
				add(new Asiento() => [
					it.numeroAsiento = "V" + (20 + i) + "AEJ"
					it.ventanilla = false
					it.precio = 2000.0
					it.clase = "Ejecutivo"
				])
			]
		]

		(0 .. 19).forEach [ i |
			asientos => [
				add(new Asiento() => [
					it.numeroAsiento = "V" + (40 + i) + "APR"
					it.ventanilla = true
					it.precio = 10000.0
					it.clase = "Primera"
				])
			]
		]

		escala.agregarEscala(vuelos.get(2))
		escala.agregarEscala(vuelos.get(8))
		escala.aerolinea = "Arolineas Argentinas"

		(2 .. 5).forEach [ j |
			escala.agregar(asientos.get(6 * 9 + j))

			(0 .. 8).forEach [ i |
				if ((6 * i + j) !== 46 && (6 * i + j) !== 47)
					vuelos.get(i).agregar(asientos.get(6 * i + j))
			]
		]

		vuelos.get(8).agregar(asientos.get(48))
		vuelos.get(8).agregar(asientos.get(49))
		escala.agregar(asientos.get(54))
		escala.agregar(asientos.get(55))

		vuelos.forEach[repoVuelo.crear(it)]
		repoVuelo.crear(escala)

		(0 .. 7).forEach [ i |
			(0 .. 1).forEach [ j |
				usuarios.get(i).reservas.add(
					new Pasaje(vuelos.get(i), asientos.get(6 * i + j), ahora.minusDays(2))
				)
			]
		]

		usuarios.get(5).reservas.add(
			new Pasaje(vuelos.get(6), asientos.get(46), ahora.minusDays(8))
		)

		usuarios.get(5).reservas.add(
			new Pasaje(vuelos.get(8), asientos.get(47), ahora.minusDays(8))
		)

		usuarios.forEach[repoUsuario.crear(it)]
	}
}