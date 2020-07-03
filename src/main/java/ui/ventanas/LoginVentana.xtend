package ui.ventanas

import org.uqbar.arena.graphics.Image
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.PasswordField
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import ui.modelos.ModeloLogin

class LoginVentana extends SimpleWindow<ModeloLogin> {
	new(WindowOwner owner) {
		super(owner, new ModeloLogin())
		title = "AterrizarApp"
	}

	override void createMainTemplate(Panel mainPanel) {
		this.createFormPanel(mainPanel)
		this.createActionsPanel(mainPanel)
	}

	override protected addActions(Panel actionsPanel) {
		new Label(actionsPanel).setWidth = 75
				
		new Button(actionsPanel) => [
			it.caption = "Entrar"
			it.setWidth = 150
			onClick[
				modelObject.loginDeUsuario()
				new VuelosVentana(this).open
			]
		]

		new Label(actionsPanel).setWidth = 75
	}
	
	override protected createFormPanel(Panel mainPanel) {
		new Label(mainPanel) => [
			it.bindImageToProperty("pathImagen", [ imagePath |
				new Image(imagePath) => [size(300, 90)]
			])
		]
		
		new Panel(mainPanel) => [
			layout = new HorizontalLayout
			new Label(it) => [
				it.text = "Usuario: "
				it.alignLeft
				it.width = 80
			]

			new TextBox(it) => [
				it.width = 190
				it.alignLeft
				it.bindValueToProperty("nombre")
			]
		]

		new Panel(mainPanel) => [
			layout = new HorizontalLayout
			new Label(it) => [
				it.text = "Contrase\u00f1a: "
				it.alignLeft
				it.width = 80
			]

			new PasswordField(it) => [
				it.width = 190
				it.bindValueToProperty("clave")
			]
		]
	}
}
