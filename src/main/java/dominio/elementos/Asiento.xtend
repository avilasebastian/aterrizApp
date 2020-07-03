package dominio.elementos

import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Embedded
import org.mongodb.morphia.annotations.Transient
import org.uqbar.commons.model.annotations.Observable
import com.fasterxml.jackson.annotation.JsonIgnoreProperties

@Accessors @Observable @Embedded
@JsonIgnoreProperties(value = #["changeSupport"])
class Asiento {
	var String numeroAsiento
	var String clase
	var Double precio
	var Boolean ventanilla

	@Transient
	var Double precioDelAvion = 0.0

	def Boolean esDeClaseYTipo(String clase, Boolean ventanilla) {
		esDeClase(clase) && esDeTipo(ventanilla)
	}

	private def Boolean esDeClase(String clase) {
		clase.equals(this.clase) || clase.equals("")
	}

	private def Boolean esDeTipo(Boolean ventanilla) {
		ventanilla === null || ventanilla.equals(this.ventanilla)
	}

	def Double precioTotal() {
		precio + precioDelAvion
	}
}