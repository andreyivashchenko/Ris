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
-- Table structure for table `orders_list`
--

DROP TABLE IF EXISTS `orders_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_list` (
  `list_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `prod_id` int DEFAULT NULL,
  PRIMARY KEY (`list_id`),
  KEY `order_id_idx` (`order_id`),
  KEY `prod_id_idx` (`prod_id`),
  CONSTRAINT `order_id` FOREIGN KEY (`order_id`) REFERENCES `user_orders` (`order_id`),
  CONSTRAINT `prod_id` FOREIGN KEY (`prod_id`) REFERENCES `product` (`prod_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_list`
--

LOCK TABLES `orders_list` WRITE;
/*!40000 ALTER TABLE `orders_list` DISABLE KEYS */;
INSERT INTO `orders_list` VALUES (1,1,1),(2,2,1),(3,2,2),(4,2,3),(5,2,4),(6,3,2),(7,4,2),(8,4,3),(9,5,1),(10,14,2),(11,15,2),(12,16,2),(13,16,3),(14,18,2),(15,19,2),(16,20,3),(17,21,2),(18,22,2),(19,23,3),(20,24,2),(21,25,3),(22,26,2),(23,27,3),(24,28,2),(25,29,3),(26,30,1),(27,30,2),(28,30,3),(29,31,1);
/*!40000 ALTER TABLE `orders_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `prod_id` int NOT NULL AUTO_INCREMENT,
  `prod_name` varchar(45) DEFAULT NULL,
  `prod_price` int DEFAULT NULL,
  PRIMARY KEY (`prod_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'Хлеб',50),(2,'Молоко',57),(3,'Сыр',110),(4,'Сметана',90);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_1`
--

DROP TABLE IF EXISTS `report_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report_1` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name_service` varchar(45) DEFAULT NULL,
  `profit` int DEFAULT NULL,
  `sum_cli` int DEFAULT NULL,
  `year` int DEFAULT NULL,
  `month` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_1`
--

LOCK TABLES `report_1` WRITE;
/*!40000 ALTER TABLE `report_1` DISABLE KEYS */;
INSERT INTO `report_1` VALUES (25,'it_for_200',200,1,2021,1);
/*!40000 ALTER TABLE `report_1` ENABLE KEYS */;
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
  KEY `id_service1_idx` (`id_service_1`),
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_status`
--

LOCK TABLES `service_status` WRITE;
/*!40000 ALTER TABLE `service_status` DISABLE KEYS */;
INSERT INTO `service_status` VALUES (2,'2020-02-14','2020-03-11',1,2),(3,'2020-03-17',NULL,1,3),(21,'2022-12-08',NULL,1,1);
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
INSERT INTO `services` VALUES (1,'for_family',100,'2022-12-27',1),(2,'it_for_200',200,'2022-12-27',2),(3,'it_for_500',500,'2021-03-22',NULL);
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_orders`
--

DROP TABLE IF EXISTS `user_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_orders`
--

LOCK TABLES `user_orders` WRITE;
/*!40000 ALTER TABLE `user_orders` DISABLE KEYS */;
INSERT INTO `user_orders` VALUES (1,1,'2022-12-08'),(2,1,'2022-12-08'),(3,1,'2022-12-08'),(4,1,'2022-12-08'),(5,1,'2022-12-08'),(11,1,'2022-12-08'),(14,1,'2022-12-08'),(15,1,'2022-12-08'),(16,1,'2022-12-08'),(18,1,'2022-12-08'),(19,1,'2022-12-08'),(20,1,'2022-12-08'),(21,1,'2022-12-08'),(22,1,'2022-12-08'),(23,1,'2022-12-08'),(24,1,'2022-12-08'),(25,1,'2022-12-08'),(26,1,'2022-12-08'),(27,1,'2022-12-08'),(28,1,'2022-12-08'),(29,1,'2022-12-08'),(30,1,'2022-12-08'),(31,1,'2022-12-08');
/*!40000 ALTER TABLE `user_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'provaider'
--

--
-- Dumping routines for database 'provaider'
--
/*!50003 DROP PROCEDURE IF EXISTS `report_1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `report_1`(in _year int, in _month int)
BEGIN
DECLARE done INT DEFAULT 0;
	DECLARE service_name varchar(45);
	DECLARE profit int;
    DECLARE sum_cli int;
	DECLARE C1 CURSOR FOR
		select ser.name_ser, sum(ser.price_ser), count(ss.id_client ) from services as ser
		join (select * from service_status) as ss
		on ser.id_ser = ss.id_service
		where (month(ss.date_of_activation) <= _month and year(ss.date_of_activation) <= _year) and ((ss.date_of_disconnection is NULL) 
		or (month(ss.date_of_disconnection) >= _month and year(ss.date_of_disconnection) >= _year))
		group by ser.name_ser;
	DECLARE EXIT HANDLER FOR SQLSTATE '02000'
		SET done = 1;
	OPEN C1;
	WHILE done = 0 DO
		FETCH C1 INTO service_name, profit, sum_cli;
	INSERT INTO report_1 (name_service, profit, sum_cli, year, month)
	VALUES (service_name, profit, sum_cli, _year, _month);
	END WHILE;
    CLOSE C1;
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

-- Dump completed on 2022-12-27 20:20:15
