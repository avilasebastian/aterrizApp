package ui.ventanas


import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import ui.modelos.ModeloPerfil
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.widgets.NumericField

class SaldoVentana extends TransactionalDialog<ModeloPerfil>{
	
	new(WindowOwner parent) {
		super(parent, new ModeloPerfil())
		title="Agregar Saldo"
	}
	override protected createFormPanel(Panel mainPanel) {
		new Label(mainPanel)=>[
				it.text=" "
				it.alignLeft
		]
		new Panel(mainPanel) => [
			layout= new HorizontalLayout
			new Label(it)=>[
				it.text="Saldo actual: $"
				it.alignLeft
				it.width = 100
			]
			new Label(it)=>[
				it.alignLeft
				it.width = 150
				it.bindValueToProperty("unUsuario.saldo")
				
			]
			
		]	
		new Panel(mainPanel)=>[
				
			layout= new HorizontalLayout
			new Label(it)=>[
				it.text="Agregar Saldo: "
				it.alignLeft
			]
			new NumericField(it)=>[
					it.width = 150
					it.alignLeft
					it.bindValueToProperty("saldoAgregado")		
			]
			
		]

		new Panel(mainPanel)=>[
			
			layout= new HorizontalLayout
			new Button(it) => [
					it.caption = "Aceptar"
					it.setWidth = 90
					onClick[
						this.modelObject.agregarSaldo()
						accept
					]
			]
			new Button(it) => [
					it.caption = "Cancelar"
					it.setWidth = 90
					onClick[close]
			]
			
		]
		
		new Label(mainPanel)=>[
				it.text=" "
				it.alignLeft
		]
	}
	
}