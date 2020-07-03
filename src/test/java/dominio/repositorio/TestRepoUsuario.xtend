package dominio.repositorio

import dominio.elementos.Usuario
import dominio.repositorios.RepoUsuario
import java.util.List
import javax.persistence.EntityManager
import javax.persistence.EntityManagerFactory
import javax.persistence.Persistence
import javax.persistence.PersistenceException
import org.apache.commons.lang.builder.EqualsBuilder
import org.hibernate.service.spi.ServiceException
import org.junit.jupiter.api.AfterAll
import org.junit.jupiter.api.Assertions
import org.junit.jupiter.api.BeforeAll
import org.junit.jupiter.api.Test
import org.uqbar.commons.model.exceptions.UserException

class TestRepoUsuario {
	static var List<Usuario> usuarios = newArrayList
	static var RepoUsuario repo
	static var EntityManagerFactory entityManagerFactory
	static var EntityManager entityManager

	@BeforeAll
	static def void init() {
		try {
			entityManagerFactory = Persistence.createEntityManagerFactory("AterrizApp")
			entityManager = entityManagerFactory.createEntityManager
		} catch (ServiceException e) {
			println('''
				
				Por favor en su base de datos escriba, pues la base de datos parece que no existe,
				DROP DATABASE IF EXISTS `aterrizAppTest`;
				CREATE DATABASE  IF NOT EXISTS `aterrizAppTest` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_esperanto_ci */;
				USE `aterrizAppTest`;
				
			''')
		}

		repo = new RepoUsuario(entityManager)

		(0 .. 2).forEach [ i |
			usuarios.add(new Usuario() => [
				it.usuarioNombre = "usuarioNombre_" + i
				it.clave = "XYZ_" + i
			])
		]

		entityManager => [
			transaction.begin
			usuarios.forEach[u|u.id_HDB = merge(u).id_HDB]
			transaction.commit
		]
	}

	@AfterAll
	static def void end() {
		try {
			entityManager => [
				transaction.begin
				usuarios.forEach[u | remove(find(Usuario, u.id_HDB))]
				transaction.commit
			]
		} catch (PersistenceException e) {
			entityManager.transaction.rollback
			throw new RuntimeException(e)
		} finally {
			entityManager.close
			entityManagerFactory.close
		}
	}

	@Test
	def void test_buscandoUsuarioEnRepo() {
		var Usuario usuario1 = repo.buscarPor("usuarioNombre_1", "XYZ_1")
		var Usuario usuario2 = usuarios.get(1)

		Assertions.assertTrue(EqualsBuilder.reflectionEquals(usuario1, usuario2))
	}

	@Test
	def void test_test_buscandoUsuarioEnRepo_usuarioInexistente() {
		Assertions.assertThrows(UserException, [repo.buscarPor("NoUsuario", "12345")])
	}

	@Test
	def void test_test_buscandoUsuarioEnRepo_sinIngresoDeCampoNombreUsuario() {
		Assertions.assertThrows(UserException, [repo.buscarPor("", "12345")])
	}

	@Test
	def void test_test_buscandoUsuarioEnRepo_sinIngresoDeCampoClave() {
		Assertions.assertThrows(UserException, [repo.buscarPor("usuarioNombre_1", "")])
	}

	@Test
	def void test_test_buscandoUsuarioEnRepo_sinIngresoDeCampoNombreUsuarioYClave() {
		Assertions.assertThrows(UserException, [repo.buscarPor("", "")])
	}
}