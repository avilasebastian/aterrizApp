CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pasaje_de_primera`(in Destino varchar (50))
BEGIN
	select vuelo.ciudadOrigen,vuelo.ciudadDestino,pasaje.precio,asiento.clase 
	from vuelo
		inner join pasaje on pasaje.Vuelo_idVuelo=vuelo.idVuelo 
        join asiento on asiento.idAsiento = pasaje.Asiento_idAsiento
		where asiento.clase = 'Primera' and vuelo.ciudadDestino = Destino
		group by vuelo.ciudadOrigen,vuelo.ciudadDestino,pasaje.precio;
END