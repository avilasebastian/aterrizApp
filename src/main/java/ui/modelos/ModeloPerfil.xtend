package ui.modelos
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import org.eclipse.xtend.lib.annotations.Accessors
import dominio.elementos.Usuario
import dominio.repositorios.RepoUsuario
import org.uqbar.commons.applicationContext.ApplicationContext
import java.util.Set
import dominio.elementos.Pasaje
import org.uqbar.commons.model.annotations.Dependencies
import static extension org.uqbar.commons.model.utils.ObservableUtils.firePropertyChanged
import org.uqbar.commons.model.exceptions.UserException
import dominio.repositorios.Historial
import dominio.elementos.DatosDeBusqueda
import java.util.List

@Accessors
@TransactionalAndObservable
class ModeloPerfil  {
	var Usuario unUsuario 
	var RepoUsuario repoUsuario

	var String nombre
	var Usuario usuarioSeleccionado
	var Set<Pasaje> listaDeVuelos = newHashSet
	
	var Set<Usuario> listaDeAmigos = newHashSet
	var Set<Usuario> listaDeUsuarios  = newHashSet

	var Set<Usuario>  listaEliminados = newHashSet
	var Set<Usuario>  listaAgregados = newHashSet
	
	var Double saldoAgregado = 0.0
	
	var Historial historial_
	var List<DatosDeBusqueda> historial = newArrayList
	
	new(){
		unUsuario = ApplicationContext.instance.getSingleton(Usuario)
		repoUsuario = ApplicationContext.instance.getSingleton(RepoUsuario)
			
		listaDeAmigos = this.unUsuario.amigos
		listaDeVuelos = this.unUsuario.getReservas
		listaDeUsuarios = this.repoUsuario.listaDeCandidatos(unUsuario)
		
		historial_ = ApplicationContext.instance.getSingleton(Historial)
		historial = historial_.get(unUsuario.id_HDB)
	}

	
	def String getNombreYApellido(){
		unUsuario.nombre+" "+unUsuario.apellido
	}

	def void agregar(){              // pierde------------>gana
		swapping(usuarioSeleccionado,listaDeUsuarios,listaDeAmigos)
	}
	
	def void getQuitar(){		           // pierde------------>gana
		swapping(usuarioSeleccionado,listaDeAmigos,listaDeUsuarios)
		this.firePropertyChanged("listaDeAmigos")
		repoUsuario.actualizar(unUsuario)
	}

	def void agregarSaldo(){
		validarSaldoVentana
		unUsuario.saldo = unUsuario.saldo + saldoAgregado
	}
	
	def void swapping(Usuario user, Set<Usuario> listaCation, Set<Usuario> listaAnion){
		listaAnion.add(user)
		listaCation.remove(user)
	}
	
	@Dependencies("listaDeAmigos")
	def Set<Usuario> getListaDeUsuarioss(){
		repoUsuario.listaDeCandidatos(unUsuario)
	}
	
	def void actualizarLista() {
		this.firePropertyChanged("listaDeAmigos")
	}
	
	def validarSaldoVentana(){
		if(saldoAgregado === null){
			throw new UserException("El campo no puede quedar vacio")
		}
		if(saldoAgregado < 0){
			throw new UserException("Debe ingresar un numero positivo")
		}
	}
	
	def void actualizar() {
		repoUsuario.actualizar(unUsuario)
	}

}
