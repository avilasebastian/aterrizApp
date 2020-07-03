package ui.ventanas

import dominio.elementos.Asiento
import dominio.elementos.Vuelo
import extensiones.LocalDateTimeTransformer
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.CheckBox
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import ui.modelos.ModeloVuelo
import dominio.elementos.Usuario
import dominio.repositorios.RepoUsuario
import org.uqbar.commons.applicationContext.ApplicationContext

class VuelosVentana extends SimpleWindow<ModeloVuelo> {
	var HorizontalLayout horizontalLayout = new HorizontalLayout
	var VerticalLayout verticalLayout = new VerticalLayout

	new(WindowOwner parent) {
		super(parent, new ModeloVuelo())
		this.title = "Vuelos"
	}

	override void createFormPanel(Panel mainPanel) {
		createEncabezado(mainPanel)
		createTablaDeVuelos(mainPanel)
		createTablaDeAsientos(mainPanel)
	}

	def void createEncabezado(Panel mainPanel) {
		new Label(mainPanel).setText("Busqueda de Vuelo").alignLeft

		new Panel(mainPanel) => [
			it.layout = horizontalLayout

			new Panel(it) => [
				new Panel(it) => [
					it.layout = horizontalLayout

					new Label(it) => [
						it.text = "Origen: "
						it.alignLeft
						it.width = 60
					]

					new TextBox(it) => [
						it.width = 150
						it.alignLeft
						it.bindValueToProperty("datosDeBusqueda.origen")
					]

					new Label(it) => [
						it.text = "Destino: "
						it.alignLeft
						it.width = 60
					]

					new TextBox(it) => [
						it.width = 150
						it.alignLeft
						it.bindValueToProperty("datosDeBusqueda.destino")
					]
				]

				new Panel(it) => [
					it.layout = horizontalLayout

					new Label(it) => [
						it.text = "Desde: "
						it.alignLeft
						it.width = 60
					]

					new TextBox(it) => [
						it.width = 150
						it.alignLeft
						it.bindValueToProperty("datosDeBusqueda.fechaDesde").setTransformer(
							new LocalDateTimeTransformer(LocalDateTime.of(1900, 01, 01, 00, 0, 0))
						)
					]

					new Label(it) => [
						it.text = "Hasta: "
						it.alignLeft
						it.width = 60
					]

					new TextBox(it) => [
						it.width = 150
						it.alignLeft
						it.bindValueToProperty("datosDeBusqueda.fechaHasta").setTransformer(
							new LocalDateTimeTransformer(LocalDateTime.of(2079, 06, 06, 00, 0, 0))
						)
					]
				]
			]

			new Panel(it) => [
				new Panel(it) => [
					it.layout = horizontalLayout

					new Label(it) => [
						it.text = "Clase: "
						it.alignLeft
						it.width = 60
					]

					new Selector<String>(it) => [
						it.bindItemsToProperty("listaDeClases")
						it.bindValueToProperty("datosDeBusqueda.clase")
						it.allowNull = false
						it.width = 100
					]
				]

				new Panel(it) => [
					it.layout = horizontalLayout

					new CheckBox(it).bindValueToProperty("datosDeBusqueda.ventanilla")
					new Label(it).text = "Ventanilla "
					new Label(it).text = "Ventanilla "
				]
			]

			new Panel(it) => [
				new Button(it) => [
					it.caption = "Buscar"
					it.setWidth = 150
					it.onClick [
						this.modelObject.buscar()
						this.modelObject.notificacion(this)
					]
				]

				new Button(it) => [
					it.caption = "Limpiar Campos"
					it.setWidth = 150
					it.onClick [
						this.modelObject.limpiarCampos()
					]
				]
			]
		]
	}

	def void createTablaDeVuelos(Panel mainPanel) {
		new Panel(mainPanel) => [
			new Table<Vuelo>(it, Vuelo) => [
				it.bindItemsToProperty("listaDeVuelos")
				it.bindValueToProperty("vueloSeleccionado")
				it.numberVisibleRows = 6

				new Column<Vuelo>(it) => [
					it.title = "Origen"
					it.fixedSize = 115
					it.bindContentsToProperty("ciudadOrigen")
				]

				new Column<Vuelo>(it) => [
					it.title = "Destino"
					it.fixedSize = 115
					it.bindContentsToProperty("ciudadDestino")
				]

				new Column<Vuelo>(it) => [
					it.title = "Aerolinea"
					it.fixedSize = 115
					it.bindContentsToProperty("aerolinea")
				]

				new Column<Vuelo>(it) => [
					val pattern = DateTimeFormatter.ofPattern("dd/MM/uuuu - hh:mm")

					it.title = "Salida"
					it.fixedSize = 115
					it.bindContentsToProperty("partida").transformer = [
						LocalDateTime partida | partida.format(pattern)
					]
				]

				new Column<Vuelo>(it) => [
					it.title = "Escala"
					it.fixedSize = 115
					it.bindContentsToProperty("escalas")
				]

				new Column<Vuelo>(it) => [
					it.title = "Duraci\u00f3n"
					it.fixedSize = 115
					it.bindContentsToProperty("horasDeVuelo")
				]

				new Column<Vuelo>(it) => [
					it.title = "Monto"
					it.fixedSize = 115
					it.bindContentsToProperty("precio")
				]
			]
		]
	}

	def void createTablaDeAsientos(Panel mainPanel) {
		new Label(mainPanel) => [
			it.text = "Selecci\u00f3n de Asiento"
			it.alignLeft
		]

		new Panel(mainPanel) => [
			new Table<Asiento>(it, Asiento) => [
				it.bindItemsToProperty("listaDeAsientos")
				it.bindValueToProperty("asientoSeleccionado")
				it.numberVisibleRows = 6

				new Column<Asiento>(it) => [
					it.title = "Clase"
					it.fixedSize = 200
					it.bindContentsToProperty("clase")
				]

				new Column<Asiento>(it) => [
					it.title = "N\u00famero"
					it.fixedSize = 200
					it.bindContentsToProperty("numeroAsiento")
				]

				new Column<Asiento>(it) => [
					it.title = "Ventanilla"
					it.fixedSize = 200
					it.bindContentsToProperty("ventanilla").transformer = [
						Boolean ventanilla | if(ventanilla) "SI" else "NO"
					]
				]

				new Column<Asiento>(it) => [
					it.title = "Precio"
					it.fixedSize = 200
					it.bindContentsToProperty("precioTotal")
				]
			]
		]
	}

	override protected addActions(Panel actionsPanel) {
		actionsPanel.layout = verticalLayout

		new Button(actionsPanel) => [
			it.caption = "Agregar al carrito"
			it.setWidth = 820
			it.bindEnabled(new NotNullObservable("asientoSeleccionado"))
			it.onClick [
				this.modelObject.agregarAlCarrito()
			]
		]

		new Panel(actionsPanel) => [
			it.layout = horizontalLayout
			new Panel(it) => [
				new Panel(it) => [
					it.layout = horizontalLayout

					new Label(it).text = "Item(s) en el carrito: "

					new Label(it) => [
						it.width = 50
						it.alignLeft
						it.bindValueToProperty("cantidadDeItems")
					]
				]

				new Panel(it) => [
					it.layout = horizontalLayout

					new Label(it).text = "Total en el carrito: $ "

					new Label(it) => [
						it.width = 50
						it.alignLeft
						it.bindValueToProperty("totalEnElCarrito")
					]
				]
			]

			new Panel(it) => [
				new Label(it).setText("")

				new Panel(it) => [
					it.layout = horizontalLayout

					new Label(it).setText("").setWidth(295)

					new Button(it) => [
						it.caption = "Perfil"
						it.setWidth = 150
						it.onClick [
							new PerfilVentana(this).open
							this.actualizarUsuario
						]
					]

					new Button(it) => [
						it.caption = "Finalizar compra"
						it.setWidth = 150
						it.onClick [
							new CarritoVentana(this).open
							this.modelObject.actualizarTablas()
							this.modelObject.actualizarCampoCarrito()
						]
					]
				]
			]
		]
	}
	
	private def void actualizarUsuario() {
		var Usuario unUsuario = ApplicationContext.instance.getSingleton(Usuario)
		var RepoUsuario repoUsuario = ApplicationContext.instance.getSingleton(RepoUsuario)
		repoUsuario.actualizar(unUsuario)
	}
}
