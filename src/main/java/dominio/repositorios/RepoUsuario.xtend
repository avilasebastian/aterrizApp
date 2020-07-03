package dominio.repositorios

import dominio.elementos.Usuario
import java.util.List
import java.util.Set
import javax.persistence.EntityManager
import javax.persistence.NoResultException
import javax.persistence.PersistenceException
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Predicate
import javax.persistence.criteria.Root
import org.hibernate.HibernateException
import org.uqbar.commons.model.exceptions.UserException

class RepoUsuario implements Repo<Usuario> {
	var EntityManager entityManager
	var CriteriaBuilder criteria

	new(EntityManager entityManager) {
		this.entityManager = entityManager
		this.criteria = entityManager.criteriaBuilder
	}

	override void crear(Usuario usuario) {
		try {
			entityManager => [
				transaction.begin
				persist(usuario)
				transaction.commit
			]
		} catch (PersistenceException e) {
			e.printStackTrace
			entityManager.transaction.rollback
			throw new RuntimeException(
				"Ha ocurrido un error. La operación no puede completarse.",
				e
			)
		}
	}

	override void actualizar(Usuario usuario) {
		try {
			entityManager => [
				transaction.begin
				merge(usuario)
				transaction.commit
			]
		} catch (PersistenceException e) {
			e.printStackTrace
			entityManager.transaction.rollback
			throw new RuntimeException(
				"Ha ocurrido un error. La operaci\u00f3n no puede completarse.",
				e
			)
		}
	}

	override List<Usuario> buscarTodo() {
		val CriteriaQuery<Usuario> query = criteria.createQuery(Usuario)
		val Root<Usuario> from = query.from(Usuario)

		return entityManager.createQuery(query.select(from)).resultList
	}

	def Usuario buscarPor(String nombreUsuario, String clave) {
		val CriteriaQuery<Usuario> query = criteria.createQuery(Usuario)
		val Root<Usuario> from = query.from(Usuario)

		try {
			query.where(
				criteria.equal(from.get("usuarioNombre"), nombreUsuario),
				criteria.equal(from.get("clave"), clave)
			)
			return entityManager.createQuery(query).singleResult
		} catch (NoResultException e) {
			throw new UserException("Usuario o contrase\u00f1a incorrecta")
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		}
	}

	def Set<Usuario> listaDeCandidatos(Usuario usuario) {
		val CriteriaQuery<Usuario> query = criteria.createQuery(Usuario)
		val Root<Usuario> from = query.from(Usuario)
		val List<Predicate> condiciones = newArrayList

		try {
			query.select(from)
			condiciones.add(criteria.notEqual(from.get("id_HDB"), usuario.id_HDB))

			if (!usuario.amigos.isEmpty) {
				condiciones.add(criteria.not(from.in(usuario.amigos)))
			}

			entityManager.createQuery(query.where(condiciones)).resultList.toSet
		} catch (NoResultException e) {
			throw new UserException("Usuario o contrase\u00f1a incorrecta")
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		}
	}
}
