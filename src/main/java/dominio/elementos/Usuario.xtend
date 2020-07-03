package dominio.elementos

import java.util.Set
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.ForeignKey
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.JoinColumn
import javax.persistence.JoinTable
import javax.persistence.ManyToMany
import javax.persistence.OneToMany
import javax.persistence.Table
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import org.uqbar.commons.model.exceptions.UserException
import java.time.LocalDateTime

@Accessors @TransactionalAndObservable
@Entity @Table(name="USUARIO")
class Usuario {
	@Id @GeneratedValue
	@Column(name="idUsuario") var Long id_HDB

	@Column(length=45) var String nombre
	@Column(length=45) var String apellido
	@Column(length=45) var String usuarioNombre
	@Column(length=45) var String clave
	@Column(length=45) var String imagen

	var Integer edad
	var Double saldo

	@ManyToMany
	@JoinTable(
		joinColumns=@JoinColumn(
			name="Usuario_idUsuario",
			referencedColumnName="idUsuario",
			foreignKey=@ForeignKey(
				name="fk_Usuario_idUsuario_idx"
			)
		),
		inverseJoinColumns=@JoinColumn(
			name="Otro_Usuario_idUsuario",
			referencedColumnName="idUsuario",
			foreignKey=@ForeignKey(
				name="fk_Otro_Usuario_idUsuario_idx"
			)
		)
	)
	var Set<Usuario> amigos = newHashSet

	@OneToMany(
		cascade=#[
			CascadeType.PERSIST,
			CascadeType.MERGE
		]
	)
	@JoinColumn(
		name="Usuario_idUsuario",
		referencedColumnName="idUsuario",
		foreignKey=@ForeignKey(
			name="fk_Pasaje_Usuario_idx"
		),
		nullable=false
	)
	var Set<Pasaje> reservas = newHashSet

	def void agregarAmigo(Usuario amigo) {
		if(!this.equals(amigo)) amigos.add(amigo)
	}

	def void quitarAmigo(Usuario amigo) {
		amigos.remove(amigo)
	}

	def Set<Usuario> getAmigos() {
		amigos
	}

	def void reservar(Pasaje pasaje) {		
		restarSaldo(pasaje)
		pasaje.setFechaDeCompra(LocalDateTime.now)
		reservas.add(pasaje)
	}

	def void cancelarReserva(Pasaje pasaje) {
		reservas.remove(pasaje)
	}

	def Set<Pasaje> getReservas() {
		reservas
	}

	def String getPathImagen() {
		"imagenes/" + imagen + ".jpg"
	}

	private def restarSaldo(Pasaje pasaje) {
		saldo = saldo - pasaje.precio
	}

	def validarSaldo(Double totalEnCarrito) {
		if (saldo < totalEnCarrito) {
			throw new UserException("Saldo insuficiente")
		}
	}

	def validarClave() {
		if (clave.equals("")) {
			throw new UserException("Debe ingresar una clave validad")
		}
	}
}