package dominio.elementos

import java.io.Serializable
import java.time.LocalDateTime
import javax.persistence.Column
import javax.persistence.Embeddable
import javax.persistence.EmbeddedId
import javax.persistence.Entity
import javax.persistence.Table
import javax.persistence.Transient
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import com.fasterxml.jackson.annotation.JsonIgnore


@Accessors @Observable @Entity
@Table(name="PASAJE")
@JsonIgnoreProperties(value = #["changeSupport"])
class Pasaje {
	
	@EmbeddedId var PasajeId id

	@Column(length=45) var String ciudadOrigen
	@Column(length=45) var String ciudadDestino
	@Column(length=45) var String aerolinea
	var Double precio
	var LocalDateTime partida
	@JsonIgnore var LocalDateTime fechaDeCompra
	@Transient var String clase
	
	new() { /** constructor para hibernate */ }

	new(Vuelo vuelo, Asiento asiento, LocalDateTime fechaDeCompra) {
		// referencia
		id = new PasajeId(vuelo.id_MDB.toString, asiento.numeroAsiento)

		// datos para usuario		
		this.ciudadOrigen = vuelo.ciudadOrigen
		this.ciudadDestino = vuelo.ciudadDestino
		this.partida = vuelo.partida
		this.aerolinea = vuelo.aerolinea

		// datos unicos del tiket
		this.fechaDeCompra = fechaDeCompra
		this.precio(vuelo, asiento)

		// afines de cache para ui
		this.clase = asiento.clase
	}

	private def void precio(Vuelo vuelo, Asiento asiento) {
		this.precio = asiento.precioTotal() * vuelo.recargoPorUltimosPasajes()
	}
}

@Accessors @Embeddable
class PasajeId implements Serializable {
	var String idVuelo
	var String numeroAsiento

	new() { /** constructor para nuevo pasaje en ejecución */ }

	new(String idVuelo, String numeroAsiento) {
		this.idVuelo = idVuelo
		this.numeroAsiento = numeroAsiento
	}

	def Boolean equals(PasajeId id) {
		this.idVuelo.equals(id.idVuelo) && this.numeroAsiento.equals(id.numeroAsiento)
	}
}