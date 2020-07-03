package ui.ventanas

import dominio.elementos.Pasaje
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import ui.modelos.ModeloCarrito

class CarritoVentana extends SimpleWindow<ModeloCarrito> {
	var HorizontalLayout horizontalLayout = new HorizontalLayout

	new(WindowOwner owner) {
		super(owner, new ModeloCarrito)
	}
	
	override protected createFormPanel(Panel mainPanel) {
		new Label(mainPanel).setText("Carrito de compras").alignLeft

		new Panel(mainPanel) => [
			new Table<Pasaje>(it, Pasaje) => [
				it.bindItemsToProperty("listaCarrito")
				it.bindValueToProperty("pasajeSeleccionado")
				it.numberVisibleRows = 5

				new Column<Pasaje>(it) => [
					it.title = "Origen"
					it.fixedSize = 128
					it.bindContentsToProperty("ciudadOrigen")
				]
				
				new Column<Pasaje>(it) => [
					it.title = "Destino"
					it.fixedSize = 128
					it.bindContentsToProperty("ciudadDestino")
				]
				
				new Column<Pasaje>(it) => [
					val pattern = DateTimeFormatter.ofPattern("dd/MM/uuuu - hh:mm")

					it.title = "Salida"
					it.fixedSize = 128
					it.bindContentsToProperty("partida").transformer = [
						LocalDateTime recibe | recibe.format(pattern)
					]
				]
				
				new Column<Pasaje>(it) => [
					it.title = "Aerolinea"
					it.fixedSize = 128
					it.bindContentsToProperty("aerolinea")
				]

				new Column<Pasaje>(it) => [
					it.title = "Asiento"
					it.fixedSize = 128
					it.bindContentsToProperty("id.numeroAsiento")
				]
				
				new Column<Pasaje>(it) => [
					it.title = "Clase"
					it.fixedSize = 128
					it.bindContentsToProperty("clase")
				]
				
				new Column<Pasaje>(it) => [
					it.title = "Precio"
					it.fixedSize = 128
					it.bindContentsToProperty("precio")
				]
			]
		]
	}

	override protected addActions(Panel actionsPanel) {
		new Panel(actionsPanel) => [
			layout = new ColumnLayout(3)

			new Panel(it) => [
				new Panel(it) => [
					layout = horizontalLayout
					new Label(it) => [
						it.text = "Total en el carrito: $"
						it.alignLeft

					]
					
					new Label(it) => [
						it.alignLeft
						it.bindValueToProperty("totalEnElCarrito")
					]
					
				]
				
				new Panel(it) => [
					layout = horizontalLayout
					
					new Button(it) => [
						it.caption = "Volver"
						it.setWidth = 90
						onClick[close]
					]
					
					new Button(it) => [
						it.caption = "Comprar"
						it.setWidth = 90
						onClick[
							this.modelObject.comprar()
						]
					]
				]
			]

			new Label(it).text = " "

			new Panel(it) => [
				layout = horizontalLayout

				new Button(it) => [
					it.caption = "Limpiar carrito"
					it.setWidth = 150
					onClick[
						this.modelObject.limpiarCarrito()
					]
				]

				new Button(it) => [
					it.caption = "Eliminar"
					it.setWidth = 80
					it.bindEnabled(new NotNullObservable("pasajeSeleccionado"))
					onClick[
						this.modelObject.eliminarUnPasajeDelCarrito()
					]
				]
			]
		]
	}
}
