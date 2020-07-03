package ui.aplicacion

import com.mongodb.MongoClient
import dominio.elementos.DatosDeBusqueda
import dominio.elementos.Vuelo
import dominio.repositorios.Historial
import dominio.repositorios.RepoUsuario
import dominio.repositorios.RepoVuelos
import java.util.ArrayList
import java.util.List
import javax.persistence.EntityManager
import javax.persistence.EntityManagerFactory
import javax.persistence.Persistence
import org.mongodb.morphia.Datastore
import org.mongodb.morphia.Morphia
import org.uqbar.arena.bootstrap.CollectionBasedBootstrap
import org.uqbar.commons.applicationContext.ApplicationContext


class Bootstrap extends CollectionBasedBootstrap {
	var EntityManagerFactory entityManagerFactory
	var EntityManager entityManager
	var Datastore datastore

	new() {

		this.cargarBaseSql()
		this.cargarBaseNoSql()

		ApplicationContext.instance.configureSingleton(
			RepoUsuario,
			new RepoUsuario(entityManager)
		)

		ApplicationContext.instance.configureSingleton(
			RepoVuelos,
			new RepoVuelos(datastore)
		)

		ApplicationContext.instance.configureSingleton(
			Historial,
			new Historial(datastore)
		)

		ApplicationContext.instance.configureSingleton(
			"Lista",
			new ArrayList()
		)
	}
	
	override run() {
		val List<String> listaDeClases = ApplicationContext.instance.getSingleton("Lista")
		val BootstrapUp bootstrapUp = new BootstrapUp(entityManager, datastore)

		listaDeClases.addAll(#["", "Economica", "Primera", "Ejecutivo"])
		bootstrapUp.cargarBaseDeDatos()
	}

	def void cargarBaseSql() {
		this.entityManagerFactory = Persistence.createEntityManagerFactory("AterrizApp")
		this.entityManager = entityManagerFactory.createEntityManager
	}

	def void cargarBaseNoSql() {
		if (datastore === null) {
			val MongoClient mongo = new MongoClient("localhost", 27017)
//			val MongoClient mongo = new MongoClient(#[
//		    	new ServerAddress("localhost",28001),
//			])
			
			val Morphia morphia = new Morphia(#{DatosDeBusqueda, Vuelo})
		
			morphia.mapper.options.cacheFactory = new MiCacheFactory()
			datastore = morphia.createDatastore(mongo, "aterrizApp")
			datastore.ensureIndexes()
		}
	}

	def void desconectar() {
		entityManager.close()
		entityManagerFactory.close()
	}

	def void despedida() {
		println('''¡Hasta luego!''')
	}
}