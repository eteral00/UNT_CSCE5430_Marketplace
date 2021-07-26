-- MySQL dump 10.13  Distrib 8.0.25, for Win64 (x86_64)
--
-- Host: localhost    Database: marketplace
-- ------------------------------------------------------
-- Server version	8.0.25

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
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `is_removed` bit(1) NOT NULL DEFAULT b'0',
  `product_name` varchar(255) NOT NULL,
  `product_category` varchar(50) NOT NULL,
  `product_description` text,
  `product_image_link` text,
  `unit_price` decimal(65,2) NOT NULL,
  `initial_quantity` int NOT NULL DEFAULT '1',
  `remaining_quantity` int DEFAULT NULL,
  `seller_username` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `product_id_UNIQUE` (`product_id`),
  KEY `fk_seller_user_name_idx` (`seller_username`),
  CONSTRAINT `fk_seller_username` FOREIGN KEY (`seller_username`) REFERENCES `user` (`username`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,_binary '\0','x','automobile','asadsa',NULL,1.00,1,1,NULL),(2,_binary '\0','x','automobile','asadsa',NULL,1.00,2,3,NULL),(3,_binary '\0','furniture1','Furniture','asa','uploads\\img\\1627253600167flash.jpg',1.00,1,1,NULL),(4,_binary '\0','furniture2','Furniture','adxzcx','uploads\\img\\1627253694784StaticElectricity.png',2.00,2,2,NULL),(5,_binary '\0','furniture3','Furniture','f3','uploads\\img\\1627254260666magicarp.jpg',3.00,3,3,NULL),(6,_binary '\0','furniture4','Furniture','f4','',4.00,4,4,NULL),(7,_binary '\0','electronics1','electronics','E1','uploads\\img\\1627281088326StaticElectricity.png',1.00,1,1,'user2'),(8,_binary '\0','electronics2','furniture','affsadff electronics','uploads\\img\\1627332362234StaticElectricity.png',20.00,1,1,'user3');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-07-26 17:46:33
