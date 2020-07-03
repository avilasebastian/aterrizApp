package dominio.elementos

import java.time.Duration
import java.time.LocalDateTime
import java.util.List
import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Embedded
import org.mongodb.morphia.annotations.Entity
import org.mongodb.morphia.annotations.Id
import org.mongodb.morphia.annotations.PrePersist
import org.mongodb.morphia.annotations.Reference
import org.uqbar.commons.model.annotations.Observable
import com.fasterxml.jackson.annotation.JsonIgnoreProperties

@Accessors @Observable @Entity("Vuelo")
@JsonIgnoreProperties(value = #["changeSupport"])
abstract class Vuelo {
	@Id var ObjectId id_MDB

	var String aerolinea
	var String ciudadOrigen
	var String ciudadDestino
	var LocalDateTime partida

	@Embedded
	var List<Asiento> asientos = newArrayList

	def Integer getHorasDeVuelo()
	def String getAvion()
	def Double getPrecio()
	def Integer getEscalas()

	def void agregar(Asiento asiento) {
		asiento.setPrecioDelAvion(getPrecio)
		asientos.add(asiento)
	}

	def void quitar(Asiento asiento) {
		asientos.remove(asiento)
	}
	
	def void quitarSi(String numeroAsiento) {
		asientos.removeIf(asiento | asiento.numeroAsiento == numeroAsiento)
	}
	
	def List<Asiento> getAsientos() {
		asientos
	}

	def Boolean estaVendido() {
		asientos.isEmpty
	}

	def Double recargoPorUltimosPasajes() {
		if(asientos.size > 2) 1.0 else 1.15
	}

	def List<Asiento> asientosDeClaseYTipo(String clase, Boolean ventanilla) {
		asientos.filter[asiento|asiento.esDeClaseYTipo(clase, ventanilla)].toList
	}
}

@Accessors @Entity("Vuelo")
class VueloSimple extends Vuelo {
	var String avion
	var Double precio
	var Integer horasDeVuelo

	override getEscalas() { 1 }
}

@Accessors @Entity("Vuelo")
class VueloConEscala extends Vuelo {
	@PrePersist
	def void prePersist() {
		this.setCiudadOrigen(this.getCiudadOrigen())
		this.setCiudadDestino(this.getCiudadDestino())
		this.setPartida(this.getPartida())
	}

	@Reference
	var List<Vuelo> escalas = newArrayList

	override Integer getEscalas() {
		escalas.size()
	}

	def void agregarEscala(Vuelo escala) {
		escalas.add(escala)
	}

	def void quitarEscala(Vuelo escala) {
		escalas.remove(escala)
	}

	override String getCiudadOrigen() {
		if(!escalas.isEmpty) escalas.head.ciudadOrigen
	}

	override String getCiudadDestino() {
		if(!escalas.isEmpty) escalas.last.ciudadDestino
	}

	override String getAvion() {
		if(!escalas.isEmpty) escalas.last.avion
	}

	override Integer getHorasDeVuelo() {
		Duration.between(getPartida(), getArribo()).toHours.intValue
	}

	override LocalDateTime getPartida() {
		if(!escalas.isEmpty) escalas.head.partida
	}

	private def LocalDateTime getArribo() {
		ultimaPartida.plusHours(escalas.last.horasDeVuelo)
	}

	private def LocalDateTime ultimaPartida() {
		escalas.last.partida
	}

	override Double getPrecio() {
		0.9 * escalas.fold(0.0, [sum, vuelo|sum + vuelo.precio])
	}
}