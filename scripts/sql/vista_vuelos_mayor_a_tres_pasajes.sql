CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `aterrizApp`.`vista_vuelos_mayor_a_tres_pasajes` AS
    SELECT 
        `aterrizApp`.`PASAJE`.`Vuelo_idVuelo` AS `Vuelo_idVuelo`,
        `aterrizApp`.`VUELO`.`aerolinea` AS `aerolinea`,
        COUNT(1) AS `total`
    FROM
        (`aterrizApp`.`PASAJE`
        JOIN `aterrizApp`.`VUELO` ON ((`aterrizApp`.`PASAJE`.`Vuelo_idVuelo` = `aterrizApp`.`VUELO`.`idVuelo`)))
    GROUP BY `aterrizApp`.`PASAJE`.`Vuelo_idVuelo` , `aterrizApp`.`VUELO`.`aerolinea`
    HAVING (COUNT(1) > 2)
