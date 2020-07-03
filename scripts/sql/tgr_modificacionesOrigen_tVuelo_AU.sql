create table registro_vuelo(
	idRegistro_vuelo int auto_increment,
    idVuelo int,
    origen_new varchar(30),
    origen_old varchar(30),
    fecha_modificacion datetime,
    primary key (idRegistro_vuelo)
	);
 /* Creo el Trigger*/

 create trigger tgr_modificacionOrigen_AU after update
	on vuelo for each row
    insert into registro_vuelo(idVuelo,origen_new,origen_old,fecha_modificacion)
				values(old.idVuelo,new.ciudadOrigen,old.ciudadOrigen,now());