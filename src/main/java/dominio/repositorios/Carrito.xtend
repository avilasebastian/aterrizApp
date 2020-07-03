package dominio.repositorios

import dominio.elementos.Pasaje
import dominio.elementos.Usuario
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException
import redis.clients.jedis.JedisPool
import redis.clients.jedis.JedisPoolConfig
import redis.clients.jedis.Jedis
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.core.type.TypeReference
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule


@Accessors @Observable
class Carrito {
	var JedisPool jedisPool
    var Usuario usuario
	
	new(Usuario usuario) {
		jedisPool = new JedisPool(new JedisPoolConfig, "localhost")
		this.usuario = usuario
	}
	
	def void agregar(Pasaje pasaje) {
		var Jedis jedis = jedisPool.resource
//		if(jedis.exists(usuario.id_HDB.toString)==1){
//			this.validacionDeCargaDeCarrito(pasaje)
//		}
		this.validacionDeCargaDeCarrito(pasaje)
		jedis.expire(usuario.id_HDB.toString,300)	
		jedis.sadd(usuario.id_HDB.toString, convertirAJson(pasaje))	
	}

	private def void validacionDeCargaDeCarrito(Pasaje pasaje) {
		if (pasajeReservado(pasaje)) {
			throw new UserException("El pasaje ya est\u00e1 en el carrito")
		}
	}

	private def Boolean pasajeReservado(Pasaje pasaje) {
		lista.exists[it.id.numeroAsiento.equals(pasaje.id.numeroAsiento)]
	}

	def void quitar(Pasaje pasaje) {
		var Jedis jedis = jedisPool.resource
		jedis.srem(usuario.id_HDB.toString, convertirAJson(pasaje))	
		jedis.close	
	}

	def Set<Pasaje> getLista() {
		var String jsonArray
		var Jedis jedis = jedisPool.resource
		
		jsonArray = jedis.smembers(usuario.id_HDB.toString).toString
		jedis.close
		
		return this.desdeJson(jsonArray)
	}

	def Integer cantidadDeItems() {
		var Jedis jedis = jedisPool.resource
		var Long cantidad = jedis.scard(usuario.id_HDB.toString)
		jedis.close

		return cantidad.intValue
	}

	def Double totalEnElCarrito() {
		lista.fold(0.0, [sum, pasaje|sum + pasaje.precio])
	}

	def void asientoCompra( RepoVuelos repoV, RepoUsuario repoU) {
		lista.forEach[usuario.reservar(it); repoV.reservar(it)]
		repoU.actualizar(usuario)
		limpiar()	
	}

	def void limpiar() {
		var Jedis jedis = jedisPool.resource
		jedis.del(usuario.id_HDB.toString)
	}

	private def Set<Pasaje> desdeJson(String json) {
		var ObjectMapper mapper = new ObjectMapper	
		mapper.registerModule(new JavaTimeModule)
		return mapper.readValue(json, new TypeReference<Set<Pasaje>>() {})
	}
	
	def String convertirAJson(Pasaje pasaje){
		var ObjectMapper mapper= new ObjectMapper()
		mapper.registerModule(new JavaTimeModule())	
		mapper.writeValueAsString(pasaje)
	}
}