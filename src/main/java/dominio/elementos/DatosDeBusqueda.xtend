package dominio.elementos

import java.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.bson.types.ObjectId
import org.mongodb.morphia.annotations.Id
import org.mongodb.morphia.annotations.Entity
import org.mongodb.morphia.annotations.Property

@Accessors @Observable @Entity("Historial")
class DatosDeBusqueda {
	@Id var ObjectId id_MDB
	@Property("Usuario_idUsuario") var Long idUsuario
	var LocalDateTime horaDemuestra

	var String origen
	var String destino
	var LocalDateTime fechaDesde
	var LocalDateTime fechaHasta
	var String clase
	var Boolean ventanilla
	
	new (){}
	new(Long idUsuario) {
		this.idUsuario = idUsuario
		this.limpiarCampos()
	}

	def void limpiarCampos() {
		origen = ""
		destino = ""
		
		// SQL Server (es el que tiene el rango más pequeño)
		fechaDesde = LocalDateTime.of(1900, 01, 01, 00, 0, 0)
		fechaHasta = LocalDateTime.of(2079, 06, 06, 00, 0, 0)
		
		clase = ""
		ventanilla = false
	}

	def DatosDeBusqueda copia() {
		new DatosDeBusqueda(this.idUsuario) => [
			it.setId_MDB(this.getId_MDB())
			it.setHoraDemuestra(LocalDateTime.now)

			it.setOrigen(this.getOrigen())
			it.setDestino(this.getDestino())
			it.setFechaDesde(this.getFechaDesde())
			it.setFechaHasta(this.getFechaHasta)
			it.setClase(this.getClase)
			it.setVentanilla(this.getVentanilla())	
		]
	}
}