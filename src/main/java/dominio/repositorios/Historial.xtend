package dominio.repositorios

import dominio.elementos.DatosDeBusqueda
import java.util.List
import org.mongodb.morphia.Datastore

class Historial {
	var Datastore datastore

	new(Datastore datastore) {
		this.datastore = datastore
	}

	def List<DatosDeBusqueda> get(Long id) {
		datastore.
			createQuery(DatosDeBusqueda)
			.field("idUsuario")
			.equal(id)
			.asList
	}

	def void save(DatosDeBusqueda dato) {
		datastore.save(dato)
	}
}