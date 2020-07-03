package dominio.repositorios

import java.util.List

interface Repo <T> {
	def void crear(T objeto)
	def void actualizar(T objeto)

	def List<T> buscarTodo()
}