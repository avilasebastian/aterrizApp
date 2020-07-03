-- MySQL dump 10.13  Distrib 8.0.18, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: aterrizapp
-- ------------------------------------------------------
-- Server version	8.0.18

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `asiento`
--

DROP TABLE IF EXISTS `asiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asiento` (
  `idAsiento` bigint(20) NOT NULL,
  `clase` varchar(45) DEFAULT NULL,
  `numeroAsiento` varchar(45) DEFAULT NULL,
  `precio` double DEFAULT NULL,
  `ventanilla` bit(1) DEFAULT NULL,
  `Vuelo_idVuelo` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`idAsiento`),
  KEY `fk_Asiento_Vuelo_idx` (`Vuelo_idVuelo`),
  CONSTRAINT `fk_Asiento_Vuelo_idx` FOREIGN KEY (`Vuelo_idVuelo`) REFERENCES `vuelo` (`idVuelo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asiento`
--

LOCK TABLES `asiento` WRITE;
/*!40000 ALTER TABLE `asiento` DISABLE KEYS */;
INSERT INTO `asiento` VALUES (1,'Economica','V0AEC',1000,_binary '\0',NULL),(2,'Economica','V1AEC',1000,_binary '\0',NULL),(3,'Economica','V2AEC',1000,_binary '\0',61),(4,'Economica','V3AEC',1000,_binary '\0',61),(5,'Economica','V4AEC',1000,_binary '\0',61),(6,'Economica','V5AEC',1000,_binary '\0',61),(7,'Economica','V6AEC',1000,_binary '\0',NULL),(8,'Economica','V7AEC',1000,_binary '\0',NULL),(9,'Economica','V8AEC',1000,_binary '\0',62),(10,'Economica','V9AEC',1000,_binary '\0',62),(11,'Economica','V10AEC',1000,_binary '\0',62),(12,'Economica','V11AEC',1000,_binary '\0',62),(13,'Economica','V12AEC',1000,_binary '\0',NULL),(14,'Economica','V13AEC',1000,_binary '\0',NULL),(15,'Economica','V14AEC',1000,_binary '\0',63),(16,'Economica','V15AEC',1000,_binary '\0',63),(17,'Economica','V16AEC',1000,_binary '\0',63),(18,'Economica','V17AEC',1000,_binary '\0',63),(19,'Economica','V18AEC',1000,_binary '\0',NULL),(20,'Economica','V19AEC',1000,_binary '\0',NULL),(21,'Ejecutivo','V20AEJ',2000,_binary '\0',64),(22,'Ejecutivo','V21AEJ',2000,_binary '\0',64),(23,'Ejecutivo','V22AEJ',2000,_binary '\0',64),(24,'Ejecutivo','V23AEJ',2000,_binary '\0',64),(25,'Ejecutivo','V24AEJ',2000,_binary '\0',NULL),(26,'Ejecutivo','V25AEJ',2000,_binary '\0',NULL),(27,'Ejecutivo','V26AEJ',2000,_binary '\0',65),(28,'Ejecutivo','V27AEJ',2000,_binary '\0',65),(29,'Ejecutivo','V28AEJ',2000,_binary '\0',65),(30,'Ejecutivo','V29AEJ',2000,_binary '\0',65),(31,'Ejecutivo','V30AEJ',2000,_binary '\0',NULL),(32,'Ejecutivo','V31AEJ',2000,_binary '\0',NULL),(33,'Ejecutivo','V32AEJ',2000,_binary '\0',66),(34,'Ejecutivo','V33AEJ',2000,_binary '\0',66),(35,'Ejecutivo','V34AEJ',2000,_binary '\0',66),(36,'Ejecutivo','V35AEJ',2000,_binary '\0',66),(37,'Ejecutivo','V36AEJ',2000,_binary '\0',NULL),(38,'Ejecutivo','V37AEJ',2000,_binary '\0',NULL),(39,'Ejecutivo','V38AEJ',2000,_binary '\0',67),(40,'Ejecutivo','V39AEJ',2000,_binary '\0',67),(41,'Primera','V40APR',10000,_binary '',67),(42,'Primera','V41APR',10000,_binary '',67),(43,'Primera','V42APR',10000,_binary '',NULL),(44,'Primera','V43APR',10000,_binary '',NULL),(45,'Primera','V44APR',10000,_binary '',68),(46,'Primera','V45APR',10000,_binary '',68),(47,'Primera','V46APR',10000,_binary '',NULL),(48,'Primera','V47APR',10000,_binary '',NULL),(49,'Primera','V48APR',10000,_binary '',69),(50,'Primera','V49APR',10000,_binary '',69),(51,'Primera','V50APR',10000,_binary '',69),(52,'Primera','V51APR',10000,_binary '',69),(53,'Primera','V52APR',10000,_binary '',69),(54,'Primera','V53APR',10000,_binary '',69),(55,'Primera','V54APR',10000,_binary '',70),(56,'Primera','V55APR',10000,_binary '',70),(57,'Primera','V56APR',10000,_binary '',70),(58,'Primera','V57APR',10000,_binary '',70),(59,'Primera','V58APR',10000,_binary '',70),(60,'Primera','V59APR',10000,_binary '',70);
/*!40000 ALTER TABLE `asiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hibernate_sequence`
--

DROP TABLE IF EXISTS `hibernate_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hibernate_sequence` (
  `next_val` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hibernate_sequence`
--

LOCK TABLES `hibernate_sequence` WRITE;
/*!40000 ALTER TABLE `hibernate_sequence` DISABLE KEYS */;
INSERT INTO `hibernate_sequence` VALUES (97),(97),(97),(97);
/*!40000 ALTER TABLE `hibernate_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pasaje`
--

DROP TABLE IF EXISTS `pasaje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pasaje` (
  `idPasaje` bigint(20) NOT NULL,
  `fechaDeCompra` datetime DEFAULT NULL,
  `precio` double DEFAULT NULL,
  `Asiento_idAsiento` bigint(20) NOT NULL,
  `Vuelo_idVuelo` bigint(20) NOT NULL,
  `Usuario_idUsuario` bigint(20) NOT NULL,
  PRIMARY KEY (`idPasaje`),
  UNIQUE KEY `idx_Pasaje_Asiento_idx` (`Asiento_idAsiento`),
  KEY `fk_Pasaje_Vuelo_idx` (`Vuelo_idVuelo`),
  KEY `fk_Pasaje_Usuario_idx` (`Usuario_idUsuario`),
  CONSTRAINT `fk_Pasaje_Asiento_idx` FOREIGN KEY (`Asiento_idAsiento`) REFERENCES `asiento` (`idAsiento`),
  CONSTRAINT `fk_Pasaje_Usuario_idx` FOREIGN KEY (`Usuario_idUsuario`) REFERENCES `usuario` (`idUsuario`),
  CONSTRAINT `fk_Pasaje_Vuelo_idx` FOREIGN KEY (`Vuelo_idVuelo`) REFERENCES `vuelo` (`idVuelo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pasaje`
--

LOCK TABLES `pasaje` WRITE;
/*!40000 ALTER TABLE `pasaje` DISABLE KEYS */;
INSERT INTO `pasaje` VALUES (72,'2020-05-05 17:21:02',1000,1,61,71),(73,'2020-05-05 17:21:02',1000,2,61,71),(75,'2020-05-05 17:21:02',1000,7,62,74),(76,'2020-05-05 17:21:02',1000,8,62,74),(78,'2020-05-05 17:21:02',1000,14,63,77),(79,'2020-05-05 17:21:02',1000,13,63,77),(81,'2020-05-05 17:21:02',1000,19,64,80),(82,'2020-05-05 17:21:02',1000,20,64,80),(84,'2020-05-05 17:21:02',2000,26,65,83),(85,'2020-05-05 17:21:02',2000,25,65,83),(87,'2020-05-05 17:21:02',2000,32,66,86),(88,'2020-05-05 17:21:02',2000,31,66,86),(89,'2020-04-29 17:21:02',10000,47,67,86),(90,'2020-04-29 17:21:02',10000,48,69,86),(92,'2020-05-05 17:21:02',2000,38,67,91),(93,'2020-05-05 17:21:02',2000,37,67,91),(95,'2020-05-05 17:21:02',11500,43,68,94),(96,'2020-05-05 17:21:02',11500,44,68,94);
/*!40000 ALTER TABLE `pasaje` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registro_vuelo`
--

DROP TABLE IF EXISTS `registro_vuelo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registro_vuelo` (
  `idRegistro_vuelo` int(11) NOT NULL AUTO_INCREMENT,
  `idVuelo` int(11) DEFAULT NULL,
  `origen_new` varchar(30) DEFAULT NULL,
  `origen_old` varchar(30) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`idRegistro_vuelo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registro_vuelo`
--

LOCK TABLES `registro_vuelo` WRITE;
/*!40000 ALTER TABLE `registro_vuelo` DISABLE KEYS */;
/*!40000 ALTER TABLE `registro_vuelo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `idUsuario` bigint(20) NOT NULL,
  `apellido` varchar(45) DEFAULT NULL,
  `clave` varchar(45) DEFAULT NULL,
  `edad` int(11) DEFAULT NULL,
  `imagen` varchar(45) DEFAULT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `saldo` double DEFAULT NULL,
  `usuarioNombre` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (71,'Gomez','12345',46,'U1','Bonifacio',15000,'Bonifacio'),(74,'Lopez','12345',34,'U2','Clemente',12000,'Clemente'),(77,'Martinez','12345',44,'U3','Dalmacio',8000,'Dalmacio'),(80,'Garcia','12345',25,'U4','Emeterio',25000,'Emeterio'),(83,'Moyano','12345',27,'U5','Taciana',35000,'Taciana'),(86,'Campos','12345',19,'U6','Ursula',5000,'Ursula'),(91,'Soto','12345',23,'U7','Valentina',15000,'Valentina'),(94,'Chávez','12345',23,'U8','Zeferina',23000,'Zeferina');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario_usuario`
--

DROP TABLE IF EXISTS `usuario_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario_usuario` (
  `Usuario_idUsuario` bigint(20) NOT NULL,
  `Otro_Usuario_idUsuario` bigint(20) NOT NULL,
  PRIMARY KEY (`Usuario_idUsuario`,`Otro_Usuario_idUsuario`),
  KEY `fk_Otro_Usuario_idUsuario_idx` (`Otro_Usuario_idUsuario`),
  CONSTRAINT `fk_Otro_Usuario_idUsuario_idx` FOREIGN KEY (`Otro_Usuario_idUsuario`) REFERENCES `usuario` (`idUsuario`),
  CONSTRAINT `fk_Usuario_idUsuario_idx` FOREIGN KEY (`Usuario_idUsuario`) REFERENCES `usuario` (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario_usuario`
--

LOCK TABLES `usuario_usuario` WRITE;
/*!40000 ALTER TABLE `usuario_usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vuelo`
--

DROP TABLE IF EXISTS `vuelo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vuelo` (
  `DTYPE` varchar(31) NOT NULL,
  `idVuelo` bigint(20) NOT NULL,
  `aerolinea` varchar(255) DEFAULT NULL,
  `ciudadDestino` varchar(255) DEFAULT NULL,
  `ciudadOrigen` varchar(255) DEFAULT NULL,
  `partida` datetime DEFAULT NULL,
  `avion` varchar(45) DEFAULT NULL,
  `horasDeVuelo` int(11) DEFAULT NULL,
  `precio` double DEFAULT NULL,
  PRIMARY KEY (`idVuelo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vuelo`
--

LOCK TABLES `vuelo` WRITE;
/*!40000 ALTER TABLE `vuelo` DISABLE KEYS */;
INSERT INTO `vuelo` VALUES ('VueloSimple',61,'AeroPepita','Parana','Buenos Aires','2020-05-07 17:21:02','Comac 001',1,1000),('VueloSimple',62,'AeroPepita','Buenos Aires','Parana','2020-05-07 17:21:02','Comac 010',1,1000),('VueloSimple',63,'AeroPepita','Santa Fe','Buenos Aires','2020-05-08 17:21:02','Comac 001',2,1100),('VueloSimple',64,'AeroPepita','Buenos Aires','Santa Fe','2020-05-08 17:21:02','Comac 001',2,1100),('VueloSimple',65,'DodainLlegaVolando','Cordoba','Buenos Aires','2020-05-09 17:21:02','Alas de tela',3,1200),('VueloSimple',66,'DodainLlegaVolando','Buenos Aires','Cordoba','2020-05-09 17:21:02','Alas de tela',3,1200),('VueloSimple',67,'ChanchitoVolador','San Luis','Buenos Aires','2020-05-10 17:21:02','Dirigible',3,1300),('VueloSimple',68,'ChanchitoVolador','Buenos Aires','San Luis','2020-05-10 17:21:02','Dirigible',3,1300),('VueloSimple',69,'ChanchitoVolador','Cordoba','Santa Fe','2020-05-11 17:21:02','Dirigible',3,1400),('VueloConEscala',70,'Arolineas Argentinas','Cordoba','Buenos Aires','2020-05-08 17:21:02',NULL,NULL,NULL);
/*!40000 ALTER TABLE `vuelo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vuelo_vuelo`
--

DROP TABLE IF EXISTS `vuelo_vuelo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vuelo_vuelo` (
  `VueloConEscala_idVuelo` bigint(20) NOT NULL,
  `Otro_Vuelo_idVuelo` bigint(20) NOT NULL,
  `numero_de_escala` int(11) NOT NULL,
  PRIMARY KEY (`VueloConEscala_idVuelo`,`numero_de_escala`),
  KEY `fk_Otro_Vuelo_idVuelo_idx` (`Otro_Vuelo_idVuelo`),
  CONSTRAINT `fk_Otro_Vuelo_idVuelo_idx` FOREIGN KEY (`Otro_Vuelo_idVuelo`) REFERENCES `vuelo` (`idVuelo`),
  CONSTRAINT `fk_VueloConEscala_idVuelo_idx` FOREIGN KEY (`VueloConEscala_idVuelo`) REFERENCES `vuelo` (`idVuelo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vuelo_vuelo`
--

LOCK TABLES `vuelo_vuelo` WRITE;
/*!40000 ALTER TABLE `vuelo_vuelo` DISABLE KEYS */;
INSERT INTO `vuelo_vuelo` VALUES (70,63,0),(70,69,1);
/*!40000 ALTER TABLE `vuelo_vuelo` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-07 17:42:48
