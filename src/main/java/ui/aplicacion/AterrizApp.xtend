package ui.aplicacion

import org.uqbar.arena.Application
import ui.ventanas.LoginVentana
import org.hibernate.service.spi.ServiceException

class AterrizApp extends Application {

	new(Bootstrap bootstrap) {
		super(bootstrap)
	}

	def static void main(String[] args) {
		var Bootstrap bootstrap

		try {
			bootstrap = new Bootstrap
			new AterrizApp(bootstrap).start()
			bootstrap.desconectar()
			bootstrap.despedida()
		} catch (ServiceException e) {
			println('''
				
				Por favor cree una la base de datos para MySQL y para MongoDB,
				 llamada `aterrizApp`;
				
			''')
		}
	}

	override protected createMainWindow() {
		return new LoginVentana(this)
	}
}
