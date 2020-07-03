package dominio.repositorio

import com.mongodb.MongoClient
import dominio.elementos.Asiento
import dominio.elementos.DatosDeBusqueda
import dominio.elementos.Vuelo
import dominio.elementos.VueloSimple
import dominio.repositorios.RepoVuelos
import java.time.LocalDateTime
import java.util.List
import org.bson.types.ObjectId
import org.junit.jupiter.api.AfterEach
import org.junit.jupiter.api.Assertions
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.mongodb.morphia.Datastore
import org.mongodb.morphia.Morphia

class TestRepoVuelos {
	var List<Vuelo> vuelos = newArrayList
	var List<VueloSimple> vuelosSimples = newArrayList
	var List<Asiento> asientos = newArrayList
	var RepoVuelos repo
	var Datastore datastore

	@BeforeEach
	def void init() {
		if (datastore === null) {
			val MongoClient mongo = new MongoClient("localhost", 27017)
			val Morphia morphia = new Morphia(#{Vuelo})
			
			datastore = morphia.createDatastore(mongo, "aterrizApp")
			datastore.ensureIndexes()
		}

		repo = new RepoVuelos(datastore)

		(0 .. 4).forEach [ i |
			vuelosSimples.add(new VueloSimple() => [
				it.ciudadOrigen = "ciudad_0"
				it.ciudadDestino = "ciudad_2"
				it.horasDeVuelo = i + 1
				it.partida = LocalDateTime.of(2020, 02, (21 + i), 10, 0, 0)
				it.precio = 0.0
			])
		]

		vuelosSimples.get(4).ciudadOrigen = "ciudad_3"
		vuelosSimples.get(0).ciudadDestino = "ciudad_1"

		asientos.add(new Asiento() => [clase = "Economica"; ventanilla = false])
		asientos.add(new Asiento() => [clase = "Economica"; ventanilla = true])
		asientos.add(new Asiento() => [clase = "Economica"; ventanilla = true])
		asientos.add(new Asiento() => [clase = "Ejecutiva"; ventanilla = false])
		asientos.add(new Asiento() => [clase = "Ejecutiva"; ventanilla = false])

		(0 .. 4).forEach [ i |
			vuelosSimples.get(i).agregar(asientos.get(i))
			asientos.get(i).precio = 0.0
		]

//		asientos.forEach[it.id_MDB = new ObjectId]
		
		vuelos.addAll(vuelosSimples)
		vuelos.forEach[
			it.id_MDB = new ObjectId(datastore.save(it).id.toString)
		]
	}

	@AfterEach
	def void end() {
		datastore.getDB.dropDatabase
	}


//	@Test
//	def void test_seReservaUnPasaje_AlQuedarAsientosElVueloSigueExistiendo() {
//		var Pasaje pasaje = new Pasaje(
//			vuelos.get(0),
//			asientos.get(0),
//			LocalDateTime.now
//		)
//
//		vuelos.get(0).agregar(asientos.get(1))
//		vuelos.get(0).agregar(asientos.get(2))
//		repo.reservar(pasaje)
//
//		Assertions.assertTrue(repo.lista.contains(vuelos.get(0)))
//	}

//	@test
//	def void test_sereservatodopasaje_alquedarsinasientoselvuelodejadeexistiendo() {
//		var list<objectid> vuelosbase
//		var objectid vuelorefe
//
//		(0 .. 2).foreach [ i |
//			repo.reservar(new pasaje(vuelos.get(0), asientos.get(i), localdatetime.now))
//		]
//
//		vuelosbase = repo.buscartodo.map[id_mdb]
//		vuelorefe = vuelos.get(0).id_mdb
//
//		assertions.assertfalse(vuelosbase.contains(vuelorefe))
//	}

	@Test
	def void test_todosLosVuelosConUnOrigen() {
		var DatosDeBusqueda datosDeBusqueda = new DatosDeBusqueda(0.longValue)
		var List<ObjectId> vuelosBase
		var List<ObjectId> vuelosRefe

		datosDeBusqueda.origen = "ciudad_0"

		vuelosBase = repo.buscarPor(datosDeBusqueda).map[id_MDB]
		vuelosRefe = #[vuelos.get(0), vuelos.get(3)].map[id_MDB]

		Assertions.assertEquals(vuelosBase, vuelosRefe)
	}

	@Test
	def void test_todosLosVuelosConUnDestino() {
		var DatosDeBusqueda datosDeBusqueda = new DatosDeBusqueda(0.longValue)
		var List<ObjectId> vuelosBase
		var List<ObjectId> vuelosRefe

		datosDeBusqueda.destino = "ciudad_2"
		datosDeBusqueda.ventanilla = null

		vuelosBase = repo.buscarPor(datosDeBusqueda).map[id_MDB]
		vuelosRefe = vuelos.subList(1, 5).map[id_MDB]

		Assertions.assertEquals(vuelosBase, vuelosRefe)
	}

	@Test
	def void test_todosLosVuelosConUnDestinoYUnOrigen() {
		var DatosDeBusqueda datosDeBusqueda = new DatosDeBusqueda(0.longValue)
		var List<ObjectId> vuelosBase
		var List<ObjectId> vuelosRefe

		datosDeBusqueda.origen = "ciudad_0"
		datosDeBusqueda.destino = "ciudad_2"
		datosDeBusqueda.ventanilla = null

		vuelosBase = repo.buscarPor(datosDeBusqueda).map[id_MDB]
		vuelosRefe = vuelos.subList(1, 4).map[id_MDB]

		Assertions.assertEquals(vuelosBase, vuelosRefe)
	}

	@Test
	def void test_listaCompletaFechasAnteriorATodoVuelo() {
		var DatosDeBusqueda datosDeBusqueda = new DatosDeBusqueda(0.longValue)
		var List<ObjectId> vuelosBase
		var List<ObjectId> vuelosRefe

		datosDeBusqueda.fechaDesde = LocalDateTime.of(2020, 02, 20, 10, 0, 0)
		datosDeBusqueda.ventanilla = null

		vuelosBase = repo.buscarPor(datosDeBusqueda).map[id_MDB]
		vuelosRefe = vuelos.map[id_MDB]

		Assertions.assertEquals(vuelosBase, vuelosRefe)
	}

	@Test
	def void test_listaCompletaFechasPosterioATodoVuelo() {
		var DatosDeBusqueda datosDeBusqueda = new DatosDeBusqueda(0.longValue)
		var List<ObjectId> vuelosBase
		var List<ObjectId> vuelosRefe

		datosDeBusqueda.fechaHasta = LocalDateTime.of(2020, 03, 20, 10, 0, 0)
		datosDeBusqueda.ventanilla = null

		vuelosBase = repo.buscarPor(datosDeBusqueda).map[id_MDB]
		vuelosRefe = vuelos.map[id_MDB]

		Assertions.assertEquals(vuelosBase, vuelosRefe)
	}

	@Test
	def void test_vuelosExistentesConFechasEntre_listaCompleta() {
		var DatosDeBusqueda datosDeBusqueda = new DatosDeBusqueda(0.longValue)
		var List<ObjectId> vuelosBase
		var List<ObjectId> vuelosRefe

		datosDeBusqueda.fechaDesde = LocalDateTime.of(2020, 02, 20, 10, 0, 0)
		datosDeBusqueda.fechaHasta = LocalDateTime.of(2020, 03, 20, 10, 0, 0)
		datosDeBusqueda.ventanilla = null

		vuelosBase = repo.buscarPor(datosDeBusqueda).map[id_MDB]
		vuelosRefe = vuelos.map[id_MDB]

		Assertions.assertEquals(vuelosBase, vuelosRefe)
	}

	@Test
	def void test_vuelosExistentesConFechasEntre_listaFiltrada_listaCompleta() {
		var DatosDeBusqueda datosDeBusqueda = new DatosDeBusqueda(0.longValue)
		var List<ObjectId> vuelosBase
		var List<ObjectId> vuelosRefe

		datosDeBusqueda.fechaDesde = LocalDateTime.of(2020, 02, 21, 10, 0, 0)
		datosDeBusqueda.fechaHasta = LocalDateTime.of(2020, 02, 25, 10, 0, 0)
		datosDeBusqueda.ventanilla = null

		vuelosBase = repo.buscarPor(datosDeBusqueda).map[id_MDB]
		vuelosRefe = vuelos.map[id_MDB]

		Assertions.assertEquals(vuelosBase, vuelosRefe)
	}

	@Test
	def void test_vuelosExistentesConFechasEntre_listaFiltrada() {
		var DatosDeBusqueda datosDeBusqueda = new DatosDeBusqueda(0.longValue)
		var List<ObjectId> vuelosBase
		var List<ObjectId> vuelosRefe

		datosDeBusqueda.fechaDesde = LocalDateTime.of(2020, 02, 22, 10, 0, 0)
		datosDeBusqueda.fechaHasta = LocalDateTime.of(2020, 02, 24, 10, 0, 0)
		datosDeBusqueda.ventanilla = null

		vuelosBase = repo.buscarPor(datosDeBusqueda).map[id_MDB]
		vuelosRefe = vuelos.subList(1, 4).map[id_MDB]

		Assertions.assertEquals(vuelosBase, vuelosRefe)
	}

	@Test
	def void test_LugarOrigenInterseccionConRagoDeFechas() {
		var DatosDeBusqueda datosDeBusqueda = new DatosDeBusqueda(0.longValue)
		var List<ObjectId> vuelosBase
		var List<ObjectId> vuelosRefe

		// (ciudad_0, todo) interseccion (22, 24)
		datosDeBusqueda.origen = "ciudad_0"
		datosDeBusqueda.fechaDesde = LocalDateTime.of(2020, 02, 22, 10, 0, 0)
		datosDeBusqueda.fechaHasta = LocalDateTime.of(2020, 02, 24, 10, 0, 0)
		datosDeBusqueda.ventanilla = null

		vuelosBase = repo.buscarPor(datosDeBusqueda).map[id_MDB]
		vuelosRefe = vuelos.subList(1, 4).map[id_MDB]

		Assertions.assertEquals(vuelosBase, vuelosRefe)
	}

	@Test
	def void test_LugarDestinoInterseccionConRagoDeFechas() {
		var DatosDeBusqueda datosDeBusqueda = new DatosDeBusqueda(0.longValue)
		var List<ObjectId> vuelosBase
		var List<ObjectId> vuelosRefe

		// (todo, ciudad_2) interseccion (22, 24)
		datosDeBusqueda.destino = "ciudad_2"
		datosDeBusqueda.fechaDesde = LocalDateTime.of(2020, 02, 22, 10, 0, 0)
		datosDeBusqueda.fechaHasta = LocalDateTime.of(2020, 02, 24, 10, 0, 0)
		datosDeBusqueda.ventanilla = null

		vuelosBase = repo.buscarPor(datosDeBusqueda).map[id_MDB]
		vuelosRefe = vuelos.subList(1, 4).map[id_MDB]

		Assertions.assertEquals(vuelosBase, vuelosRefe)
	}

	@Test
	def void test_LugarOrigenDestinoInterseccionConRagoDeFechas() {
		var DatosDeBusqueda datosDeBusqueda = new DatosDeBusqueda(0.longValue)
		var List<ObjectId> vuelosBase
		var List<ObjectId> vuelosRefe

		// (ciudad_0, ciudad_2) interseccion (22, 24)
		datosDeBusqueda.origen = "ciudad_0"
		datosDeBusqueda.destino = "ciudad_2"
		datosDeBusqueda.fechaDesde = LocalDateTime.of(2020, 02, 22, 10, 0, 0)
		datosDeBusqueda.fechaHasta = LocalDateTime.of(2020, 02, 24, 10, 0, 0)
		datosDeBusqueda.ventanilla = null

		vuelosBase = repo.buscarPor(datosDeBusqueda).map[id_MDB]
		vuelosRefe = vuelos.subList(1, 4).map[id_MDB]

		Assertions.assertEquals(vuelosBase, vuelosRefe)
	}

	@Test
	def void test_comprobacionPorAsientos() {
		var DatosDeBusqueda datosDeBusqueda = new DatosDeBusqueda(0.longValue)
		var List<ObjectId> vuelosBase
		var List<ObjectId> vuelosRefe

		datosDeBusqueda.clase = "Economica"
		datosDeBusqueda.ventanilla = true

		vuelosBase = repo.buscarPor(datosDeBusqueda).map[id_MDB]
		vuelosRefe = vuelos.subList(1, 3).map[id_MDB]

		Assertions.assertEquals(vuelosBase, vuelosRefe)
	}

	@Test
	def void test_todosLosatributos() {
		var DatosDeBusqueda datosDeBusqueda = new DatosDeBusqueda(0.longValue)
		var List<ObjectId> vuelosBase
		var List<ObjectId> vuelosRefe

		datosDeBusqueda.origen = "ciudad_0"
		datosDeBusqueda.destino = "ciudad_2"
		datosDeBusqueda.fechaDesde = LocalDateTime.of(2020, 02, 22, 10, 0, 0)
		datosDeBusqueda.fechaHasta = LocalDateTime.of(2020, 02, 24, 10, 0, 0)
		datosDeBusqueda.clase = "Economica"
		datosDeBusqueda.ventanilla = true

		vuelosBase = repo.buscarPor(datosDeBusqueda).map[id_MDB]
		vuelosRefe = vuelos.subList(1, 3).map[id_MDB]

		Assertions.assertEquals(vuelosBase, vuelosRefe)
	}

	@Test
	def void test_todosLosatributos_complementarioVacio() {
		var DatosDeBusqueda datosDeBusqueda = new DatosDeBusqueda(0.longValue)

		datosDeBusqueda.origen = "ciudad_0"
		datosDeBusqueda.destino = "ciudad_2"
		datosDeBusqueda.fechaDesde = LocalDateTime.of(2020, 02, 22, 10, 0, 0)
		datosDeBusqueda.fechaHasta = LocalDateTime.of(2020, 02, 24, 10, 0, 0)
		datosDeBusqueda.clase = "Economica"
		datosDeBusqueda.ventanilla = false

		Assertions.assertTrue(repo.buscarPor(datosDeBusqueda).isEmpty)
	}
}