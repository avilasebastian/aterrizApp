package ui.ventanas

import dominio.elementos.Usuario
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import ui.modelos.ModeloPerfil

class TablaAmigosVentana extends Dialog<ModeloPerfil> {
	new(WindowOwner parent) {
		super(parent, new ModeloPerfil())
		title = "Tabla de amigos"
	}

	override protected createFormPanel(Panel mainPanel) {
		new Panel(mainPanel) => [

			new Table<Usuario>(it, Usuario) => [
				it.bindItemsToProperty("listaDeUsuarioss")
				it.bindValueToProperty("usuarioSeleccionado")
				it.numberVisibleRows = 10

				new Column<Usuario>(it) => [
					it.title = "Nombre"
					it.fixedSize = 100
					it.bindContentsToProperty("nombre")
				]

				new Column<Usuario>(it) => [
					it.title = "Apellido"
					it.fixedSize = 100
					it.bindContentsToProperty("apellido")
				]
			]

		]

		new Panel(mainPanel) => [
			it.layout = new HorizontalLayout

			new Button(it) => [
				it.caption = "Aceptar"
				it.setWidth = 90
				it.bindEnabled(
					new NotNullObservable("usuarioSeleccionado")
				)
				it.onClick[
					this.modelObject.agregar
					accept
				]
			]

			new Button(it) => [
				it.caption = "Cancelar"
				it.setWidth = 90
				it.onClick[close]
			]
		]
	}
}
