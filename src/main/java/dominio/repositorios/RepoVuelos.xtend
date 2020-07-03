package dominio.repositorios

import dominio.elementos.DatosDeBusqueda
import dominio.elementos.Pasaje
import dominio.elementos.Vuelo
import java.util.List
import org.bson.types.ObjectId
import org.mongodb.morphia.Datastore
import org.mongodb.morphia.query.Query
import org.mongodb.morphia.query.UpdateOperations

class RepoVuelos implements Repo<Vuelo> {
	var Datastore datastore

	new(Datastore datastore) {
		this.datastore = datastore
	}

	override void crear(Vuelo vuelo) {
		vuelo.id_MDB = new ObjectId(datastore.save(vuelo).id.toString)
	}

	override List<Vuelo> buscarTodo() {
		datastore.createQuery(Vuelo).asList
	}

	override void actualizar(Vuelo vuelo) {
		datastore.update(vuelo, opDeActualizacion(vuelo))
	}

	private def UpdateOperations<Vuelo> opDeActualizacion(Vuelo vuelo) {
		datastore.createUpdateOperations(Vuelo).set("asientos", vuelo.asientos)
	}

	private def void borrar(Vuelo vuelo) {
		datastore.delete(vuelo)
	}

	def List<Vuelo> buscarPor(DatosDeBusqueda dato) {
		var Query<Vuelo> query = datastore.createQuery(Vuelo)

		if (!dato.origen.equals(""))
			query.criteria("ciudadOrigen").containsIgnoreCase(dato.origen)
		if (!dato.destino.equals(""))
			query.criteria("ciudadDestino").containsIgnoreCase(dato.destino)
		if (!dato.clase.equals(""))
			query.criteria("asientos.clase").equal(dato.clase)
		if (dato.ventanilla !== null)
			query.criteria("asientos.ventanilla").equal(dato.ventanilla)

		query.criteria("partida").greaterThanOrEq(dato.fechaDesde)
		query.criteria("partida").lessThanOrEq(dato.fechaHasta)

		query.asList
	}

	def void reservar(Pasaje pasaje) {
		var  idVuelo = new ObjectId(pasaje.id.idVuelo)
		var Vuelo vuelo = datastore.find(Vuelo).field("_id").equal(idVuelo).get

		vuelo.quitarSi(pasaje.id.numeroAsiento)
				
		if(vuelo.asientos.isEmpty) {
			this.borrar(vuelo)
		} else {
			datastore.update(vuelo, datastore.createUpdateOperations(Vuelo).set("asientos", vuelo.asientos))
		}
	}
}
