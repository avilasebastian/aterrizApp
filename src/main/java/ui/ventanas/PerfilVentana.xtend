package ui.ventanas

import dominio.elementos.Pasaje
import dominio.elementos.Usuario
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.bindings.ObservableProperty
import org.uqbar.arena.graphics.Image
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.PasswordField
import org.uqbar.arena.widgets.Spinner
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.WindowOwner
import ui.modelos.ModeloPerfil


class PerfilVentana extends TransactionalDialog<ModeloPerfil> {

	new(WindowOwner parent) {
		super(parent, new ModeloPerfil())
		title="Perfil"
	}
	
	override protected addActions(Panel actionsPanel) {
	}
	
	override protected createFormPanel(Panel mainPanel) {
		new Panel(mainPanel)=>[
			layout=new HorizontalLayout

			new Label(it) => [
				it.bindImageToProperty("unUsuario.pathImagen", [ imagePath |
					new Image(imagePath) => [size(200, 300)]
				])
			]
			new Panel(it)=>[
				new Label(it)=>[
					it.bindValueToProperty("nombreYApellido")
				]
							
				
				createFormulario(it)			
				creatTablasDeAmigos(it)
				
			]
		]
		
		new Panel(mainPanel)=>[
			new Label(it)=>[
				it.text="Pasajes comprados"
				it.alignLeft
			]
		
			
			new Table<Pasaje>(it, Pasaje)=>[
				it.bindItemsToProperty("listaDeVuelos")
				it.numberVisibleRows = 5


				new Column<Pasaje>(it) => [
					it.title = "Origen"
					it.fixedSize = 100
					it.bindContentsToProperty("ciudadOrigen")
				]
				new Column<Pasaje>(it) => [
					it.title = "Destino"
					it.fixedSize = 100
					it.bindContentsToProperty("ciudadDestino")
				]
				new Column<Pasaje>(it) => [
					it.title = "Salida"
					it.fixedSize = 100
					it.bindContentsToProperty("partida").transformer = [ LocalDateTime recibe |
						recibe.format(formatoDeFecha)
					]
				]
				new Column<Pasaje>(it) => [
					it.title = "Comprado"
					it.fixedSize = 100
					it.bindContentsToProperty("fechaDeCompra").transformer = [ LocalDateTime recibe |
						recibe.format(formatoDeFecha)
					]
				]
				new Column<Pasaje>(it) => [
					it.title = "Aerolinea"
					it.fixedSize = 100
					it.bindContentsToProperty("aerolinea")
				]
				new Column<Pasaje>(it) => [
					it.title = "Precio"
					it.fixedSize = 100
					it.bindContentsToProperty("precio")
				]	
			]
			
			new Panel(it)=>[
				layout=new HorizontalLayout
				new Button(it)=>[
						it.caption = "Aceptar"
						it.setWidth = 100
						it.onClick[
							this.modelObject.unUsuario.validarClave
							this.modelObject.actualizar
							accept
						]
				]
				new Button(it)=>[
						it.caption = "Cancelar"
						it.setWidth = 100
						it.onClick[
							close
						] 	
				]
			]
		]
	}
	
	
	
	def createFormulario(Panel panel) {

				new Panel(panel)=>[
					layout=new HorizontalLayout
					new Label(it)=>[
						it.text= "Contrase\u00f1a"
						it.setWidth = 100
						it.alignLeft
					]
					new PasswordField(it)=>[
						it.width = 210
						it.bindValueToProperty("unUsuario.clave")
					]
					
				]
				new Panel(panel)=>[
					layout=new HorizontalLayout
					new Label(it)=>[
						it.text= "Edad"
						it.setWidth = 100
						it.alignLeft
					]
					
					new Spinner(it) => [
						it.minimumValue = 18
						it.maximumValue = 120
						it.width = 190
						it.bindValue(new ObservableProperty("unUsuario.edad"))
					]
				
				]
				new Panel(panel)=>[
					layout=new HorizontalLayout
					new Label(it)=>[
						it.text="Saldo: $"
						it.width = 100
						it.alignLeft
					]
					new  Label(it)=>[
						it.width = 110
						it.bindValueToProperty("unUsuario.saldo")
						it.alignLeft
					]
					new Button(it)=>[
						it.caption = "Agregar saldo"
						it.setWidth = 110
						onClick[new SaldoVentana(this).open]
					]
				]
	}
	
	def creatTablasDeAmigos(Panel mainPanel) {
		new Panel(mainPanel)=>[
			new Label(it)=>[
				it.text="Amigos"
				it.alignLeft
			]
		
			
			new Table<Usuario>(it, Usuario)=>[
				it.bindItemsToProperty("listaDeAmigos")
				it.bindValueToProperty("usuarioSeleccionado")
				it.numberVisibleRows = 5


				new Column<Usuario>(it) => [
					it.title = "Nombre"
					it.fixedSize = 150
					it.bindContentsToProperty("nombre")
				]
				new Column<Usuario>(it) => [
					it.title = "Apellido"
					it.fixedSize = 150
					it.bindContentsToProperty("apellido")
				]
				new Column<Usuario>(it) => [
					it.title = "Edad"
					it.fixedSize = 90
					it.alignCenter
					it.bindContentsToProperty("edad")
				]
			]
			
			new Panel(it)=>[
				val seleccionado = new NotNullObservable("usuarioSeleccionado")
				layout=new ColumnLayout(4)
				new Button(it)=>[
					it.caption = "Ver historial"
					it.setWidth = 100
					onClick[
						new HistorialVentana(this).open

					]
				]
				
				new Label(it)=>[
					it.text=" "
				]
				new Button(it)=>[
					it.caption = "Agregar amigo"
					it.setWidth = 100
					onClick[
						new TablaAmigosVentana(this).open
						this.modelObject.actualizarLista
					]
				]
				new Button(it)=>[
					it.caption = "Quitar amigo"
					it.setWidth = 100
					it.bindEnabled(seleccionado)
					onClick[this.modelObject.getQuitar()]
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