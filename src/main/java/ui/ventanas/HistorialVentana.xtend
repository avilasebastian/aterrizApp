package ui.ventanas


import ui.modelos.ModeloPerfil
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.widgets.tables.Column
import dominio.elementos.DatosDeBusqueda
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter
import org.uqbar.arena.widgets.Button

class HistorialVentana extends Dialog<ModeloPerfil>{
	
	new(WindowOwner parent) {
		super(parent, new ModeloPerfil())
		title="Historial de Busquedas"
	}
	override protected createFormPanel(Panel mainPanel) {
		creatTablasDeBusquedas(mainPanel)
		new Label(mainPanel)=>[
					it.text=" "
				]
		new Button(mainPanel)=>[
						it.caption = "Cerrar"
						it.setWidth = 100
						it.onClick[
							close
						] 	
				]
	}
	
	def creatTablasDeBusquedas(Panel mainPanel) {
		new Panel(mainPanel)=>[
			new Label(it)=>[
				it.text="Historial"
				it.alignLeft
			]
		
			
			new Table<DatosDeBusqueda>(it, DatosDeBusqueda)=>[
				it.bindItemsToProperty("historial")
				it.numberVisibleRows = 6


				new Column<DatosDeBusqueda>(it) => [
					it.title = "Origen"
					it.fixedSize = 150
					it.bindContentsToProperty("origen")
				]
				new Column<DatosDeBusqueda>(it) => [
					it.title = "Destino"
					it.fixedSize = 150
					it.bindContentsToProperty("destino")
				]
				new Column<DatosDeBusqueda>(it) => [
					it.title = "Fecha desde"
					it.fixedSize = 90
					it.alignCenter
					it.bindContentsToProperty("fechaDesde").transformer = [ LocalDateTime recibe |
						recibe.format(formatoDeFecha)
					]
				]
				new Column<DatosDeBusqueda>(it) => [
					it.title = "Fecha hasta"
					it.fixedSize = 90
					it.alignCenter
					it.bindContentsToProperty("fechaHasta").transformer = [ LocalDateTime recibe |
						recibe.format(formatoDeFecha)
					]
				]
				new Column<DatosDeBusqueda>(it) => [
					it.title = "Ventanilla"
					it.fixedSize = 90
					it.alignCenter
					it.bindContentsToProperty("ventanilla").transformer = [
						Boolean ventanilla | if(ventanilla) "SI" else "NO"
					]
				]
				new Column<DatosDeBusqueda>(it) => [
					it.title = "Clase"
					it.fixedSize = 90
					it.alignCenter
					it.bindContentsToProperty("clase")
				]
			]
	
			]
			
	}
	
	
	def DateTimeFormatter formatoDeFecha() {
		var String pattern = "dd/MM/uuuu hh:mm"
		var DateTimeFormatter formatter = DateTimeFormatter.ofPattern(pattern)
		formatter
	}
}