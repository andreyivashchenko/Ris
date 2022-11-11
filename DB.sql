-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: provaider
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `balance_history`
--

DROP TABLE IF EXISTS `balance_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `balance_history` (
  `id_bl-his` int NOT NULL AUTO_INCREMENT,
  `balance_change_date` date NOT NULL,
  `changing_the_balance` int NOT NULL,
  `id_client` int NOT NULL,
  PRIMARY KEY (`id_bl-his`),
  KEY `id_client_idx` (`id_client`),
  CONSTRAINT `id_client` FOREIGN KEY (`id_client`) REFERENCES `client` (`id_cl`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `balance_history`
--

LOCK TABLES `balance_history` WRITE;
/*!40000 ALTER TABLE `balance_history` DISABLE KEYS */;
INSERT INTO `balance_history` VALUES (3,'2020-04-07',100,2),(4,'2020-03-04',1,1),(5,'2020-03-08',-402,2),(8,'2020-03-11',232,1),(9,'2020-03-25',368,1),(10,'2020-06-15',-300,2),(11,'2020-05-19',-400,2),(12,'2020-03-29',-402,1),(13,'2020-02-19',-100,2),(14,'2020-01-01',0,1),(15,'2020-01-03',200,1),(16,'2020-01-19',100,2),(17,'2020-01-23',500,2),(20,'2020-03-03',-300,2),(21,'2020-01-01',300,3);
/*!40000 ALTER TABLE `balance_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client` (
  `id_cl` int NOT NULL,
  `name_cl` varchar(45) NOT NULL,
  `birth_cl` date NOT NULL,
  `balance` int NOT NULL DEFAULT '0',
  `date_of_last_bl_change` date DEFAULT NULL,
  PRIMARY KEY (`id_cl`),
  UNIQUE KEY `id_cl_UNIQUE` (`id_cl`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES (1,'Pavel','2000-03-15',500,NULL),(2,'Aksana','1999-04-23',200,'2020-03-03'),(3,'Dimitry','2003-11-09',800,'2020-01-01');
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `client_AFTER_UPDATE` AFTER UPDATE ON `client` FOR EACH ROW BEGIN
	insert into balance_history(changing_the_balance, balance_change_date, id_client)
	values ( (new.balance - old.balance), new.date_of_last_bl_change, old.id_cl);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `contracts`
--

DROP TABLE IF EXISTS `contracts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contracts` (
  `id_cl` int NOT NULL,
  `pass_cl` varchar(45) NOT NULL,
  `date_of_conclusion` date NOT NULL,
  `termination_date` date DEFAULT NULL,
  PRIMARY KEY (`id_cl`),
  UNIQUE KEY `pass_cl_UNIQUE` (`pass_cl`),
  UNIQUE KEY `id_cl_UNIQUE` (`id_cl`),
  CONSTRAINT `id_cl` FOREIGN KEY (`id_cl`) REFERENCES `client` (`id_cl`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contracts`
--

LOCK TABLES `contracts` WRITE;
/*!40000 ALTER TABLE `contracts` DISABLE KEYS */;
INSERT INTO `contracts` VALUES (1,'1234567891','2022-04-10',NULL),(2,'1111111111','2022-04-15',NULL),(3,'22222222222','2020-05-11',NULL);
/*!40000 ALTER TABLE `contracts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `external_user`
--

DROP TABLE IF EXISTS `external_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `external_user` (
  `user_id` int NOT NULL,
  `user_group` varchar(45) NOT NULL,
  `login` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_user`
--

LOCK TABLES `external_user` WRITE;
/*!40000 ALTER TABLE `external_user` DISABLE KEYS */;
INSERT INTO `external_user` VALUES (1,' client','cli','123');
/*!40000 ALTER TABLE `external_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `internal_user`
--

DROP TABLE IF EXISTS `internal_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `internal_user` (
  `user_id` int NOT NULL,
  `user_group` varchar(45) NOT NULL,
  `login` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `internal_user`
--

LOCK TABLES `internal_user` WRITE;
/*!40000 ALTER TABLE `internal_user` DISABLE KEYS */;
INSERT INTO `internal_user` VALUES (1,'administrator','admin','1234'),(2,'manager','man','1234'),(3,'provider','pro','1234');
/*!40000 ALTER TABLE `internal_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `request_6`
--

DROP TABLE IF EXISTS `request_6`;
/*!50001 DROP VIEW IF EXISTS `request_6`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `request_6` AS SELECT 
 1 AS `id_cl`,
 1 AS `name_cl`,
 1 AS `birth_cl`,
 1 AS `balance`,
 1 AS `date_of_last_bl_change`,
 1 AS `col`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `service_changes`
--

DROP TABLE IF EXISTS `service_changes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_changes` (
  `id_ch` int NOT NULL,
  `id_service_1` int NOT NULL,
  `date_of_change` date NOT NULL,
  `old_price` int DEFAULT NULL,
  `new_price` int NOT NULL,
  PRIMARY KEY (`id_ch`),
  KEY `id_service_idx` (`id_service_1`),
  CONSTRAINT `id_service_1` FOREIGN KEY (`id_service_1`) REFERENCES `services` (`id_ser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_changes`
--

LOCK TABLES `service_changes` WRITE;
/*!40000 ALTER TABLE `service_changes` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_changes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_status`
--

DROP TABLE IF EXISTS `service_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_status` (
  `id_ser_stat` int NOT NULL AUTO_INCREMENT,
  `date_of_activation` date DEFAULT NULL,
  `date_of_disconnection` date DEFAULT NULL,
  `id_service` int NOT NULL,
  `id_client` int NOT NULL,
  PRIMARY KEY (`id_ser_stat`),
  KEY `id_service` (`id_service`),
  KEY `id_client_2` (`id_client`),
  CONSTRAINT `id_client_1` FOREIGN KEY (`id_client`) REFERENCES `client` (`id_cl`),
  CONSTRAINT `id_service` FOREIGN KEY (`id_service`) REFERENCES `services` (`id_ser`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_status`
--

LOCK TABLES `service_status` WRITE;
/*!40000 ALTER TABLE `service_status` DISABLE KEYS */;
INSERT INTO `service_status` VALUES (1,'2020-02-15',NULL,1,1),(2,'2020-02-14',NULL,1,2),(3,'2020-03-17',NULL,1,3),(4,'2020-06-17',NULL,2,1);
/*!40000 ALTER TABLE `service_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services` (
  `id_ser` int NOT NULL,
  `name_ser` varchar(45) NOT NULL,
  `price_ser` int NOT NULL,
  `date_of_last_ser_change` date NOT NULL,
  `amount_of_clients` int DEFAULT NULL,
  PRIMARY KEY (`id_ser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,'for_family',100,'2020-03-30',1),(2,'it_for_200',200,'2020-05-11',2);
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'provaider'
--

--
-- Dumping routines for database 'provaider'
--
/*!50003 DROP PROCEDURE IF EXISTS `new_procedure` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `new_procedure`(in date_a DATE)
BEGIN
	declare done int default 0;
    declare id_client int;
    declare balance_cl int;
    declare sum int;
    declare C1 cursor for 
		select  sum(ser.price_ser) as SUM, cl.id_cl, cl.balance from service_status ss 
		join services ser on ser.id_ser = ss.id_service
		join client cl on ss.id_client = cl.id_cl
		where id_client is not null and (date_of_disconnection is null or date_of_disconnection like '0000-00-00') and date_of_activation < '2020-07-20' -- сравнение с переменной
		group by id_client;
        declare exit handler for sqlstate '02000'
			set done = 1;
		open C1;
      --  while done = 0 do
			fetch C1 into sum, id_client, balance_cl;
			select sum, id_client, balance_cl;
          -- update client set balance_cl = 1000
           -- where (id_cl = id_client);
            -- insert into balance_history (balance_change_date, changing_the_balance, id_client)
           -- values (current_date, -balance_cl, id_cl);
		-- end while;
        close C1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `request_6`
--

/*!50001 DROP VIEW IF EXISTS `request_6`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `request_6` AS select `cl`.`id_cl` AS `id_cl`,`cl`.`name_cl` AS `name_cl`,`cl`.`birth_cl` AS `birth_cl`,`cl`.`balance` AS `balance`,`cl`.`date_of_last_bl_change` AS `date_of_last_bl_change`,sum(`balance_history`.`changing_the_balance`) AS `col` from (`balance_history` join `client` `cl` on((`cl`.`id_cl` = `balance_history`.`id_client`))) where ((`balance_history`.`balance_change_date` like '2020-03-%%') and (`balance_history`.`changing_the_balance` < 0)) group by `balance_history`.`id_client` order by `balance_history`.`id_client` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-10 23:21:26
